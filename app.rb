require "sinatra"
require "sinatra/activerecord"
require "time"
require "pp"

set :database, "sqlite3:///temper.db"

class Measure < ActiveRecord::Base
  def nice_time
    self.created_at.strftime("%Y-%m-%d %H:%M")
  end
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
  created_at = Time.parse(params[:created_at])
  Measure.where("created_at >= '#{created_at}'").map{|m| {measure: {created_at: m.nice_time, temp: m.temp}}}.to_json
end

get '/last' do
  m = Measure.last
  "<h1>#{m.created_at} : #{m.temp}</h1>"
end

get '/graph' do
  # @temps = Measure.where("created_at > '2013-09-14'").all
  #@temps = Measure.where("created_at > '2013-09-14' and created_at like '%:00'").all
  @temps = Measure.where("created_at >= '2013-10-13' and created_at like '%0'").order("id desc").limit(5)
  erb :graph
end

get '/countries' do
  erb :countries
end
