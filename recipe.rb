class Recipe
  attr_reader :name, :time, :difficulty, :ingredients, :marked, :description
  attr_writer :marked
  def initialize(args)
    @name = args[:name]
    @time = args[:time]
    @difficulty = args[:difficulty]
    @ingredients = args[:ingredients]
    @marked = args[:marked]
    @description = args[:description]
  end
end

