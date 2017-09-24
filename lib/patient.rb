class Patient
  attr_reader :id, :name, :birthday, :doctor_id

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @name = args[:name]
    @birthday = args[:birthday]
    @doctor_id = args[:doctor_id]
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.all
    patients = DB.exec("SELECT * FROM patients;")
    Patient.map_patients(patients)
  end

  def self.find(id)
    patient = DB.exec("SELECT * FROM patients WHERE id = #{id};")
    Patient.map_patients(patient).first
  end

  def self.sort_by(query)
    patients = DB.exec("SELECT * FROM patients ORDER BY #{query} ASC;")
    Patient.map_patients(patients)
  end

  def update(args, query = nil)
    case query
    when "name"
      @name = args[:name]
      DB.exec("UPDATE patients SET name = '#{@name}' WHERE id = #{self.id};")
    when "doctor_id"
      @doctor_id = args[:doctor_id]
      DB.exec("UPDATE patients SET doctor_id = #{@doctor_id} WHERE id = #{self.id};")
    end
  end

  def delete
    DB.exec("DELETE FROM patients WHERE id = #{self.id};")
  end

  def ==(other_patient)
    self.id == other_patient.id &&
    self.name == other_patient.name &&
    self.birthday == other_patient.birthday &&
    self.doctor_id == other_patient.doctor_id
  end

  #helper method

  def self.map_patients(patients)
    patients.map do |patient|
      Patient.new({
        id: patient['id'].to_i,
        name: patient['name'],
        birthday: patient['birthday'],
        doctor_id: patient['doctor_id'].to_i
        })
    end
  end
end
