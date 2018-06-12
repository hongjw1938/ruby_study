require 'sinatra'
require 'sinatra/reloader'
require 'csv'

get '/' do
    erb :index
end


get '/wildcard/:name' do
    @name = params[:name]
    erb :wildcard
end

get '/new' do
    erb :new
end

post '/create' do
    # 사용자가 입력한 정보를 받아서
    # CSV 파일 가장 마지막에 등록
    # => 이 글의 글번호도 같이 저장
    # => 기존의 글 개수 파악하여 글 개수 +1 해서 저장
    title = params[:title]
    contents = params[:contents]
    id = CSV.read('./boards.csv').count + 1
    puts id
        
    CSV.open('./boards.csv', 'a') do |row|
        row << [id, title, contents]
    end
    redirect '/boards'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
end

get '/boards' do
    # 파일을 읽기모드로 열고
    # 각 줄마다 순회하며 @가 붙어있는 변수에 넣음
    
    @boards = []
    CSV.open('./boards.csv', 'r+').each do |row|
        @boards << row
    end
    erb :boards
end

get '/board/:id' do
    # CSV 파일에서 params[:id]를 넘어온 친구와
    # 같은 글번호를 가진 row를 선택
    # => CSV파일을 전체 순회
    # => 순회하다가 첫번째 column의 id와 같은 값을 만나면 순회 정지 후 값을 변수에 담는다.
    
    @board = []
    CSV.read('./boards.csv').each do |row|
        if row[0].to_i == params[:id].to_i
            @board = row
            puts @board
            break
        end
    end
    
    erb :board
end


get '/mainpage' do
    erb :mainpage
end


get '/user/new' do
    erb :new_user 
end

post '/user/create' do
    puts params[:pw].eql?(params[:pw_confirm])
    
    
    # 우선 비밀번호와 비밀번호 확인 내용이 서로 같은지 확인한다.
    unless params[:pw].eql?(params[:pw_confirm])
        puts "비밀번호가 올바르지 않습니다."
        redirect '/error?err_co=1'
    
    # 비밀번호에 문제가 없다면
    else
        
        
        # 유저 정보 파일이 있는지 확인한다.
        unless File.file?("./user.csv")
            # 파일 생성
            CSV.open("./user.csv", "w+") do |row|
                row << [1, params[:id], params[:pw]]
            end
        
        # 유저 정보 파일이 이미 존재하는 경우
        else
            
            file = CSV.read("./user.csv", 'r+')
            idx = CSV.read("./user.csv").count + 1
            
            file.each do |row|
                if row[1].eql?(params[:id])
                    puts "같은 이름의 아이디가 이미 존재합니다. 다른 아이디를 사용하여 주십시오."
                    redirect "/error?err_co=2"
                    return
                end
            end
            
            
            CSV.open("./user.csv", "a+") do |row|
                # 확인이 끝났고 같은 아이디가 없다면 파일에 내용을 추가한다.
                row << [idx, params[:id], params[:pw]]
            end
            redirect "/user/#{idx}"
        end
        
        
        
    end
end

get '/users' do
    @users = []
    CSV.open("./user.csv", "r").each do |row|
        @users << row
    end
    
    erb :users
end

get '/user/:idx' do
    @msg = "회원가입에 성공하셨습니다."
    CSV.open("./user.csv", "r").each do |row|
        
        if params[:idx].to_i == row[0].to_i
            @id = row[1]
        end
    end
    
    erb :user
end

get '/error' do
    if params[:err_co].to_i == 1
        @msg = "비밀번호가 올바르지 않습니다."
    elsif params[:err_co].to_i == 2
        @msg = "같은 이름의 아이디가 이미 존재합니다. 다른 아이디를 사용하여 주십시오."
    end
    erb :error
    
end
