require_relative 'lib/database_connection'
require_relative 'lib/book_store'
require_relative 'lib/book_store_reposidtory'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

books = BookStoreReposidtory.new

books.all.each do |book|
  print book
end