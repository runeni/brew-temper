require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///temper.db"

class Measure < ActiveRecord::Base
end

get '/measures.json' do
  content_type :json
  Measure.where("created_at >= '2013-04-06 19:30'").all.to_json
end

get '/measure/:at' do
  content_type :json
  Measure.find_by_created_at(params[:at]).to_json
end

get '/last.json' do
  content_type :json
  Measure.last.to_json
end

get '/last' do
  m = Measure.last
  "<h1>#{m.created_at} : #{m.temp}</h1>"
end
