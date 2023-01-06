require_relative 'lib/database_connection'      
require_relative 'lib/recipe_repo'
require_relative 'lib/recipe'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipe_directory')

#Perform a SQL query on the database and get the result set.
#sql = 'SELECT id, title FROM albums;'
#result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
# result.each do |record|
#   p record
# end

library = Recipe_Repo.new

library.all.each do |meal|
    p "#{meal.meal}"
end
