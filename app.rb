require "sinatra"
require "sinatra/activerecord"
require "time"

set :database, "sqlite3:///temper.db"

class Measure < ActiveRecord::Base
end

get '/measures.json' do
  content_type :json
  Measure.all.to_json
end

get '/measure/:at' do
  content_type :json
  Measure.find_by_created_at(params[:at]).to_json
end

get '/last.json' do
  content_type :json
  Measure.last.to_json
end

get '/measures/:created_at/after.json' do
  content_type :json
  created_at = Time.parse(params[:created_at]).gmtime
  Measure.where("created_at >= '#{created_at}'").all.to_json
end

get '/last' do
  m = Measure.last
  "<h1>#{m.created_at} : #{m.temp}</h1>"
end
