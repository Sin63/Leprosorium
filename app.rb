#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'leprosorium.db'
	@db.results_as_hash = true
end

# before вызывается каждый раз при перезагрузке любой страницы
before do
	# ициализация базы данных
	 init_db
end

#  configure вызывается каждый раз при конфигурации приложения,
# когда изменился код программы и перезагрузилась страница
configure do
	# ициализация базы данных
	init_db

	# создает таблицу если она не существует
	@db.execute 'CREATE TABLE IF NOT EXISTS Posts
		 (
		 id integer PRIMARY KEY AUTOINCREMENT,
		 created_date date,
		 content text
	 )'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

# обработчик get-запроса /new
# (браузер получает страницу с сервера)
get '/new' do
	erb :new
  end

  # обработчик post-запроса /new
  # (браузер отправляет данные на сервер)
  post '/new' do
	# получаем переменную из post- запроса
	content = params[:content]
	erb "You typed #{content}"
  end  