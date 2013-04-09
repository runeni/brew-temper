require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///temper.db"

class Measure < ActiveRecord::Base
end

get '/measures' do
  Measure.all.to_json
end

get '/measure/:at' do
  Measure.find_by_created_at(params[:at]).to_json
end

get '/last.json' do
  Measure.last.to_json
end

get '/last' do
  m = Measure.last
  "<h1>#{m.created_at} : #{m.temp}</h1>"
end
