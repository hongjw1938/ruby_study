##  루비 기본
###    1. rails 사용
        * 특정 라이브러리 이외에는 설치되어 있지 않음.
        * 그러한 경우 sudo get install library명으로 설치
        * gem list : 설치된 list 확인 가능
        * 모든 것이 객체이고 메소드를 가진다.(모든 것이 메소드)
            >> 따라서 command에 1.methods라고 검색해도 1도 객체이므로 가능한 메소드를 확인할 수 있다.(rails c로 확인)
###    2. sinatra설치
        * rvm install 2.4.1
        * gem install sinatra로 설치(gem은 ruby가 사용하는 라이브러리)
            - ruby 버젼 변경을 위해선 rvm use 2.4.1
        * auto reloader
            - 코드가 변경되었을 때 자동으로 서버 리로드 시킬 수 있는 라이브러리
            - gem install sinatra-reloader
            - require 'sinatra-reloader'로 import가능
        * gem uninstall sinatra : sinatra gem을 지울 수 있음. 여러 버젼이 설치된 경우 각각이 모두 나옴
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
    * layout.erb
        - 어떤 url로 요청하더라도 views/layout으로 요청이 이동하게 된다.
        - <%= yield %> 코드를 layout.erb에 작성하면 원래 요청하던 부분으로 yield되어 본래 원하던 코드를 확인할 수 있다.
        - layout에 css 링크를 써놓으면 body태그에서 yield했을 때, 원래 코드에서 해당 css를 사용할 수 있다.
        - 참조 : day4_work/app.rb확인
        - workspace/app/views/layout/application.html.erb에 css, javascript를 지정가능
    * wildcard
        - day5/app.rb에서 /wildcard부분 참조
        - :변수 --> 를 사용해 url에 직접적으로 parameter를 전달할 수 있다.
###    5. 반복문
        * each, for, 숫자로 사용
            1) 배열객체.each |x|
                puts x
              end
                - 객체.each_with_index |x, index|
                    
                  end
                    >> 해당 코드를 통해 index도 뽑아낼 수 있다.
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
        * length
            - 객체의 길이를 구함
            - ex) "HAHAHA".length >> 6
        * reverse 
            - spits out the backward version of the object
            - puts "HAHAHA".reverse >> AHAHAH
        * upcase, downcase
            - 단어를 대,소문자로 변경
###    8. 기본 문법
        * #{}사용
            - ""사이에 String을 집어을 때 #{}를 이용하여 변수를 넣을 수 있음.(''는 불가)
            - ex) puts "현재 미세먼지 농도는 #{dust} 입니다."
        * : --> symbol
            - :name이라고 하면 name이라는 변수를 의미.
        * nil
            -nil?
                >> nil?은 해당 오브젝트가 nil인지를 판별하여 알려줍니다. 
                >> 루비에서는 오직 NilClass의 오브젝트인 nil만이 nil?에 true로 응답하며 그 외의 모든(!) 오브젝트는 false를 반환합니다.
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
        * csv
            - https://github.com/ruby/csv 참조
            - http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html 참조
            >> file IO mode
                                Mode |  Meaning
                -----+--------------------------------------------------------
                "r"  |  Read-only, starts at beginning of file  (default mode).
                -----+--------------------------------------------------------
                "r+" |  Read-write, starts at beginning of file.
                -----+--------------------------------------------------------
                "w"  |  Write-only, truncates existing file
                     |  to zero length or creates a new file for writing.
                -----+--------------------------------------------------------
                "w+" |  Read-write, truncates existing file to zero length
                     |  or creates a new file for reading and writing.
                -----+--------------------------------------------------------
                "a"  |  Write-only, starts at end of file if file exists,
                     |  otherwise creates a new file for writing.
                -----+--------------------------------------------------------
                "a+" |  Read-write, starts at end of file if file exists,
                     |  otherwise creates a new file for reading and
                     |  writing.
                -----+--------------------------------------------------------
                "b"  |  Binary file mode (may appear with
                     |  any of the key letters listed above).
                     |  Suppresses EOL <-> CRLF conversion on Windows. And
                     |  sets external encoding to ASCII-8BIT unless explicitly
                     |  specified.
                -----+--------------------------------------------------------
                "t"  |  Text file mode (may appear with
                     |  any of the key letters listed above except "b").
###     10. 웹툰 크롤링 하여 정보 읽어오기
        * day4_work 폴더 참조
        * 웹툰 정보 읽어오기
            * 필요 gem
                - Nokogiri
                - RestClient
                - JSON
                - sinatra, reloader
            * 방식
                - RestClient 라이브러리를 이용하여 웹 정보를 읽어온다
                - 응답받은 내용을 JSON라이브러리를 통해 parsing하여 해쉬 형태로 변형
                - 해쉬한 내용을 순환하여 배열에 저장
                - 배열에서 추출하고 내용을 erb로 전달
        * check_file
            * 요구조건
                - 데이터는 기본적으로 1번만 받아온다.
                - 만약 데이터가 있는 경우, 전체 목록을 불러오는 /로 리디렉션
                - 데이터가 없으면, 모든 정보를 저장하는 CSV파일을 새로 만든다.
            * 필요 gem
                - CSV
            * 방식
                - 파일이 존재하는지 File.file?()로 확인하고
                - 없으면 만든다.
                - 있으면 해당 내용을 웹으로 뿌려준다.
###     11. JS, stylesheet
        * workspace의 vendor에는 assets라는 폴더가 있다.
            >> 해당 폴더에 js, stylesheet코드 파일을 복사한다.
        * app/assets에서 해당 파일을 읽어들인다.
            >> 이후에 application.html.erb에서 지정할 수 있다.
        * 추후에 추가할 것.
###     12. CRUD (day5)
        * 구성
            - CRUD 작업
            - 자료가 저장되는 곳은 DB가 아닌 CSV파일로 저장
            - 사용자의 입력을 받아 간이 게시판 제작
            - getbootstrap.com -> get started -> css 및 js copy -> layout head에 paste
            - CSV에 게시판 내용 저장 및 읽어오기. wildcard를 이용해 url로 게시판 글 직접 접속
            - user등록을 위한 csv 파일 생성
                >> id, password, password_confirmation
                >> 조건 1 : password, password_confirmation이 다르면 회원 등록 불가
                