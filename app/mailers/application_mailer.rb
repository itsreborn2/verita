class ApplicationMailer < ActionMailer::Base
  # 기본 발신자 주소는 환경변수에서 가져옵니다.
  # SMTP_FROM가 없으면 SMTP_USER_NAME을 사용합니다. (지연평가로 필요 시에만 대체)
  default from: ENV.fetch('SMTP_FROM') { ENV.fetch('SMTP_USER_NAME') }
  layout "mailer"
end
