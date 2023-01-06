require_relative 'lib/database_connection'
require_relative 'lib/recipe_repo'
require_relative 'lib/recipe'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipe_directory')

# Perform a SQL query on the database and get the result set.
#sql = 'SELECT id, meal, mins, rating FROM recipes;'
#result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
library = Recipe_Repo.new
library.all.each do |meal|
  p "#{meal.meal} which takes #{meal.mins}m to cook. Star ratting:#{meal.rating}"
end