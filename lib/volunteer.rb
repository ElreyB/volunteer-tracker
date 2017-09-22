class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @name = args[:name]
    @project_id = args[:project_id]
  end

  def self.all
    volunteers = DB.exec("SELECT * FROM volunteers;")
    Volunteer.map_volunteers(volunteers)
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id}")
    Volunteer.map_volunteers(volunteer).first
  end

  def save
    save_return_id = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = save_return_id.first['id'].to_i
  end

  def update(args)
    @id = self.id
    @name = args[:name]
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def ==(other_volunteer)
    self.id == other_volunteer.id &&
    self.name == other_volunteer.name &&
    self.project_id == other_volunteer.project_id
  end

  #helper method
  def self.map_volunteers(volunteers)
    volunteers.map do |volunteer|
      Volunteer.new({
        id: volunteer['id'].to_i,
        name: volunteer['name'],
        project_id: volunteer['project_id'].to_i
        })
    end
  end
end
