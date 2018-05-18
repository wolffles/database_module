-- createdb school
-- psql school

CREATE TABLE students (
  student_id serial,
  first_name varchar(25),
  last_name varchar(25),

  PRIMARY KEY(student_id)
);

CREATE TABLE enrollment (
  student_id integer,
  class_id integer,
  semester text,
  year integer,
  grade varchar(1)

);

CREATE TABLE classes (
  class_id serial,
  class_name varchar(40),
  department_id integer,

  PRIMARY KEY(class_id)
);

CREATE TABLE departments(
  department_id integer,
  department_name varchar(25)

);

INSERT INTO students (first_name, last_name)
VALUES
('Wolfgang', 'Truong'),
('Jonh', 'Snow'),
('Dolores', 'Abernathy'),
('Jin', 'Yang'),
('Im','batman');

INSERT INTO departments (department_name)
VALUES
('English'),
('Math'),
('Art'),
('History'),
('science');

INSERT INTO classes (class_name, department_id)
VALUES
('Pre algebra', 2),
('Algebra', 2),
('Pre claculus', 2),
('Calculus', 2),
('English 1A', 1),
('English 1B', 1),
('Beginner''s Guitar', 3),
('Beginner''s Art', 3),
('Physics', 5),
('Chemistry', 5),
('Biology', 5),
('U.S History', 4);

INSERT INTO enrollment (student_id, class_id, semester, year, grade)
VALUES
(1, 1, 'fall', 2010, 'A'),
(1, 5, 'fall', 2010, 'A'),
(1, 9, 'fall', 2010, 'B'),
(1, 2, 'spring', 2011, 'A'),
(1, 6, 'spring', 2011, 'A'),
(1, 7, 'spring', 2011, 'A'),
(2, 1, 'fall', 2010, 'C'),
(2, 5, 'fall', 2010, 'C'),
(2, 9, 'fall', 2010, 'C'),
(3, 8, 'fall', 2010, 'A'),
(4, 7, 'fall', 2010, 'A'),
(5, 6, 'fall', 2010, 'B'),
(5, 1, 'fall', 2012, 'F'),
(5, 5, 'fall', 2012, 'A'),
(5, 9, 'fall', 2012, 'D'),
(5, 1, 'fall', 2015, 'A'),
(4, 5, 'fall', 2010, 'A'),
(4, 9, 'fall', 2010, 'B');


Select concat_ws(' ', first_name, last_name) student
From students
natural join enrollment
natural join classes
where class_name = 'Beginner''s Guitar';

Select grade, count(grade)
From enrollment
group by class_id, grade
Having class_id = 1;

Select semester, year,  c.class_name, count(student_id)
From enrollment
natural join classes c
group by class_name, semester, year
order by year;

Select semester, year,  c.class_name, count(student_id)
From enrollment
natural join classes c
group by class_name, semester, year
order by count(student_id) desc
limit 1;
