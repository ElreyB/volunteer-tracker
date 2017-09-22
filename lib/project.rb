class Project
  attr_reader :id, :title

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @title = args[:title]
  end
end
