require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @path = csv_file_path
    @list = []
    parse_recipes(@path)
  end

  def all
    @list
  end

  def add_recipe(recipe)
    @list << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @list.delete_at(recipe_index)
    update_csv
  end

  def mark_recipe(recipe_index)
    @list[recipe_index].marked = true
    update_csv
  end

  def update_csv
    # make a csv file with items in array
    CSV.open(@path, 'wb') do |csv|
      @list.each do |recipe|
        csv << [recipe.name, recipe.ingredients, recipe.time, recipe.marked, recipe.difficulty]
      end
    end
  end

  private

  def parse_recipes(path)
    CSV.foreach(path) do |row|
      name = row[0]
      ingredients = row[1]
      time = row[2]
      marked = row[3]
      args = {}
      args[:name] = name
      args[:ingredients] = ingredients
      args[:time] = time
      args[:marked] = marked == 'true'
      recipe = Recipe.new(args)
      @list << recipe
    end
  end
end
