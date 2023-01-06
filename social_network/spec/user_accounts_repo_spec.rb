require 'user_accounts'
require 'user_accounts_repo'
require 'post'

def reset_user_table
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
    describe User_Accounts_Repo do
        before(:each) do 
          reset_user_table
        end
        
        #This is for the all function 
        it 'Should display all users in the database' do 
            repo = User_Accounts_Repo.new
            library = repo.all
            expect(library.length).to eq 2
            expect(library[0].username).to eq "Shaun"
        end

        #This is for the find function
        it 'Should find all user 1 in the database' do 
            repo = User_Accounts_Repo.new
            search = repo.find(1)
            expect(search.username).to eq "Shaun"
            expect(search.email_address).to eq "shaun@email.co.uk"
        end

        #This is for the create function.

        #how it works is this INSERT INTO students (name, cohort_name) VALUES ($1, $2);
        #Then we create like our own id to insert into the function

        it 'Should create a new user in the database' do 
            repo = User_Accounts_Repo.new
            user = User_Accounts.new
            user.username = "Kirsty"
            user.email_address = "kirsty@email.co.uk"
            repo.create(user)
            expect(repo.all.length).to eq 3
        end

        #This is for the delete function.
        it 'It should delte user 1 from the database' do
            repo = User_Accounts_Repo.new
            repo.delete(1)
            expect(repo.all.length).to eq 1
        end



    end