import { Controller } from "@hotwired/stimulus"

// 파일 선택 시 파일명 표시를 위한 Stimulus 컨트롤러
export default class extends Controller {
  static targets = ["display"]

  // 커스텀 파일 선택 버튼 클릭 시 실제 파일 입력 열기
  openFileDialog() {
    const fileInput = this.element.querySelector('input[type="file"]')
    if (fileInput) {
      fileInput.click()
    }
  }

  // 파일 선택 시 호출되는 메서드
  updateFileName(event) {
    const fileInput = event.target
    const files = fileInput.files
    
    if (files && files.length > 0) {
      // 파일이 선택된 경우 파일명 표시
      const fileName = files[0].name
      this.displayTarget.textContent = fileName
      this.displayTarget.classList.remove("text-gray-500")
      this.displayTarget.classList.add("text-[#4A403A]")
    } else {
      // 파일이 선택되지 않은 경우 기본 텍스트로 복원 (UX 문구 통일)
      this.displayTarget.textContent = "이곳을 눌러 파일을 선택하세요"
      this.displayTarget.classList.remove("text-[#4A403A]")
      this.displayTarget.classList.add("text-gray-500")
    }
  }
}
