require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pg"
require "./lib/doctor"
require "./lib/patient"
require "./lib/specialty"
require "pry"

DB = PG.connect({:dbname => 'doctor_office_test'})

# DB.exec('DELETE FROM specialties *;')
# DB.exec('DELETE FROM doctors *;')
# DB.exec('DELETE FROM patients *;')

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

get('/') do
  erb(:index)
end

get('/doctors') do
  @specialties = Specialty.all
  @doctors = Doctor.all
  erb(:doctors_list)
end

get('/patients') do
  @doctors = Doctor.all
  @patients = Patient.all
  erb(:patients_list)
end

post("/doctor") do
  specialty_id = params['specialty-id'].to_i
  doctor_name = params['doctor-name']
  doctor = Doctor.new({name: doctor_name, specialty_id: specialty_id})
  doctor.save
  redirect 'doctors'
end

post('/patient') do
  doctor_id = params['doctor-id'].to_i
  patient_name = params['patient-name']
  patient_birthday = params['patient-birthday']
  patient = Patient.new({name: patient_name, birthday: patient_birthday, doctor_id: doctor_id})
  patient.save
  redirect 'patients'
end
