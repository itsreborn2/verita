# 번역 요청 메일러 - 파일 첨부 후 즉시 삭제 방식
class TranslationMailer < ApplicationMailer
  # 2025-08-21: 발신자 주소는 ApplicationMailer의 ENV 기반 설정을 따릅니다.
  # - 기본 발신자: ENV['SMTP_FROM']가 있으면 사용, 없으면 ENV['SMTP_USER_NAME']를 사용합니다.
  # - 하드코딩된 from 값을 제거하여 Gmail SMTP 인증/발신자 불일치로 인한 전송 실패를 방지합니다.
  
  # 번역 요청 메일 발송
  # 파일은 메일 발송 전용으로만 사용하며, 발송 후 자동 삭제됨
  def send_translation_request(translation_type:, name:, company:, phone:, email:, content:, attachment: nil)
    @translation_type = translation_type
    @name = name
    @company = company
    @phone = phone
    @email = email
    @content = content
    
    # 번역 유형별 제목 설정
    subject = case translation_type
              when 'urgent'
                "[긴급] 특허 번역 요청 - #{name} (#{company})"
              when 'general'
                "[일반] 특허 번역 요청 - #{name} (#{company})"
              else
                "[문의] 특허 번역 상담 - #{name} (#{company})"
              end
    
    # 파일 첨부 처리 (임시 파일로만 처리, 서버 저장 안함)
    #  - 일부 환경에서는 이전에 read가 호출되어 IO 포인터가 EOF에 있을 수 있으므로 rewind를 시도합니다.
    #  - content_type을 명시해 일부 메일 클라이언트에서 인식 문제를 방지합니다.
    #  - 파일명이 비어있는 경우 안전한 기본값을 사용합니다.
    if attachment.present?
      begin
        safe_filename = attachment.respond_to?(:original_filename) && attachment.original_filename.present? ? attachment.original_filename : "attachment"
        safe_content_type = attachment.respond_to?(:content_type) && attachment.content_type.present? ? attachment.content_type : "application/octet-stream"
        # IO 포인터 위치를 초기화(가능한 경우)
        attachment.rewind if attachment.respond_to?(:rewind)
        file_bytes = attachment.read
        attachments[safe_filename] = { mime_type: safe_content_type, content: file_bytes }
      rescue => attach_err
        # 첨부 처리 실패 시 메일 발송 자체는 진행하되, 내부 확인을 위해 제목에 [첨부 오류] 태그를 추가합니다.
        # (리턴값/플로우는 변경하지 않음)
        subject = "[첨부 오류] " + subject
      end
    end
    
    # 메일 발송 (회사 내부 메일로)
    mail(
      to: 'veritaai.korea@gmail.com',  # 실제 회사 메일 주소
      subject: subject,
      reply_to: email
    )
  end
end
