class Volunteer
  attr_reader :id, :name, :project_id

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @name = args[:name]
    @project_id = args.fetch(:id){ nil }
  end
end
