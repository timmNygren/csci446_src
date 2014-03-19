#!/usr/bin/ruby

require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/books.sqlite3.db")
require_relative 'book'

get '/' do
	erb :form
end

get '/list' do
	@sortorder = "rank"
	@bookList = Book.all
	erb :list
end

post '/list' do
  @sort = params[:sortorder]
  # sortorder to use to display chosen option back instead of 'id' or 'published'
  case @sort
    when "id"
      @sortorder = "rank"
    when "published"
      @sortorder = "published date"
    else
      @sortorder = @sort
  end
  @bookList = Book.all(order: @sort)
	erb :list
end