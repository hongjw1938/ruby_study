
#메뉴를 가져보기
menu = ["20층 메뉴", "김밥", "한솥도시락", "샐러디", "돈까스"]

ans = menu.sample(2)
puts "점심에는 "  + ans[0]  + "를 먹고 저녁에는 " + ans[1]  + "을 먹습니다."



#로또 번호 만들기
lotto_num = *(1..45)
lotto = lotto_num.sample(6).sort
puts "이번 주 추천 번호는 " + lotto.to_s + " 입니다."


#미세먼지 알아보기
require 'httparty'
# url = URI.encode("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=강남구&dataTerm=MONTH&numOfRows=100&ServiceKey=")+key
# response = HTTParty.get(url)
# dust = response['response']['body']['items']['item'][0]['pm10Value']


# case dust.to_i
#   when 0..30
#     then puts "현재 미세먼지 농도는 " + dust + " 좋음"
#   when 30..80
#     then puts "현재 미세먼지 농도는 " + dust + " 보통"
#   when 80..150
#     then puts "현재 미세먼지 농도는 " + dust + " 나쁨"
#   else
#     puts "현재 미세먼지 농도는 " + dust + " 매우 나쁨"
# end
  
# #코스피 지수 알아오기
# require 'httparty'

#HTML parsing library
require 'nokogiri'

response = HTTParty.get("http://finance.daum.net/quote/kospi.daum?nil_profile=stocktop&nil_menu=nstock27&nil_stock=refresh")
kospi = Nokogiri::HTML(response)

result = kospi.css("#hyenCost > b")

puts result.text


#날씨
