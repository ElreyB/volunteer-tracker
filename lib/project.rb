class Project
  attr_reader :id, :title

  def initialize(args)
    @id = args.fetch(:id){ nil }
    @title = args[:title]
  end

  def self.all
    projects = DB.exec("SELECT * FROM projects;")
    Project.map_projects(projects)
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    Project.map_projects(project).first
  end

  def volunteers
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    Volunteer.map_volunteers(volunteers)
  end

  def update(args)
    @title = args[:title]
    @id = self.id
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def save
    save_return_id = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = save_return_id.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id};")
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
