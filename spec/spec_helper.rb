require 'specialty'
require 'doctor'
require 'patient'
require 'note'
require 'rspec'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'doctor_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM specialties *;')
    DB.exec('DELETE FROM doctors *;')
    DB.exec('DELETE FROM patients *;')
    DB.exec('DELETE FROM notes *;')
  end
end
