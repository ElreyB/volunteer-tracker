require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require './lib/project'
require './lib/volunteer'
require 'pg'
require 'pry'

get('/') do
  erb(:index)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  title = params['title']
  project = Project.new({title: title})
  project.save
  @projects = Project.all
  redirect '/projects'
end
