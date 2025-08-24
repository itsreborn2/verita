// 다중 에이전트 시스템 데모 애니메이션 컨트롤러
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["progressBar", "agentIcon", "counterNumber", "comparisonSection"]
  
  connect() {
    // 스크롤 관찰자 설정
    this.setupScrollObserver()
    this.isAnimated = false
  }
  
  setupScrollObserver() {
    // IntersectionObserver로 섹션이 화면에 들어올 때 감지
    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting && !this.isAnimated) {
          // 섹션이 화면에 들어오면 애니메이션 시작
          this.startAnimation()
          this.isAnimated = true
        }
      })
    }, { 
      threshold: 0.3, // 30% 이상 보이면 활성화
      rootMargin: '0px 0px -50px 0px' // 약간의 여유 공간
    })
    
    // 전체 컨테이너 관찰
    this.observer.observe(this.element)
  }
  
  startAnimation() {
    // 1. 에이전트 아이콘들 순차적 활성화
    this.animateAgentIcons()
    
    // 2. 프로그레스 바 애니메이션 (지연 시작)
    setTimeout(() => {
      this.animateProgressBars()
    }, 800)
    
    // 3. 숫자 카운터 애니메이션 (더 지연)
    setTimeout(() => {
      this.animateCounters()
    }, 1200)
    
    // 4. 비교 섹션 강조 효과
    setTimeout(() => {
      this.highlightComparison()
    }, 2000)
  }
  
  animateAgentIcons() {
    // 베리타 AI 다중 에이전트 아이콘들 (A1, A2, A3, A4) 순차적 활성화
    const agentIcons = this.element.querySelectorAll('[class*="bg-[#E86A33]"][class*="rounded-full"]')
    
    agentIcons.forEach((icon, index) => {
      // 초기 상태: 작고 투명하게
      icon.style.transform = 'scale(0.5)'
      icon.style.opacity = '0.3'
      
      setTimeout(() => {
        // 순차적으로 확대 및 불투명화
        icon.style.transition = 'all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55)'
        icon.style.transform = 'scale(1.1)'
        icon.style.opacity = '1'
        
        // 잠시 후 원래 크기로 복원
        setTimeout(() => {
          icon.style.transform = 'scale(1)'
        }, 300)
        
        // 지속적인 펄스 효과 추가
        setTimeout(() => {
          icon.style.animation = 'pulse 2s infinite'
        }, 500)
        
      }, index * 200) // 200ms 간격으로 순차 실행
    })
  }
  
  animateProgressBars() {
    // 모든 프로그레스 바 애니메이션
    const progressBars = this.element.querySelectorAll('[style*="width:"]')
    
    progressBars.forEach((bar, index) => {
      // 현재 width 값 추출
      const targetWidth = bar.style.width
      
      // 초기 상태: 0%에서 시작
      bar.style.width = '0%'
      bar.style.transition = 'width 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94)'
      
      setTimeout(() => {
        // 목표 width로 애니메이션
        bar.style.width = targetWidth
        
        // 베리타 AI 바는 특별한 효과 추가
        if (bar.classList.contains('bg-[#E86A33]')) {
          bar.style.boxShadow = '0 0 10px rgba(232, 106, 51, 0.5)'
          
          // 반짝임 효과
          setTimeout(() => {
            bar.style.animation = 'shimmer 3s infinite'
          }, 1000)
        }
      }, index * 300) // 300ms 간격으로 순차 실행
    })
  }
  
  animateCounters() {
    // 숫자 카운터 애니메이션 (75% → 95% 등)
    const counterElements = this.element.querySelectorAll('.font-semibold')
    
    counterElements.forEach(element => {
      const text = element.textContent
      const match = text.match(/(\d+)%/)
      
      if (match) {
        const targetNumber = parseInt(match[1])
        const isVeritaAI = element.classList.contains('text-[#E86A33]')
        
        // 카운터 애니메이션 실행
        this.animateNumber(element, 0, targetNumber, isVeritaAI)
      }
    })
  }
  
  animateNumber(element, start, end, isVeritaAI) {
    const duration = 2000 // 2초
    const startTime = performance.now()
    
    const updateNumber = (currentTime) => {
      const elapsed = currentTime - startTime
      const progress = Math.min(elapsed / duration, 1)
      
      // easeOutCubic 이징 함수
      const easedProgress = 1 - Math.pow(1 - progress, 3)
      const currentNumber = Math.round(start + (end - start) * easedProgress)
      
      element.textContent = `${currentNumber}%`
      
      // 베리타 AI 숫자는 특별한 효과
      if (isVeritaAI && progress > 0.8) {
        element.style.textShadow = '0 0 5px rgba(232, 106, 51, 0.7)'
      }
      
      if (progress < 1) {
        requestAnimationFrame(updateNumber)
      }
    }
    
    requestAnimationFrame(updateNumber)
  }
  
  highlightComparison() {
    // 핵심 차이점 섹션 강조
    const comparisonBox = this.element.querySelector('[class*="border-[#E86A33]"]');

    if (comparisonBox) {
      // 부드러운 강조 효과
      comparisonBox.style.transition = 'all 0.8s ease'
      comparisonBox.style.transform = 'scale(1.02)'
      comparisonBox.style.boxShadow = '0 8px 25px rgba(232, 106, 51, 0.15)'
      
      // 잠시 후 원래 상태로 복원
      setTimeout(() => {
        comparisonBox.style.transform = 'scale(1)'
        comparisonBox.style.boxShadow = 'none'
      }, 1500)
    }
    
    // 기술적 우위 섹션 강조
    const techAdvantageBox = this.element.querySelector('[class*="from-[#E86A33]"]');
    
    if (techAdvantageBox) {
      techAdvantageBox.style.transition = 'all 0.8s ease'
      techAdvantageBox.style.transform = 'scale(1.01)'
      
      setTimeout(() => {
        techAdvantageBox.style.transform = 'scale(1)'
      }, 2000)
    }
  }
  
  disconnect() {
    // 관찰자 정리
    if (this.observer) {
      this.observer.disconnect()
    }
  }
}
