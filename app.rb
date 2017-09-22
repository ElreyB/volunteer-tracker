require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/project'
require './lib/volunteer'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

get('/') do
  @projects = Project.all
  erb(:index)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:projects)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

get('/volunteer/:id') do
  @volunteer = Volunteer.find(params[:id].to_i)
  @project = Project.find(@volunteer.project_id)
  erb(:volunteers)
end

post('/projects') do
  if !params['title'].empty?
    project = Project.new({title: params['title']})
    project.save
  end
  redirect '/'
end

post('/projects/:id/volunteer') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new({name: params['name'], project_id: @project.id})
  volunteer.save
  erb(:projects)
end

patch('/projects/:id/edit') do
  id = params[:id].to_i
  # binding.pry
  @project = Project.find(id)
  new_title = params['title']
  @project.update({title: new_title})
  redirect '/'
end

patch('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id].to_i)
  @project = Project.find(@volunteer.project_id)
  @volunteer.update({name: params['name']})
  erb(:volunteers)
end

delete('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect '/'
end
