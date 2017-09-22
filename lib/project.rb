class Project
  attr_reader :id, :title

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @title = args[:title]
  end

  def ==(other_project)
    self.id == other_project.id &&
    self.title == other_project.title
  end
end
