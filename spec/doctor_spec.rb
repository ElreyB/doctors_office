require 'spec_helper'

describe 'Doctor' do
  let(:doctor) { Doctor.new({name: "Dr. Smith", specialty_id: 1 }) }
  let(:doctor2) { Doctor.new({name: "Dr. Smith", specialty_id: 1}) }
  let(:doctor3) { Doctor.new({name: "Dr. Belmonti", specialty_id: 2 }) }

  describe '#initialize' do

    it 'has a readable id' do
      expect(doctor.id).to eq nil
    end

    it 'has a readable name' do
      expect(doctor.name).to eq "Dr. Smith"
    end

    it 'has a number for an id once it is saved' do
      doctor.save
      expect(doctor.id).to be_an Integer
    end

    it 'has a number for an id once it is saved' do
      doctor.save
      expect(doctor.specialty_id).to be_an Integer
    end
  end

  describe '.all' do
    it 'returns empty array when there are no doctors saved' do
      expect(Doctor.all).to eq []
    end

    it 'returns an array of doctors saved' do
      doctor2.save
      doctor3.save
      expect(Doctor.all).to eq [doctor2, doctor3]
    end
  end

  describe '#save' do
    it 'will save doctor to database' do
      doctor.save
      expect(Doctor.all).to eq [doctor]
    end
  end

  describe '.find' do
    it 'will find doctor by id' do
      doctor2.save
      doctor.save
      expect(Doctor.find(doctor.id)).to eq doctor
    end
  end

  describe '.find_specialist' do
    it 'finds doctors by specialty' do
      specialty = Specialty.new({id: 1, name: "Urology"})
      doctor.save
      doctor2.save
      doctor3.save
      expect(Doctor.find_specialist(specialty.id)).to eq [doctor, doctor2]
    end
  end

  describe '.sort_by' do
    it 'will return doctors sorted my name' do
      doctor2.save
      doctor3.save
      expect(Doctor.sort_by("name")).to eq [doctor3, doctor2]
    end

    it 'will return doctors sorted my specialty' do
      doctor3.save
      doctor2.save
      expect(Doctor.sort_by("specialty_id")).to eq [doctor2, doctor3]
    end
  end

  describe '#update_name' do
    it 'will update doctor in database' do
      doctor.save
      doctor.update_name({name: "Dr. Bartra"})
      expect(Doctor.all).to eq [doctor]
    end

    it 'will update doctor in database' do
      doctor.save
      doctor.update_name({name: "Dr. Bartra"})
      expect(doctor.name).to eq "Dr. Bartra"
    end
  end

  describe '.doctor_patient_count' do
    it 'will return doctors with patient count' do
      doctor3.save
      doctor.save
      patient = Patient.new({name: "Elrey", birthday: "1980-01-22", doctor_id: doctor.id})
      patient2 = Patient.new({name: "Elrey", birthday: "1980-01-22", doctor_id: doctor.id})
      patient3 = Patient.new({name: "Oscar", birthday: "1987-10-06", doctor_id: doctor3.id})
      patient.save
      patient2.save
      patient3.save
      expect(Doctor.doctor_patient_count).to eq [["Dr. Belmonti", "1"], ["Dr. Smith", "2"]]
    end
  end

  describe '.patients_list' do
    it 'returns a list of patients assign to doctor' do
      doctor.save
      doctor3.save
      patient = Patient.new({name: "Elrey", birthday: "1980-01-22", doctor_id: doctor.id})
      patient2 = Patient.new({name: "Elrey", birthday: "1980-01-22", doctor_id: doctor.id})
      patient3 = Patient.new({name: "Oscar", birthday: "1987-10-06", doctor_id: doctor3.id})
      patient4 = Patient.new({name: "Bob", birthday: "1987-10-06", doctor_id: doctor3.id})
      patient.save
      patient2.save
      patient3.save
      patient4.save
      expect(doctor3.patients_list).to eq [patient4, patient3]
    end
  end

  describe '#delete' do
    it 'will delete doctor from database' do
      doctor.save
      doctor.delete
      expect(Doctor.all). to eq []
    end
  end

  describe '#==' do
    it 'checks if two doctors are the same' do
      expect(doctor).to eq doctor2
    end

    it 'check it two doctors are not the same' do
      expect(doctor).not_to eq doctor3
    end
  end
end
