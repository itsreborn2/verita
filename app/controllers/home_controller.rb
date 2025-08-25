# 홈페이지 컨트롤러 - 특허 번역 서비스 랜딩페이지
class HomeController < ApplicationController
  # 랜딩페이지 메인 액션
  # GET /
  def index
    # 랜딩페이지에 표시할 통계 데이터 (마케팅용 과장된 수치)
    @stats = {
      accuracy_rate: "99.9%",           # 번역 정확도
      translation_count: "1,000,000+",  # 총 번역 건수
      customer_satisfaction: "99.8%",   # 고객 만족도
      glossary_terms: "100,000+",       # 전문 용어 수
      processing_time_reduction: "90%", # 처리 시간 단축
      security_level: "군사급"           # 보안 수준
    }

    # 고객 후기 데이터 (가상의 후기)
    @testimonials = [
      {
        name: "김○○ 변리사",
        company: "○○특허법무법인",
        comment: "특허 번역 시간이 90% 단축되었습니다. AI 멀티 에이전트 시스템이 정말 놀랍네요!",
        rating: 5
      },
      {
        name: "박○○ 연구원",
        company: "○○전자 R&D센터",
        comment: "번역 품질이 전문 번역사 수준입니다. 기술 용어 번역이 특히 정확해요.",
        rating: 5
      },
      {
        name: "이○○ IP팀장",
        company: "○○바이오",
        comment: "보안이 철저해서 안심하고 사용합니다. 중요한 특허 문서도 믿고 맡길 수 있어요.",
        rating: 5
      }
    ]

    # FAQ 데이터
    @faqs = [
      {
        question: "번역 정확도는 얼마나 되나요?",
        answer: "AI 멀티 에이전트 시스템으로 99.9% 정확도를 보장합니다. 각 전문 분야별 특화 에이전트가 동시에 작업하여 완벽한 번역 품질을 제공합니다."
      },
      {
        question: "보안은 어떻게 보장되나요?",
        answer: "군사급 암호화 기술과 ISO 27001 인증 수준의 보안 인프라를 사용합니다. 종단간 암호화(E2E)가 적용되며, 번역 완료 후 자동으로 데이터가 삭제됩니다."
      },
      {
        question: "어떤 언어를 지원하나요?",
        answer: "한국어, 영어, 일본어, 중국어를 지원합니다. 특허 문서에 특화된 전문 용어집을 바탕으로 정확한 번역을 제공합니다."
      },
      {
        question: "무료 체험은 어떻게 이용하나요?",
        answer: "회원가입 후 매월 5페이지까지 무료로 번역할 수 있습니다. 신용카드 등록 없이도 바로 체험 가능합니다."
      },
      {
        question: "번역 시간은 얼마나 걸리나요?",
        answer: "일반적으로 A4 1페이지당 2-3분 내에 번역이 완료됩니다. Premium 회원은 우선 처리로 더욱 빠른 번역이 가능합니다."
      }
    ]

    # 가격 정책 데이터
    @pricing_plans = [
      {
        name: "Free",
        price: "무료",
        period: "",
        popular: false,
        # Free 플랜 카드 표기 문구 (요청에 따라 업데이트)
        # - 첫 100페이지
        # - 3시간 이내 납품
        # - 소진된 무료 페이지 수가 넘어가면 추가 결제 후 계속 사용 가능.
        # - 무제한 수정.
        features: [
          "첫 100페이지",
          "3시간 이내 납품",
          "소진된 무료 페이지 수가 넘어가면 추가 결제 후 계속 사용 가능.",
          "무제한 수정."
        ],
        cta_text: "시작하기",
        cta_class: "btn-outline"
      },
      {
        # 일반 유료 번역 플랜 (기존 Premium 플랜 리네이밍)
        name: "일반 번역",
        # 가격 표기: 9,900원 / 1페이지(400단어)
        price: "9,900원",
        period: "/1페이지(400단어)",
        # 추천 배지 비노출을 위해 popular 비활성화
        popular: false,
        # 혜택 문구: 요청 사항 반영
        features: [
          "첫 결제액 만큼 무료 제공 1+1",
          "3시간 이내 납품(우선 처리)",
          "무제한 수정."
        ],
        cta_text: "시작하기",
        cta_class: "btn-primary"
      },
      {
        # 긴급 번역 플랜 (기존 Enterprise 플랜 리네이밍)
        name: "긴급 번역",
        price: "15,000원",
        period: "/1페이지(400단어)",
        popular: false,
        features: [
          "1시간 이내 납품(최우선 처리)",
          "무제한 수정."
        ],
        cta_text: "문의하기",
        cta_class: "btn-outline"
      }
    ]
  end

  # 가격 정책 페이지
  # GET /pricing
  # 헤더/푸터는 뷰에서 동일 마크업을 포함하여 유지합니다.
  def pricing
    # 메인(index)과 동일한 가격 정책 데이터 사용
    @pricing_plans = [
      {
        name: "Free",
        price: "무료",
        period: "/100페이지",
        popular: false,
        # Free 플랜 카드 표기 문구 (요청에 따라 업데이트)
        # - 첫 100페이지
        # - 3시간 이내 납품
        # - 무제한 수정.
        features: [
          "첫 100페이지",
          "3시간 이내 납품",
          "무제한 수정."
        ],
        cta_text: "시작하기",
        cta_class: "btn-outline"
      },
      {
        # 일반 유료 번역 플랜 (기존 Premium 플랜)
        name: "일반 번역",
        price: "9,900원",
        period: "/1페이지",
        popular: false,
        features: [
          "첫 결제액 만큼 1+1무료 제공",
          "3시간 이내 납품(우선 처리)",
          "무제한 수정."
        ],
        cta_text: "시작하기",
        cta_class: "btn-primary"
      },
      {
        # 긴급 번역 플랜 (기존 Enterprise 플랜 리네이밍)
        name: "긴급 번역",
        price: "15,000원",
        period: "/1페이지",
        popular: false,
        features: [
          "1시간 이내 납품(최우선 처리)",
          "긴급 유선 대응",
          "무제한 수정."
        ],
        cta_text: "문의하기",
        cta_class: "btn-outline"
      }
    ]
  end

  # 데모 번역 기능 (간단한 예시)
  # POST /demo_translate
  def demo_translate
    input_text = params[:text]&.strip

    if input_text.blank?
      render json: { error: "번역할 텍스트를 입력해주세요." }, status: 400
      return
    end

    # 실제로는 번역 API를 호출하지만, 데모용으로 간단한 예시 응답
    demo_translations = {
      "특허 출원" => "Patent Application",
      "발명의 명칭" => "Title of Invention",
      "기술분야" => "Technical Field",
      "배경기술" => "Background Art",
      "발명의 내용" => "Description of Invention",
      "실시예" => "Embodiments",
      "청구범위" => "Claims"
    }
    
    # 간단한 키워드 매칭으로 데모 번역 제공
    translated_text = input_text
    demo_translations.each do |korean, english|
      translated_text = translated_text.gsub(korean, english)
    end
    
    # 번역되지 않은 경우 기본 메시지
    if translated_text == input_text
      translated_text = "Translation result will appear here... (Demo version)"
    end
    
    render json: {
      original: input_text,
      translated: translated_text,
      message: "💡 실제 번역은 회원가입 후 이용 가능합니다."
    }
  end

  # 번역 요청 폼 페이지
  # GET /contact
  def contact
    # 번역 요청 폼 페이지 렌더링
    # 번역 유형: 일반 번역, 긴급 번역, 문의
    @translation_types = [
      { value: 'general', label: '일반 번역', description: '3시간 이내 납품' },
      { value: 'urgent', label: '긴급 번역', description: '1시간 이내 납품 (발송 후 10분 이내 연락)' },
      { value: 'inquiry', label: '문의', description: '번역 관련 상담 및 문의' }
    ]
  end

  # 번역 요청 메일 발송
  # POST /send_translation_request
  def send_translation_request
    # 필수 파라미터 검증
    # 2025-08-21: 사용자 요청에 따라 전화번호는 선택 항목입니다.
    # 따라서 필수 목록에서 :phone을 제외하여, 미입력 시에도 접수되도록 합니다.
    required_params = [:translation_type, :name, :company, :email, :content]
    missing_params = required_params.select { |param| params[param].blank? }

    if missing_params.any?
      flash[:error] = "필수 정보를 모두 입력해주세요: #{missing_params.join(', ')}"
      redirect_to contact_path and return
    end

    # 이메일 형식 검증
    unless params[:email].match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      flash[:error] = "올바른 이메일 주소를 입력해주세요."
      redirect_to contact_path and return
    end

    # 파일 첨부 처리 (선택사항)
    # 폼의 파일 필드 네임은 `:files` (다중 파일 지원)
    attachment_files = params[:files]
    
    # 실제 파일이 첨부된 경우만 필터링 (빈 문자열 제외)
    valid_files = attachment_files&.reject { |file| file.blank? || file.is_a?(String) }
    has_attachments = valid_files&.any?

    begin
      # 번역 요청 메일 발송
      # 파일 첨부가 있으면 동기 처리 (ActiveJob 직렬화 문제 회피)
      # 파일이 없으면 비동기 처리로 빠른 응답
      begin
        mailer = TranslationMailer.send_translation_request(
          translation_type: params[:translation_type],
          name: params[:name],
          company: params[:company],
          phone: params[:phone],
          email: params[:email],
          content: params[:content],
          attachment: valid_files
        )
        
        if has_attachments
          # 파일 첨부가 있는 경우 동기 발송
          mailer.deliver_now
        else
          # 파일이 없는 경우 비동기 발송
          mailer.deliver_later
        end

        # 2025-08-21: 사용자 요청에 따른 성공 메시지 문구 변경 (한 줄 바꿈 포함)
        flash[:success] = "요청이 발송 되었습니다.\n일반, 거래이유 통지서 번역은 3시간 이내 납품 처리되며, 긴급 번역은 번역이 시작되는 즉시 확인 안내 유선 연락을 드리겠습니다."
      rescue Net::ReadTimeout => e
        # 2025-08-21: SMTP ReadTimeout은 네트워크/서버 응답 지연으로 발생할 수 있으며,
        #   실제 SMTP 서버에서 발송이 진행되어 수신되는 경우가 있습니다.
        #   사용자 경험을 위해 성공 안내를 표시하되, 내부에는 경고 로그를 남깁니다.
        Rails.logger.warn "Translation request email timed out (read timeout), delivery may still succeed: #{e.message}"
        # ReadTimeout 상황에서도 사용자 경험을 위해 동일한 성공 안내 문구 사용
        flash[:success] = "요청이 발송 되었습니다.\n일반, 거래이유 통지서 번역은 3시간 이내 납품 처리되며, 긴급 번역은 번역이 시작되는 즉시 확인 안내 유선 연락을 드리겠습니다."
      rescue => e
        # 기타 예외는 기존과 동일하게 오류로 안내합니다. (리턴값/플로우 변경 없음)
        Rails.logger.error "Translation request email failed: #{e.message}"
        flash[:error] = "메일 발송 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요."
      end

      redirect_to contact_path
    end
  end
end
