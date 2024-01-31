.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = 'blue' AND pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = 'blue' AND pet = 'dog';


CREATE TABLE smallest_int AS
  SELECT time, smallest FROM students WHERE smallest > 2 ORDER BY smallest LIMIT 20;


CREATE TABLE matchmaker AS
  SELECT A.pet, A.song, A.color, B.color FROM students AS A, students AS B
    WHERE A.pet = B.pet AND A.song = B.song AND A.time < B.time;


CREATE TABLE sevens AS
  SELECT A.seven FROM students AS A, numbers AS B
    WHERE A.time = B.time AND A.number = 7 AND B."7" = "True";

