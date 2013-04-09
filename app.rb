require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///copy.db"

class Measure < ActiveRecord::Base
end

get '/measures' do
  Measure.all.to_json
end

get '/measure/:at' do
  Measure.find_by_created_at(params[:at]).to_json
end
