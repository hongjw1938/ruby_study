##  루비 기본
###    1. rails 사용
        * 특정 라이브러리 이외에는 설치되어 있지 않음.
        * 그러한 경우 sudo get install library명으로 설치
###    2. sinatra설치
        * rvm install 2.4.1
        * gem install sinatra로 설치(gem은 ruby가 사용하는 라이브러리)
            - ruby 버젼 변경을 위해선 rvm use 2.4.1
        * auto reloader
            - 코드가 변경되었을 때 자동으로 서버 리로드 시킬 수 있는 라이브러리
            - gem install sinatra-reloader
            - require 'sinatra-reloader'로 import가능
###    3. 루비의 리턴문
        * return 문이 없으면 가장 마지막 문장을 리턴하게 됨.
###    4. sinatra를 이용한 web 요청
    * get 메소드 사용. 자바에서는 {}를 사용했지만 루비는 do end사용
    * post 메소드를 통해 form의 method="POST"로 지정한 것과 같은 효과를 볼 수 있다.
    * mapping : '/name' 과 같이 매핑가능.
    * 관련 내용은 sinatra.rb파일 확인.
    * ""사이에 html태그를 사용하여 html코드를 넣을 수 있음.
    * MVC 패턴
        - views라는 폴더 mkdir할 것. 반드시 이름은 views
        - send_file메소드를 통해 get방식으로 요청할 수 있다. 다만, 폴더 이름을 상위에 놓아야 함. send_file 'views/html파일명'
        - parameter 찍는 방법 : puts params[:name] --> params를 사용하여 key를 가져와 value를 뽑을 수 있다.
    * erb : embedded ruby
        - ruby문서가 포함된 것이라는 의미. ruby변수를 html에서 사용하기 위해 파일명을 erb타입으로 변경(.html.erb 혹은 .erb)
        - <%= %>부분으로 표현할 수 있다.
        - view layer에서 변수를 view파일에서 사용하고 싶은 경우 @를 붙여야 한다.
            >> @name = params[:name]
            >> view에서 사용시 : <%= @name %>
        - <% %>는 코드, <%= %> 는 표현식으로 사용가능. JSP와 같음.
        - erb파일을 전송시에는 senf_file을 보통 사용하지 않음. erb : 파일명으로 사용함.(.erb로 전송하지 않음. 파일명만 보냄)
    * 서버 시작 커맨드 : ruby 파일명 -o $IP -p $PORT (c9에서 사용)
    * redirect
        - URL 리다이렉션(URL redirection← URL 넘겨주기)은 이용 가능한 웹 페이지를 하나 이상의 URL 주소로 만들어주는 월드 와이드 웹 기법이다. URL 포워딩(URL forwarding)이라고도 한다. 넘겨받은 URL을 웹 브라우저가 열려고 하면 다른 URL의 문서가 열리게 된다.
        - get방식으로만 작동한다. 따라서 get method로 해당 url에 구현해 놓아야만 한다. day3/app.rb파일 참조
    * url encode
        - 한글과 같은 경우 parameter전달 시 encoding이 필요하다. uri library를 import한 다음, uri.encoding메소드로 인코딩한다.
###    5. 반복문
        * each, for, 숫자로 사용
            1) 배열객체.each |x|
                puts x
              end
            2) for i in 배열객체
                ..
               end
            3) 3.times do
                ..
               end
            4) 3.times { .. }
###    6. 조건문
        * if
            - if (조건)
              elsif (조건)
              else
              end
        * case
            - case 조건
                when ..
                when ..
                else ..
              end
        * 실행문이 하나인 경우
            - 1줄로 작성 가능. 아래는 예시
            - count += 1 if my_lotto.include?(num)
###    7. 메소드 일부
        * sample : 랜덤 추출
            - parameter로 숫자 주면 그 개수만큼 추출
        * array
            - to_a, to_s, to_i
        * .. 문법
            - (1..3).to_a는 배열 생성 == *(1..3)
        * send_file : sinatra의 메소드
            - 파일을 전송.
###    8. 기본 문법
        * #{}사용
            - ""사이에 String을 집어을 때 #{}를 이용하여 변수를 넣을 수 있음.(''는 불가)
            - ex) puts "현재 미세먼지 농도는 #{dust} 입니다."
        * : --> symbol
            - :name이라고 하면 name이라는 변수를 의미.
###    9. 일부 라이브러리
        * HTTParty(웹 scrapping 가능)
            - get : 메소드 인자로 url을 주어 웹 페이지 정보를 읽을 수 있다.
        * Nokogiri : HTML Parsing
            - Nokogiri::HTML.parse() : HTML코드로 parsing
            - css : 선택자 가져올 수 있다. (.first, .second와 같은 예약어로 직관적으로 특정 선택자를 가져올 수 있다.)
        * RestClient : HTTParty와 같은 역할
            - get : HTTParty와 같음
        * URI
            - encode : encoding해주는 메소드
