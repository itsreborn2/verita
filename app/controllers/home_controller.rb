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
        features: [
          "월 5페이지 번역",
          "기본 번역 기능",
          "이메일 지원",
          "표준 보안"
        ],
        cta_text: "시작하기",
        cta_class: "btn-outline"
      },
      {
        name: "Premium",
        price: "99,000원",
        period: "/월",
        popular: true,
        features: [
          "무제한 번역",
          "우선 처리 (2배 빠름)",
          "전화 지원",
          "고급 보안",
          "전문 용어집 접근",
          "번역 히스토리 관리"
        ],
        cta_text: "시작하기",
        cta_class: "btn-primary"
      },
      {
        name: "Enterprise",
        price: "맞춤 견적",
        period: "",
        popular: false,
        features: [
          "전용 서버",
          "맞춤형 용어집",
          "전담 매니저",
          "API 접근",
          "온프레미스 설치",
          "24/7 지원"
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
end
