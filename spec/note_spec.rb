require 'spec_helper'

describe 'Note' do
  let(:patient_note) { Note.new({note: "set up test", created: "2017-09-24", patient_id: 1}) }
  let(:patient_note) { Note.new({note: "set up test", created: "2017-09-24", patient_id: 1}) }
  let(:patient_note) { Note.new({note: "get CT scan", created: "2014-10-03", patient_id: 1}) }

  describe '#initialize' do
    it 'has a readable note' do
      expect(patient_note.note).to eq "set up test"
    end

    it 'has a readable created date' do
      expect(patient_note.created).to eq "2017-09-24"
    end

    it 'has a readable update' do
      expect(patient_note.updated).to eq "2017-09-24"
    end

    it 'has a readable patient_id' do
      expect(patient_note.patient_id).to eq 1
    end
  end

  describe '.all' do
    context 'when there is are no notes in database' do
      it 'will return empty array' do
        expect(Note.all).to eq []
      end
    end

    context 'when there are notes in database' do
      it 'will return list of notes' do
        patient_note.save
        expect(Note.all).to eq [patient_note]
      end
    end
  end

  describe '#save' do
    it 'saves note to database' do
      patient_note.save
      expect(Note.all).to eq [patient_note]
    end
  end

  describe '.find' do
    it 'will find note by id' do
      patient_note.save
      expect(Note.find(patient_note.id)).to eq patient_note
    end
  end

  describe ''
end
