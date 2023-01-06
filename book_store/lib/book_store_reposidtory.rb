require_relative './book_store'

class BookStoreReposidtory  #works with code and such to create like new entry etc
    
    def all
        books = []
        sql = 'SELECT id, title, author_name FROM books;'
        result = DatabaseConnection.exec_params(sql, [])
        result.each do |book|
            books << book
        end
      return books
        #show all books plus their information that's in the store.
    end

    def titles
        list = []
        sql = 'SELECT title FROM books;'
        result = DatabaseConnection.exec_params(sql, [])
        result.map do |words|
        book = BookStore.new
        book.title = words['title']
        list << book.title
        end
      return list
    end

    def authors 
        list = []
        sql = 'SELECT author_name FROM books;'
        result = DatabaseConnection.exec_params(sql, [])
        result.map do |words|
        book = BookStore.new
        book.author_name = words['author_name']
        list << book.author_name
        end
      return list 
    end

    def list
        books = []
        sql = 'SELECT id, title, author_name FROM books;'
        result = DatabaseConnection.exec_params(sql, [])
        result.map do |words|
        book = BookStore.new
        book.id = words['id']
        book.title = words['title']
        book.author_name = words['author_name']
        books << words
        end
        return books
    end


end