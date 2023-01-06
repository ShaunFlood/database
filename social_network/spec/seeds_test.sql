TRUNCATE TABLE users, posts RESTART IDENTITY;

INSERT INTO users(username, email_address) VALUES('Shaun', 'shaun@email.co.uk');
INSERT INTO users(username, email_address) VALUES('Jeff', 'jeff@email.co.uk');

INSERT INTO posts(title, content, views, user_id) VALUES('Weather', 'Its really cold', 5, 1);
INSERT INTO posts(title, content, views, user_id) VALUES('Weather', 'I enjoy listening to the rain', 30, 2);