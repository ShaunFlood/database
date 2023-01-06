# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');

TRUNCATE TABLE social_network RESTART IDENTITY;

INSERT INTO posts (title, content, views) VALUES ("Weather", "It's really cold", 5)
INSERT INTO posts (title, content, views) VALUES ("Weather", "I enjoy listening to the rain", 30)

INSERT INTO user_accounts (username, email_address, post_id) VALUES ("Shaun", "shaun@email.co.uk", "1")
VALUES ("Jeff", "jeff@email.co.uk", "2")


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_social_network_test.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class User_Accounts

# Repository class
# (in lib/student_repository.rb)
class User_Accounts_Repo
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class user_accounts

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email_address
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  all, find, create and delete

   def all

   end

   def find(id)

   end

   def create

   end

   def delete

   end
  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'


#This is for the all function 

repo = User_Accounts_Repo.new
expect(repo.all.length).to eq 2
expect(repo[0].username).to eq "Shaun"
expect(repo[0].email_address).to eq "shaun@email.co.uk"

#This is for the find function

repo = User_Accounts_Repo.new
search = repo.find(1)
expect(search.username).to eq "Shaun"
expect(repo[0].email_address).to eq "shaun@email.co.uk"

#This is for the create function.

#how it works is this INSERT INTO students (name, cohort_name) VALUES ($1, $2);
#Then we create like our own id to insert into the function

repo = User_Accounts_Repo.new
user = User_Accounts.new
user.username = "Kirsty"
user.email = "kirsty@email.co.uk"
repo.create(user)
expect(repo.all.length).to eq 3

#This is for the delete function.
repo = User_Accounts_Repo.new
repo.delete(1)
expect(repo.all.length).to eq 1


Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._



#This is for the all function 
        it 'Should display all users in the database' do 
                repo = User_Accounts_Repo.new
                library = repo.all
                expect(library.length).to eq 2
                expect(library[1]).to eq 'Shaun'
        end

        #This is for the find function
        xit 'Should find all user 1 in the database' do 
            repo = User_Accounts_Repo.new
            search = repo.find(1)
            expect(search.username).to eq "Shaun"
            expect(repo[0].email_address).to eq "shaun@email.co.uk"
        end

        #This is for the create function.

        #how it works is this INSERT INTO students (name, cohort_name) VALUES ($1, $2);
        #Then we create like our own id to insert into the function

        xit 'Should create a new user in the database' do 
            repo = User_Accounts_Repo.new
            user = User_Accounts.new
            user.username = "Kirsty"
            user.email = "kirsty@email.co.uk"
            repo.create(user)
            expect(repo.all.length).to eq 3
        end

        #This is for the delete function.
        xit 'It should delte user 1 from the database' do
            repo = User_Accounts_Repo.new
            repo.delete(1)
            expect(repo.all.length).to eq 1
        end
end