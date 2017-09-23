class Doctor
  attr_reader :id, :name, :specialty_id

  def  initialize(args)
    @id = args.fetch(:id){ nil }
    @name = args[:name]
    @specialty_id = args[:specialty_id]
  end

  def self.all
    doctors = DB.exec("SELECT * FROM doctors;")
    Doctor.map_doctors(doctors)
  end

  def self.find(id)
    doctor = DB.exec("SELECT * FROM doctors WHERE id = #{id};")
    Doctor.map_doctors(doctor).first
  end

  def self.sort_by(query)
    doctors = DB.exec("SELECT * FROM doctors ORDER BY #{query} ASC;")
    Doctor.map_doctors(doctors)
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update_name(args)
    @name = args[:name]
    @id = self.id
    DB.exec("UPDATE doctors SET name = '#{@name}' WHERE id = #{@id} ")
  end

  def delete
    DB.exec("DELETE FROM doctors WHERE id = #{self.id}")
  end

  def ==(other_doctor)
    self.id == other_doctor.id &&
    self.name == other_doctor.name &&
    self.specialty_id == other_doctor.specialty_id
  end

  #helper method

  def self.map_doctors(doctors)
    doctors.map do |doctor|
      Doctor.new({
        id: doctor['id'].to_i,
        name: doctor['name'],
        specialty_id: doctor['specialty_id'].to_i
        })
    end
  end
end
