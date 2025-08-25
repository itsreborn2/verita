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
    
    # 파일 첨부 처리 (다중 파일 지원, 임시 파일로만 처리, 서버 저장 안함)
    #  - 일부 환경에서는 이전에 read가 호출되어 IO 포인터가 EOF에 있을 수 있으므로 rewind를 시도합니다.
    #  - content_type을 명시해 일부 메일 클라이언트에서 인식 문제를 방지합니다.
    #  - 파일명이 비어있는 경우 안전한 기본값을 사용합니다.
    attachment_error = false
    
    if attachment.present?
      # 단일 파일과 배열 모두 처리 가능하도록 배열로 변환
      files_to_process = attachment.is_a?(Array) ? attachment : [attachment]
      
      files_to_process.each_with_index do |file, index|
        next if file.blank? || file.is_a?(String)
        
        begin
          safe_filename = file.respond_to?(:original_filename) && file.original_filename.present? ? 
                         file.original_filename : "attachment_#{index + 1}"
          safe_content_type = file.respond_to?(:content_type) && file.content_type.present? ? 
                             file.content_type : "application/octet-stream"
          
          # IO 포인터 위치를 초기화(가능한 경우)
          file.rewind if file.respond_to?(:rewind)
          file_bytes = file.read
          
          # 파일명 중복 방지를 위해 인덱스 추가
          # attachments 객체에 직접 key? 메서드를 사용할 수 없으므로, 이미 추가된 파일 목록에서 확인합니다.
          final_filename = attachments.any? { |a| a.filename == safe_filename } ?
                           "#{File.basename(safe_filename, '.*')}_#{index + 1}#{File.extname(safe_filename)}" :
                           safe_filename
          
          attachments[final_filename] = { mime_type: safe_content_type, content: file_bytes }
        rescue => attach_err
          # 개별 파일 첨부 실패 시 로그 기록하고 계속 진행
          Rails.logger.error "File attachment failed for file #{index + 1}: #{attach_err.message}"
          attachment_error = true
        end
      end
      
      # 하나라도 첨부 오류가 있으면 제목에 표시
      if attachment_error
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
