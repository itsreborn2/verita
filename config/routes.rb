Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by uptime monitors and load balancers.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # 특허 번역 서비스 랜딩페이지 라우팅
  root "home#index"  # 메인 랜딩페이지
  
  # 데모 번역 기능 (AJAX 요청용)
  post "demo_translate", to: "home#demo_translate"
  
  # 추가 페이지들 (향후 확장)
  get "pricing", to: "home#pricing"     # 가격 정책 페이지
  get "contact", to: "home#contact"     # 번역 요청 폼 페이지
  post "send_translation_request", to: "home#send_translation_request"  # 번역 요청 메일 발송
  # get "about", to: "home#about"       # 회사 소개 페이지
end
