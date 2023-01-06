class Post_Repo
    
    def all #shows all the imputs in the database.
        list = []
        sql = 'SELECT username, email_address, id FROM users;'
        result_set = DatabaseConnection.exec_params(sql, [])
        result_set.each do |user|
            repo = User_Accounts.new
            repo.username = user['username']
            repo.email_address = user['email_address']
            repo.id = user['id']
            list << repo
        end
        return list
    end
 
    def find(id) #seraches by id for a specific input in the database.
        sql = 'SELECT username, email_address, id FROM users WHERE id = $1;'
        sql_params = [id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
            search = result_set[0]
            repo = User_Accounts.new
            repo.username = search['username']
            repo.email_address = search['email_address']
            repo.id = search['id']
            return repo
    end
 
    def create(user) #creates an new input in to the database.
        sql = 'INSERT INTO users (username, email_address) VALUES($1, $2);'
        sql_params = [user.username], [user.email_address]
        result_set = DatabaseConnection.exec_params(sql, sql_params)

        return nil 
    end
 
    def delete(id) #deletes an input from the database.
        sql = 'DELETE FROM users WHERE id = $1;'
        sql_params = [id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end


end