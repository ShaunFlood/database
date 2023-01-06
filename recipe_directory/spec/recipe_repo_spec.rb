require 'Recipe_Repo'
require 'Recipe'

def reset_recipe_table
  seed_sql = File.read('spec/seeds_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipe_directory_test' })
  connection.exec(seed_sql)
end

RSpec.describe Recipe_Repo do
  before(:each) { reset_recipe_table }

it 'Should return how many inserts are in the table' do
  library = Recipe_Repo.new
  expect(library.all.length).to eq 2
end
it 'Expect the values to be the same as the test table' do
  library = Recipe_Repo.new
  expect(library.all[0].meal).to eq "Pasta"
  expect(library.all[1].meal).to eq "Sandwich"
end
it 'Use the value 1 to find the first input in the table' do
  library = Recipe_Repo.new

  repo = library.find(1)

  expect(repo.meal).to eq "Pasta"
  expect(repo.mins).to eq "5"
  expect(repo.rating).to eq "2"
end

end
