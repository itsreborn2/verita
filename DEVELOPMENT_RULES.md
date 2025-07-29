# 특허 번역 서비스 개발 규칙 (RULES)

> **중요**: 이 파일은 개발 중 변경사항, 추가 기능, 새로운 요구사항이 있을 때마다 반드시 업데이트해야 합니다.
> 모든 개발자가 이 규칙을 숙지하고 준수해야 하며, 새로운 정보는 즉시 이 문서에 반영합니다.

## 📋 개발 원칙 (최우선 준수사항)

### 1. Rails 내장 기능 우선 사용
- **절대 원칙**: 외부 라이브러리나 gem을 추가하기 전에 Rails 내장 기능으로 해결 가능한지 먼저 확인
- Rails의 Convention over Configuration 철저히 준수
- Active Record, Action View, Action Controller 등 Rails 기본 컴포넌트 최대 활용
- 커스텀 솔루션보다는 Rails Way를 우선적으로 선택

### 2. 개발 규칙 지속 업데이트
- 새로운 기능 추가 시 → 즉시 RULES 업데이트
- 기술적 결정 변경 시 → 즉시 RULES 업데이트
- 외부 의존성 추가 시 → 즉시 RULES 업데이트
- 개발 환경 변경 시 → 즉시 RULES 업데이트

### 3. 문서화 원칙
- 모든 중요한 결정사항은 이 RULES 파일에 기록
- 코드 주석은 최대한 자세하게 작성
- 함수의 리턴값 변경 금지 (필요시 사용자에게 질문)
- 불필요한 추상화 금지

## 🔧 기술 스택 (확정된 기본 환경)

### 백엔드
- **Framework**: Ruby on Rails 8.0+ (최신 안정 버전)
- **Database**: SQLite3 (개발/스테이징/프로덕션 공통)
- **Authentication**: Devise gem (Rails 표준 인증 솔루션)
- **File Upload**: Active Storage (Rails 내장, 향후 GCS/Google Drive 연동)
- **Background Jobs**: Solid Queue (Rails 8 기본 내장)
- **Caching**: Rails.cache (메모리 캐시, 향후 Redis 고려)

### 프론트엔드 (Rails 내장 우선)
- **Template Engine**: ERB (Rails 기본)
- **JavaScript**: Stimulus (Rails 내장 JS 프레임워크)
- **HTTP**: Turbo (Rails 내장 SPA-like 경험)
- **CSS Framework**: Tailwind CSS (Rails 8 기본 통합)
- **Icons**: Heroicons (Tailwind와 호환성 우수)
- **Build Tool**: Propshaft (Rails 8 기본 에셋 파이프라인)

### 개발 환경
- **OS**: Windows + WSL2 (Ubuntu 22.04 LTS 권장)
- **Ruby Version Manager**: rbenv 또는 RVM (WSL 내에서)
- **Node.js**: nvm을 통한 최신 LTS 버전
- **Package Manager**: yarn 또는 npm

### 개발 도구
- **Linting**: RuboCop (Ruby 표준)
- **Testing**: Minitest (Rails 기본)
- **Debugging**: Rails 내장 디버거
- **Server**: Puma (Rails 기본)
- **Terminal**: Windows Terminal + WSL2

## 프로젝트 구조
```
translator/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   ├── home_controller.rb (랜딩페이지)
│   │   ├── users_controller.rb (회원관리)
│   │   └── translations_controller.rb (번역 서비스)
│   ├── models/
│   │   ├── user.rb
│   │   └── translation.rb
│   ├── views/
│   │   ├── layouts/
│   │   ├── home/
│   │   ├── users/
│   │   └── translations/
│   └── assets/
├── config/
├── db/
└── public/
```

## 개발 원칙
1. **Rails Way 준수**: Rails의 규약을 최대한 활용
2. **RESTful 설계**: 표준 REST API 구조 따름
3. **보안 우선**: CSRF, SQL Injection 등 기본 보안 적용
4. **반응형 디자인**: 모바일 우선 설계
5. **SEO 최적화**: 메타태그, 구조화된 데이터 적용

## 랜딩페이지 홍보 포인트
### 1. 멀티 에이전트 번역 시스템
- "AI 멀티 에이전트가 하나하나의 단어를 정밀 분석"
- "각 전문 분야별 특화 에이전트 동시 작업"
- "실시간 크로스 체킹으로 완벽한 번역 품질 보장"

### 2. 보안 시스템
- "군사급 보안 시스템으로 특허 정보 완벽 보호"
- "종단간 암호화(E2E) 적용"
- "ISO 27001 인증 수준의 보안 인프라"
- "번역 완료 후 자동 데이터 삭제"

### 3. 전문 용어집(Glossary)
- "10만개 이상의 특허 전문 용어 데이터베이스"
- "실시간 업데이트되는 최신 기술 용어"
- "분야별 특화 용어집 (바이오, IT, 기계, 화학 등)"
- "사용자 맞춤형 용어집 구축"

### 4. 번역 프로세스
- "7단계 정밀 번역 프로세스"
- "AI 1차 번역 → 전문가 검토 → 용어 통일 → 문맥 최적화 → 법적 검토 → 최종 검수 → 품질 보증"

## 회원 관리 시스템
### 사용자 등급
- **Guest**: 랜딩페이지 열람만 가능
- **Free**: 소량 번역 체험 (월 5페이지)
- **Premium**: 무제한 번역 + 우선 처리
- **Enterprise**: 전용 서버 + 맞춤 서비스

### 필수 기능
- 회원가입/로그인 (이메일 인증)
- 소셜 로그인 (Google, 네이버, 카카오)
- 비밀번호 재설정
- 프로필 관리
- 번역 히스토리 관리

## 데이터베이스 설계
### Users 테이블
```sql
- id (Primary Key)
- email (Unique, Not Null)
- encrypted_password
- first_name
- last_name
- company_name
- phone_number
- subscription_type (free/premium/enterprise)
- created_at
- updated_at
```

### Translations 테이블
```sql
- id (Primary Key)
- user_id (Foreign Key)
- original_filename
- translated_filename
- source_language
- target_language
- status (pending/processing/completed/failed)
- file_size
- page_count
- created_at
- updated_at
```

## 무료 디자인 리소스
- **아이콘**: Heroicons, Feather Icons, Font Awesome
- **일러스트**: unDraw, Storyset, Illustrations.co
- **이미지**: Unsplash, Pexels
- **폰트**: Google Fonts (Noto Sans KR, Inter, Roboto)
- **컬러 팔레트**: Tailwind CSS 기본 색상 + 브랜드 컬러

## 향후 확장 계획
1. **파일 업로드**: Active Storage → Google Cloud Storage 연동
2. **결제 시스템**: 아임포트 또는 토스페이먼츠 연동
3. **알림 시스템**: 이메일, SMS, 푸시 알림
4. **API 제공**: RESTful API + GraphQL
5. **모바일 앱**: React Native 또는 Flutter

## 배포 환경
- **개발**: Rails server (localhost:3000)
- **스테이징**: Heroku 또는 Railway
- **프로덕션**: AWS EC2 + RDS 또는 Google Cloud Platform

## 🔄 변경사항 추적 (CHANGELOG)

> **중요**: 새로운 기능, 기술적 결정, 의존성 변경 등이 있을 때마다 이 섹션을 업데이트합니다.

### 2025-07-22 (프로젝트 초기 설정)
- ✅ Rails 8 기반 프로젝트 구조 확정
- ✅ SQLite3 데이터베이스 선택 (개발/배포 공통)
- ✅ Tailwind CSS + Stimulus + Turbo 프론트엔드 스택 확정
- ✅ Rails 내장 기능 우선 사용 원칙 확립
- ✅ 개발 규칙 지속 업데이트 체계 구축
- ✅ **WSL2 개발 환경 설정** (Windows + Ubuntu 22.04 LTS)
  - 이유: Windows에서 Rails 개발 시 WSL이 표준 방식
  - 영향: 모든 개발 작업은 WSL 환경에서 진행
  - 추가 설정: rbenv/RVM, nvm, Windows Terminal 필요
- ✅ **Rails 8 프로젝트 생성 및 서버 실행 완료**
  - Rails 8.0.2 + Ruby 3.2.0 + Tailwind CSS + Stimulus + Turbo
  - 개발 서버: http://localhost:3000 실행 중
  - 파일 동기화: WSL ↔ Windows 완료
- ✅ **랜딩페이지 디자인 구조 설계 완료**
  - 10개 섹션 구조 설계 (Hero, 가치제안, 프로세스, 데모, 후기, 가격, FAQ 등)
  - 컬러 팔레트, 타이포그래피, 반응형 디자인 정의
  - 과장된 마케팅 포인트 구체화 (멀티 에이전트, 군사급 보안, 10만개 용어집)
- 📋 다음 단계: 홈 컨트롤러 생성 및 랜딩페이지 구현 시작

### 향후 변경사항은 여기에 추가
```
날짜: YYYY-MM-DD
변경 내용:
- ✅ 완료된 작업
- 🔄 진행 중인 작업  
- ❌ 취소/변경된 결정
- 📋 다음 단계
이유: 변경 이유 설명
영향: 다른 컴포넌트에 미치는 영향
```

## 💻 코딩 컨벤션
- **Ruby**: RuboCop 기본 설정 준수 (Rails 표준)
- **JavaScript**: Rails 내장 ESLint 설정
- **CSS**: Tailwind 유틸리티 클래스 우선, 필요시 BEM 방법론
- **Git**: Conventional Commits 형식
- **파일명**: Rails 컨벤션 준수 (snake_case)
- **클래스명**: PascalCase (Rails 표준)
- **메서드명**: snake_case (Ruby 표준)

## 🚫 금지사항 (절대 준수)
- Rails 컨벤션을 무시한 커스텀 구조 생성
- 불필요한 외부 gem 추가 (Rails 내장 기능으로 해결 가능한 경우)
- 과도한 추상화 및 복잡한 디자인 패턴 적용
- 주석 없는 복잡한 로직 작성
- 테스트 없는 핵심 기능 구현
- 하드코딩된 설정값 (환경변수 사용 필수)

## ⚠️ 주의사항
- 새로운 gem 추가 전 반드시 Rails 내장 대안 검토
- 데이터베이스 마이그레이션은 되돌릴 수 있도록 작성
- 보안 관련 설정은 Rails 기본값 준수
- 성능 최적화는 측정 후 진행 (premature optimization 금지)
