class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @name = args[:name]
    @project_id = args.fetch(:id){ nil }
  end

  def ==(other_volunteer)
    self.id == other_volunteer.id &&
    self.name == other_volunteer.name &&
    self.project_id == other_volunteer.project_id
  end
end
