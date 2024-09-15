CREATE DATABASE IF NOT EXISTS blog;
USE blog;

CREATE TABLE IF NOT EXISTS blog(
  snid int not null auto_increment primary key,
  created date,
  updated timestamp not null default current_timestamp,
  author varchar(50) not null,
  content text not null
);

INSERT INTO blog(created, author, content) VALUES('2024-02-18', 'Joe Corso', 'Go fuc.....I mean test post. >:{D-K')
