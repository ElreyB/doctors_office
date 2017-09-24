require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pg"
require "./lib/doctor"
require "./lib/patient"
require "./lib/specialty"
require "pry"

DB = PG.connect({:dbname => 'doctor_office_test'})

get('/') do
  erb(:index)
end

get('/doctors') do
  specialties = []
  File.open('specialties.txt', 'r') do |file|
    while file_line = file.gets
      specialties.push(file_line.delete("\n"))
    end
  end
  specialties = specialties.sort
  specialties.each do |specialty|
    new_specialty = Specialty.new({name: specialty})
    new_specialty.save
  end
  @specialties = Specialty.all
  erb(:doctors)
end
