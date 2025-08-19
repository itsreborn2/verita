// app/javascript/controllers/image_compare_controller.js
// 목적: 두 이미지를 나란히 보여주고, 마우스 오버 시 마우스를 따라가며 비교 영역을 표시
// 참고: https://mistral.ai/news/mistral-ocr 의 이미지 비교 기능과 유사한 구현

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["beforeImage", "afterImage", "overlay", "container"]
  static values = {
    beforeSrc: String,
    afterSrc: String
  }

  connect() {
    console.log('Image compare controller connected')
    console.log('Before src:', this.beforeSrcValue)
    console.log('After src:', this.afterSrcValue)
    this.setupOverlay()
  }

  // 오버레이 초기 설정
  setupOverlay() {
    if (this.hasOverlayTarget) {
      this.overlayTarget.style.opacity = "0"
      this.overlayTarget.style.transition = "opacity 0.3s ease"
      this.overlayTarget.style.position = "absolute"
      this.overlayTarget.style.pointerEvents = "none"
      console.log('Overlay setup complete')
    }
  }

  // 마우스 진입 시 오버레이 표시
  mouseEnter(event) {
    console.log('Mouse entered')
    if (this.hasOverlayTarget) {
      this.overlayTarget.style.opacity = "1"
    }
  }

  // 마우스 이동 시 오버레이 위치 업데이트
  mouseMove(event) {
    console.log('Mouse moving')
    if (!this.hasOverlayTarget || !this.hasContainerTarget) return

    const rect = this.containerTarget.getBoundingClientRect()
    const x = event.clientX - rect.left
    const y = event.clientY - rect.top

    // 오버레이 크기 (고정 크기로 단순화)
    const overlaySize = 150
    const halfSize = overlaySize / 2

    // 컨테이너 경계 내에서만 동작하도록 제한
    const maxX = rect.width - overlaySize
    const maxY = rect.height - overlaySize
    
    const overlayX = Math.max(0, Math.min(maxX, x - halfSize))
    const overlayY = Math.max(0, Math.min(maxY, y - halfSize))

    // 오버레이 위치 및 크기 설정
    this.overlayTarget.style.left = `${overlayX}px`
    this.overlayTarget.style.top = `${overlayY}px`
    this.overlayTarget.style.width = `${overlaySize}px`
    this.overlayTarget.style.height = `${overlaySize}px`

    // 비교 이미지 표시 (단순화)
    const afterSrc = this.afterSrcValue || "/assets/images/after_translation.png"
    this.overlayTarget.style.backgroundImage = `url(${afterSrc})`
    this.overlayTarget.style.backgroundPosition = `-${overlayX}px -${overlayY}px`
    this.overlayTarget.style.backgroundSize = `${rect.width}px ${rect.height}px`
    this.overlayTarget.style.backgroundRepeat = 'no-repeat'
  }

  // 마우스 이탈 시 오버레이 숨김
  mouseLeave(event) {
    console.log('Mouse left')
    if (this.hasOverlayTarget) {
      this.overlayTarget.style.opacity = "0"
    }
  }

  // 이미지 로드 완료 시 호출
  imageLoaded(event) {
    console.log('Image loaded:', event.target.src)
  }

  // 이미지 로드 에러 처리
  imageError(event) {
    console.error('Image failed to load:', event.target.src)
    event.target.alt = "이미지를 불러올 수 없습니다"
  }
}
