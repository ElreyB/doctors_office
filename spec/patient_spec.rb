require 'spec_helper'

describe 'Patient' do
  let(:patient) { Patient.new({name: "Elrey", birthday: "1980-01-22", doctor_id: 1 }) }
  let(:patient2) { Patient.new({name: "Elrey", birthday: "1980-01-22", doctor_id: 1}) }
  let(:patient3) { Patient.new({name: "Oscar", birthday: "1987-10-06", doctor_id: 2 }) }

  describe '#initialize' do

    it 'has a readable id' do
      expect(patient.id).to eq nil
    end

    it 'has a readable name' do
      expect(patient.name).to eq "Elrey"
    end

    it 'has a number for an id once it is saved' do
      patient.save
      expect(patient.id).to be_an Integer
    end

    it 'has a number for an id once it is saved' do
      patient.save
      expect(patient.birthday).to eq "1980-01-22"
    end

    it 'has a number for an id once it is saved' do
      patient.save
      expect(patient.doctor_id).to be_an Integer
    end
  end

  describe '.all' do
    it 'returns empty array when there are no patients saved' do
      expect(Patient.all).to eq []
    end

    it 'returns an array of patients saved' do
      patient2.save
      patient3.save
      expect(Patient.all).to eq [patient2, patient3]
    end
  end

  describe '#save' do
    it 'will save patient to database' do
      patient.save
      expect(Patient.all).to eq [patient]
    end
  end

  describe '.find' do
    it 'will find patient by id' do
      patient2.save
      patient.save
      expect(Patient.find(patient.id)).to eq patient
    end
  end

  describe '.sort_by' do
    it 'will return patients sorted my name' do
      patient2.save
      patient3.save
      expect(Patient.sort_by("name")).to eq [patient3, patient2]
    end

    it 'will return patients sorted my name' do
      patient2.save
      patient3.save
      expect(Patient.sort_by("birthday")).to eq [patient2, patient3]
    end

    it 'will return patients sorted my doctor' do
      patient3.save
      patient2.save
      expect(Patient.sort_by("doctor_id")).to eq [patient2, patient3]
    end
  end

  describe '#update_name' do
    it 'will update patient in database' do
      patient.save
      patient.update_name({name: "Osrey"})
      expect(Patient.all).to eq [patient]
    end

    it 'will update patient in database' do
      patient.save
      patient.update_name({name: "Osrey"})
      expect(patient.name).to eq "Osrey"
    end

    it 'will update patient in database' do
      patient.save
      patient.update_name({doctor_id: 1}, "doctor")
      expect(patient.doctor_id).to eq 1
    end
  end

  describe '#delete' do
    it 'will delete patient from database' do
      patient.save
      patient.delete
      expect(Patient.all). to eq []
    end
  end

  describe '#==' do
    it 'checks if two patients are the same' do
      expect(patient).to eq patient2
    end

    it 'check it two patients are not the same' do
      expect(patient).not_to eq patient3
    end
  end
end
