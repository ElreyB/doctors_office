class Specialty
  attr_reader :id, :name

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @name = args[:name]
  end

  def self.all
    specialties = DB.exec("SELECT * FROM specialties;")
    Specialty.map_specialties(specialties)
  end

  def self.find(id)
    specialty = DB.exec("SELECT * FROM specialties WHERE id = #{id};")
    Specialty.map_specialties(specialty).first
  end

  def self.sort
    specialties = DB.exec("SELECT * FROM specialties ORDER BY name ASC;")
    Specialty.map_specialties(specialties)
  end

  def save
    result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id =result.first['id'].to_i
  end

  def update(args)
    @name = args[:name]
    DB.exec("UPDATE specialties SET name = '#{@name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM specialties WHERE id = #{self.id};")
  end

  def ==(other_specialty)
    self.id == other_specialty.id &&
    self.name == other_specialty.name
  end

  #helper methods

  def self.map_specialties(specialties)
    specialties.map do |specialty|
      Specialty.new({
        id: specialty['id'].to_i,
        name: specialty['name']
        })
    end
  end
end
