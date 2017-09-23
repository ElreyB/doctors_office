require 'spec_helper'

describe 'Specialty' do
  let(:specialty) { Specialty.new({name: "Urology"}) }
  let(:specialty2) { Specialty.new({name: "Urology"}) }
  let(:specialty3) { Specialty.new({name: "Pediatrics"}) }

  describe '#initialize' do

    it 'has a readable id' do
      expect(specialty.id).to eq nil
    end

    it 'has a readable name' do
      expect(specialty.name).to eq "Urology"
    end

    it 'has a number for an id once it is saved' do
      specialty.save
      expect(specialty.id).to be_an Integer
    end
  end

  describe '.all' do
    it 'returns empty array when there are no specialties saved' do
      expect(Specialty.all).to eq []
    end

    it 'returns an array of specialties saved' do
      specialty2.save
      specialty3.save
      expect(Specialty.all).to eq [specialty2, specialty3]
    end
  end

  describe '#save' do
    it 'will save specialty to database' do
      specialty.save
      expect(Specialty.all).to eq [specialty]
    end
  end

  describe '.find' do
    it 'will find specialty by id' do
      specialty2.save
      specialty.save
      expect(Specialty.find(specialty.id)).to eq specialty
    end
  end

  describe '.sort' do
    it 'will return specialties sorted my name' do
      specialty2.save
      specialty3.save
      expect(Specialty.sort).to eq [specialty3, specialty2]
    end
  end

  describe '#update' do
    it 'will update specialty in database' do
      specialty.save
      specialty.update({name: "Radiology"})
      expect(Specialty.all).to eq [specialty]
    end

    it 'will update specialty in database' do
      specialty.save
      specialty.update({name: "Radiology"})
      expect(specialty.name).to eq "Radiology"
    end
  end

  describe '#delete' do
    it 'will delete specialty from database' do
      specialty.save
      specialty.delete
      expect(Specialty.all). to eq []
    end
  end

  describe '#==' do
    it 'checks if two specialties are the same' do
      expect(specialty).to eq specialty2
    end

    it 'check it two specialties are not the same' do
      expect(specialty).not_to eq specialty3
    end
  end
end
