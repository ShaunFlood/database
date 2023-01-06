require 'book_store_reposidtory'

def reset_book_store_table
    seed_sql = File.read('spec/seed.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end
  
 RSpec.describe BookStoreReposidtory do
    before(:each) do 
      reset_book_store_table
    end
    context 'When we ask to see all' do 
        it 'Should display that there is 5 books in the store' do 
        repo = BookStoreReposidtory.new 
        expect(repo.all.length).to eq 5
        end 
    end
    context 'When we ask to see titles' do
        it 'Should display all titles in the store' do
        repo = BookStoreReposidtory.new
        expect(repo.titles).to eq ["Nineteen Eighty-Four", "Mrs Dalloway", "Emma", "Dracula", "The Age of Innocence"]
        end
    end
    context 'When we ask to see the authors' do
        it 'Should display all authors in the store' do
            repo = BookStoreReposidtory.new
            expect(repo.authors).to eq ["George Orwell", "Virginia Woolf", "Jane Austen", "Bram Stoker", "Edith Wharton"]
        end
    end
    context 'When we ask to list of informtion' do
        it 'displays the information in correct format' do
            repo = BookStoreReposidtory.new
            expect(repo.list[0]).to eq "author_name" => "George Orwell", 
            "id" => "1", 
            "title" => "Nineteen Eighty-Four"
        end
    end
end