# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.
```

```
Nouns: user_account, email_address, username, posts, title, content, views.

Functions: 
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| Posts                 | title, content, views
| User_accounts         |  email_address, username


1. Name of the first table (always plural): `Posts` 

    Column names: `title`, `content`, 'views'

2. Name of the second table (always plural): `user_accounts` 

    Column names: `email_address`, 'username'

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: post
id: SERIAL
title: text,
content: text,
views: int

Table: user_account
id: SERIAL
username: text
email_address: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

One user can have many posts
but post can't be done without the user.

A student belongs to a cohort 

-> Therefore, the foreign key is on the albums table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.

CREATE TABLE user_accounts (
    id SERIAL PRIMARY KEY,
    username text,
    email_address text
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title text,
    content text,
    views int,
    user_accounts_id int,
    constraint fk_user_account foreign key(user_account_id)
        references user_accounts(id)
        on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 social_network < seeds.sql
```
Functions - all, find, create and delete