require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require 'json'
#HTML parsing library
require 'nokogiri'


get '/' do
    'Hello World'
end

#get을 통해 controller에 요청
#실행시 C9.io의 설정에 맞추어 실행 가능. $IP, $PORT는 C9에 지정되어 있는 환경변수임.
#ruby 파일명 -o $IP -p $PORT
#workspace명-user명.c9users.io로 확인 가능
get '/menu' do
    menu = ["20층 메뉴", "김밥", "한솥도시락", "샐러디", "돈까스"]
    ans = menu.sample(2)
    "점심에는 "  + ans[0]  + "를 먹고 저녁에는 " + ans[1]  + "을 먹습니다."
end


get '/lotto' do
    lotto_num = *(1..45)
    lotto = lotto_num.sample(6).sort
    "이번 주 추천 번호는 " + lotto.to_s + " 입니다." 
end

get '/check_lotto' do
    url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    lotto = HTTParty.get(url)
    result = JSON.parse(lotto)
    
    numbers = []
    bonus = result["bnusNo"]
    result.each do |k, v|
        if k.include?("drwtNo")
            numbers << v    #배열에 값을 넣음.
        elsif k.eql?("bnusNo")
            
        end
    end
    my_numbers = *(1..45)
    my_lotto = my_numbers.sample(6).sort
    
    count = 0
    bool_bns = false
    
    numbers.each do |num|
        bool_bns = true if my_lotto.include?(bonus)
        
        #실행문이 하나인 경우 이와 같이 작성
        count += 1 if my_lotto.include?(num)
    end
    
    rank = "당첨되지 않았습니다."
    
    
    if 3 <= count and count < 5
        rank = (count - 8) * -1
    else 
        if count >= 6
            rank = 1
        elsif count == 5 and bool_bns
            rank = 2
        end
    end
    
    "맞은 개수 : " + count.to_s + "\n" + ", rank : " + rank.to_s
end

##nokogiri와 httparty는 설치해주어야 함.
get '/kospi' do
    response = HTTParty.get("http://finance.daum.net/quote/kospi.daum?nil_profile=stocktop&nil_menu=nstock27&nil_stock=refresh")
    kospi = Nokogiri::HTML(response)

    result = kospi.css("#hyenCost > b")
    result.text
end


##HTML 코드 쓰기

get '/html' do
    "<html>
        <head></head>
        <body><h1>안녕하세요?</h1>
        </body>
    </html>"
end

get '/html_file' do
    #hash 형식으로 이루어진 parameter를 전부 읽을 수 있다.
    @name = params[:name]
    #파일 전송 가능한 sinatra의 메소드 사용
    #send_file 'views/my_first_html.html'
    
    #erb를 사용하는 경우
    erb :my_first_html
end


get '/calculator' do
    num1 = params[:num1].to_i
    num2 = params[:num2].to_i
    
    @sum = num1 + num2
    @sub = num1 - num2
    @mul = num1 * num2
    @div = num1 / num2
    
    erb :calculator
end
