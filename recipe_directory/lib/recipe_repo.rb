require_relative './recipe'

class Recipe_Repo
    
    def all
        meals = []
        sql = 'SELECT id, meal, mins, rating FROM recipes;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |record|
          meal = Recipe.new
          meal.id = record['id']
          meal.meal = record['meal']
          meal.mins = record['mins']
          meal.rating = record['rating']
    
          meals << meal
        end
        return meals
    end

    def find(id)
      sql = 'SELECT id, meal, mins, rating FROM recipes WHERE id = $1;'
      sql_parms = [id]
      result_set = DatabaseConnection.exec_params(sql, sql_parms)

      record = result_set[0]

      recipe = Recipe.new
      recipe.id = record['id']
      recipe.meal = record['meal']
      recipe.mins = record['mins']
      recipe.rating = record['rating']

      return recipe
    end

end