require 'sinatra'
require 'sinatra/reloader'
require 'nokogiri'
require 'uri'
require 'rest-client'
require 'csv'

get '/' do
    erb :index
end

get '/webtoon' do
    # 받아온 웹툰 데이터를 저장할 배열 생성
    toons = []
    # 웹툰 데이터를 받아올 url파악 및 요청보내기
    url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/mon?"
    result = RestClient.get(url)
    # 응답으로 온 내용을 해쉬 형태로 바꾸기
    webtoons = JSON.parse(result)
    
    # 해쉬해서 웹툰 리스트에 해당하는 부분 순환하기
    webtoons["data"].each do |toon|
        # 웹툰 제목
        title = toon["title"]
        # 웹툰 이미지 주소
        image = toon["thumbnailImage2"]["url"]
        # 웹툰을 볼 수 있는 주소
        link = "http://webtoon.daum.net/webtoon/view/#{toon['nickname']}"
        
        # 필요한 부분을 분리해서 처음 만든 배열에 push    
        toons << {"title" => title,
                  "image" => image,
                  "link" => link
        }
    end
    
    # 완성된 배열 중에서 3개의 웹툰만 랜덤 추출
    @daum_webtoon = toons.sample(3)
    
    
    erb :webtoon
end


get '/check_file' do
    # 비어있는 경우 nil
    unless File.file?('./webtoon.csv')
        puts "파일이 없습니다." 
        
        toons = []
        url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/mon?"
        result = RestClient.get(url)
        
        webtoons = JSON.parse(result)
        
        webtoons["data"].each do |toon|

            title = toon["title"]
            image = toon["thumbnailImage2"]["url"]
            link = "http://webtoon.daum.net/webtoon/view/#{toon['nickname']}"
            
            toons << [title, image, link]
        end
        
        puts toons
        puts "----------------------------------------------------------"
        
        # CSV 파일을 새로 생성
        CSV.open('./webtoon.csv', 'w+') do |row|
            #index를 같이 반복하여 사용가능
            toons.each_with_index do |toon, index|
               row << [index, toon[0], toon[1], toon[2]]
               puts row
           end
        end
        
        
    else
        @webtoons = []
        # 존재하는 CSV 파일을 불러오는 코드
        CSV.open('./webtoon.csv', 'r').each do |row|
            puts row
            @webtoons << row
        end
        erb :webtoons
    end
end


# 아래와 같이 사용하면 parameter로 전달가능.
get '/board/:name' do
    puts params[:name]
end


get '/check_naver_toon' do
    
    #puts params[:week].eql?(nil)
    
    unless params[:week].eql?(nil)
        
        toons = []
        
        unless File.file?("./naver_toon_#{params[:week]}.csv")
            puts "파일이 없습니다."
        
            url = RestClient.get("http://m.comic.naver.com/webtoon/weekday.nhn?week=#{params[:week]}")
            result = Nokogiri::HTML(url)
            
            image = result.css("span.im_br > img")
            title = result.css("span.toon_name > strong")
            link = result.css("div.lst > a")
            
            #puts link[0]["href"]
        
            title.each_with_index do |toon, index|
                #puts [index.to_i + 1,  image[index]["src"], title[index].text, link[index]["href"]]
                toons << [index.to_i + 1,  image[index]["src"], title[index].text, link[index]["href"]]
            end
            #puts toon_name
            
            
            CSV.open("./naver_toon_#{params[:week]}.csv", "w+") do |row|
                toons.each_with_index do |toon, index|
                    row << toons[index]
                end
            end
            
            redirect "/check_naver_toon?week=#{params[:week]}"
            
        # 파일이 있는 경우
        else
            @webtoons = []
            CSV.open("./naver_toon_#{params[:week]}.csv", "r").each do |row|
                @webtoons << row
            end
        end
    end
    erb :naver_toon
end