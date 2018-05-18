CREATE TABLE guest (
  guest_id serial,
  first_name varchar(20),
  last_name varchar(20)
);

CREATE TABLE room (
  room_id integer,
  price integer
);

CREATE TABLE booking (
  booking_id serial,
  check_in date,
  check_out date,
  guest_id integer,
  room_id integer
);
INSERT INTO guest (first_name, last_name)
VALUES
('Tony', 'Stark'),
('Robert', 'Downey'),
('Iron', 'Man'),
('stan', 'lee');

INSERT INTO room(room_id, price)
values
(101, 60),
(102, 60),
(103, 60),
(104, 60),
(201, 70),
(202, 70),
(203, 70),
(204, 70),
(301, 99),
(302, 99),
(303, 99),
(304, 99);

insert into booking (room_id, check_in, check_out)
  select room_id, check_in, check_in + interval '1 day'
  from room
  cross join generate_series('2018-01-01', '2018-01-7', interval '1 day') as check_in;

UPDATE booking
set guest_id = 4
WHERE booking_id % 5 = 0;

UPDATE booking
SET guest_id = 2
WHERE check_in = '2018-01-04'
AND room_id < 200;

UPDATE booking
SET guest_id = 1
WHERE booking_id % 3 = 0;

UPDATE booking
SET guest_id = 2
WHERE check_in IN ('2018-01-01','2018-01-02','2018-01-03')
AND room_id = 101;



-- find a guest in the database that has not booked a room.
SELECT concat_ws(' ', first_name, last_name) guest
FROM   guest g
WHERE  NOT EXISTS (
 SELECT *
 FROM   booking b
 WHERE  g.guest_id = b.guest_id
 );
-- #=>
-- guest
-- Iron Man

-- Find bookings for a guest who has booked two rooms for the same dates.
  SELECT check_in, guest_id, count(guest_id)
  FROM booking
  group by check_in, guest_id
  Having count(guest_id) >= 2
  AND guest_id = 2;
  --#=>
  -- check_in	guest_id	count
  -- 2018-01-04	2	     3

-- Find bookings for a guest who has booked one room several times on different dates.
  SELECT guest_id, room_id, count(check_in) days_booked
  FROM booking b
  GROUP BY guest_id, room_id
  HAVING guest_id = 2
  AND count(check_in) >= 2;
  -- #=>
  -- guest_id	room_id	days_booked
  -- 2	         101	    4

-- Count the number of unique guests who have booked the same room.
  SELECT room_id, COUNT(DISTINCT guest_id)
  FROM booking b
  WHERE room_id = 102
  GROUP BY room_id
  -- #=>
  -- room_id	count
  -- 102	2
