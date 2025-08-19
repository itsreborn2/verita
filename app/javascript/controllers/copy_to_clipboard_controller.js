// app/javascript/controllers/copy_to_clipboard_controller.js
// 목적: "무료 번역 시작하기" 버튼 클릭 시 지정된 이메일 주소를 클립보드로 복사
// 주의: 불필요한 콘솔 로그는 제거하고, 접근성 및 사용자 피드백(텍스트 변경)을 포함합니다.
// 반환값 변경 금지 원칙: Stimulus 액션 핸들러는 반환값을 사용하지 않으므로 명시적 리턴값 변경 없음.

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["label"]
  static values = {
    email: String,
    successText: { type: String, default: "이메일이 복사되었습니다." },
    copiedClass: { type: String, default: "ring-2 ring-offset-2 ring-orange-400" },
    revertMs: { type: Number, default: 1800 }
  }

  // 클릭 핸들러: 앵커 기본 동작(# 이동)을 차단하고 복사 로직 수행
  async copy(event) {
    if (event) event.preventDefault()

    const emailToCopy = this.emailValue || "contact@verita-ai.example" // 안전한 목업 도메인(.example)

    // 클립보드 API 사용: 가용 시 우선 적용
    try {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        await navigator.clipboard.writeText(emailToCopy)
      } else {
        // 폴백: 임시 textarea 생성 후 execCommand("copy") 사용
        this.#legacyCopy(emailToCopy)
      }

      // 사용자 피드백: 버튼 라벨 변경 및 하이라이트 클래스 적용
      this.#withFeedback(() => {
        const originalText = this.#currentLabelText()
        this.#setLabelText(this.successTextValue)
        this.element.classList.add(this.copiedClassValue)
        // 일정 시간 후 원복
        window.setTimeout(() => {
          this.#setLabelText(originalText)
          this.element.classList.remove(this.copiedClassValue)
        }, this.revertMsValue)
      })
    } catch (_) {
      // 실패 시에도 기본적인 피드백 제공 (네트워크/권한 이슈 등)
      this.#withFeedback(() => {
        const originalText = this.#currentLabelText()
        this.#setLabelText("복사를 다시 시도해 주세요")
        window.setTimeout(() => this.#setLabelText(originalText), this.revertMsValue)
      })
    }
  }

  // 내부 유틸: execCommand 기반 복사 (구형 브라우저/권한 제한 폴백)
  #legacyCopy(text) {
    const temp = document.createElement("textarea")
    temp.value = text
    temp.setAttribute("readonly", "")
    temp.style.position = "absolute"
    temp.style.left = "-9999px"
    document.body.appendChild(temp)
    temp.select()
    document.execCommand("copy")
    document.body.removeChild(temp)
  }

  // 내부 유틸: 현재 라벨 텍스트 획득
  #currentLabelText() {
    if (this.hasLabelTarget) {
      return (this.labelTarget.textContent || "").trim()
    }
    return (this.element.textContent || "").trim()
  }

  // 내부 유틸: 라벨 텍스트 설정
  #setLabelText(text) {
    if (this.hasLabelTarget) {
      this.labelTarget.textContent = text
    } else {
      this.element.textContent = text
    }
  }

  // 내부 유틸: 포커스/접근성 보조
  #withFeedback(callback) {
    try {
      if (typeof callback === "function") callback()
      // 시각 사용자 외를 위해 ARIA 라이브 영역 알림(간단 구현)
      this.element.setAttribute("aria-live", "polite")
      this.element.setAttribute("role", "status")
    } catch (_) {
      // 조용히 실패 무시 (불필요 로그 방지)
    }
  }
}
