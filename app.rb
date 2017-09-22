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

get('/edit/:id') do
  id = params[:id].to_i
  @project = Project.find(id)
  erb(:edit_project)
end

post('/projects') do
  title = params['title']
  project = Project.new({title: title})
  project.save
  redirect '/'
end

patch('/edit/:id') do
  id = params[:id].to_i
  # binding.pry
  @project = Project.find(id)
  new_title = params['title']
  @project.update({title: new_title})
  redirect '/'
end
