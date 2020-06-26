ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :console do
  Pry.start
end

namespace :db do
  desc "Load all brewing ingredients into the database"
  task :load do
    csv = File.read('./public/data/ingredients.csv')
    csv_object = CSV.parse(csv)

    csv_object.each do |row|
      Ingredient.find_or_create_by(name: row[0], type_of: row[1])
    end
  end
end