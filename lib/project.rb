class Project
  attr_reader :id, :title

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @title = args[:title]
  end

  def self.all
    projects = DB.exec("SELECT * FROM projects;")
    map_projects(projects)
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id}")
    map_projects(project)
  end

  def save
    save_return_id = DB.exec("INSERT INTO projects (title) values ('#{@title}') RETURNING id")
    @id = save_return_id.first['id'].to_i
  end

  def ==(other_project)
    self.id == other_project.id &&
    self.title == other_project.title
  end

  #helper method
  def self.map_projects(projects)
    projects.map do |project|
      Project.new({
        id: project['id'].to_i,
        title: project['title']
        })
    end
  end
end
