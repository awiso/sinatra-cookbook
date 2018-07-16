require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'cookbook'

csv_file = File.join(__dir__, 'recipes.csv')

COOKBOOK = Cookbook.new(csv_file)
# @recipes = @cookbook.all

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# ROUTES:

# home - list all recipes in the cookbook
get '/' do
  @recipes = COOKBOOK.all
  erb :index
end

# new - form to submit new recipe
get '/new' do
  erb :new
end

# submission action
post '/recipe' do
  # {"name"=>"a", "desc"=>"a", "time"=>"a", "ingredients"=>"a"}
  recipe = Recipe.new(name: params[:name], time: params[:time], difficulty: params[:difficulty], ingredients: params[:ingredients], marked: false, description: params[:desc])
  COOKBOOK.add_recipe(recipe)
  redirect '/'
end

# deletion action
get '/delete/:index' do

  COOKBOOK.remove_recipe(params[:index].to_i)

  redirect '/'
end
