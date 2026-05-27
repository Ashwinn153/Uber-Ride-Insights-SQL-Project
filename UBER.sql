CREATE DATABASE UBER;
USE UBER;

show tables;

#Basic

#1 What are & how many unique pickup locations are there in the dataset?
select DISTINCT pickup_location from Rides;
select COUNT(DISTINCT pickup_location) from Rides; `Column12`

#2 What is the total number of rides in the dataset?
SELECT COUNT(ride_id) from rides;

#3 Calculate the average ride duration.
SELECT AVG(ride_duration) from Rides;

#4 List the top 5 drivers based on their total earnings.
SELECT driver_id,driver_name,SUM(earnings) from drivers
GROUP BY driver_id, driver_name
ORDER BY SUM(earnings) DESC
LIMIT 5;

#5 Calculate the total number of rides for each payment method.
SELECT payment_method, COUNT(*) from Rides
GROUP BY payment_method;

#6 Retrieve rides with a fare amount greater than 20.
select fare_amount from rides
WHERE fare_amount > 20;

#7 Identify the most common pickup location.
select pickup_location, COUNT(*) from rides
GROUP BY pickup_location
ORDER BY COUNT(*) DESC
LIMIT 1;

#8 Calculate the average fare amount.
select avg(fare_amount) from rides;

#9 List the top 10 drivers with the highest average ratings.
SELECT driver_id,driver_name,AVG(rating)FROM drivers
GROUP BY driver_id, driver_name
ORDER BY AVG(rating) DESC
LIMIT 10;

#10 Calculate the total earnings for all drivers.
select sum(earnings) as total_earnings from drivers;

#11 How many rides were paid using the "Cash" payment method?
SELECT payment_method, COUNT(*) from rides
where payment_method = 'Cash'
GROUP BY payment_method;

#12 Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
select avg(ride_distance),count(*) from rides 
where pickup_location = "Dhanbad";

#13 Retrieve rides with a ride duration less than 10 minutes.
SELECT ride_duration ,count(*) from rides
WHERE ride_duration < 10;

#14 List the passengers who have taken the most number of rides.
select passenger_name, total_rides from passengers
where total_rides = (select MAX(total_rides) from passengers);

#15 Calculate the total number of rides for each driver in descending order.
select total_rides, driver_name from drivers
order by total_rides DESC;

#16 Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
select passenger_id,payment_method from rides
where pickup_location = "Gandhinagar";

#17 Calculate the average fare amount for rides with a ride distance greater than 10.
select avg(fare_amount) from rides
where ride_distance > 10;

#18 List the drivers in descending order according to their total number of rides.
select driver_name, total_rides from drivers
order by total_rides DESC;

#19 Calculate the percentage distribution of rides for each pickup location.
SELECT pickup_location,
COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rides) as Percentage
FROM rides
GROUP BY pickup_location;

#20 Retrieve rides where both pickup and dropoff locations are the same.
select ride_id from rides
where pickup_location = dropoff_location;

#intermediate

#1 List the passengers who have taken rides from at least 300 different pickup locations.
SELECT p.passenger_name,COUNT (DISTINCT r.pickup_location) total from passengers p
join rides r
on p.passenger_id = r.passenger_id
GROUP BY p.passenger_name
HAVING total >300;

#2 Calculate the average fare amount for rides taken on weekdays.
select AVG(fare_amount) from rides
WHERE WEEKDAY(ride_timestamp);

#3 Identify the drivers who have taken rides with distances greater than 19.
select distinct driver_id from rides
where ride_distance >19;

#4 Calculate the total earnings for drivers who have completed more than 100 rides.
SELECT d.driver_name,SUM(d.earnings) as total_earnings from drivers d
join rides r
on d.driver_id = r.driver_id
GROUP BY d.driver_name
HAVING COUNT(r.ride_id) > 100
ORDER BY total_earnings;

#5 Retrieve rides where the fare amount is less than the average fare amount.
select fare_amount from rides
where fare_amount < (select AVG(fare_amount) from rides); 

#6 Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
SELECT AVG(rating) FROM drivers 
WHERE driver_id IN (
    SELECT driver_id
    FROM rides
    WHERE payment_method IN ('Cash', 'Credit Card')
    GROUP BY driver_id
    HAVING COUNT(DISTINCT payment_method) = 2
);

#7 List the top 3 passengers with the highest total spending.
select passenger_name, total_spent from passengers
order by total_spent DESC
limit 3;

#8 Calculate the average fare amount for rides taken during different months of the year.
SELECT MONTH(ride_timestamp), AVG(fare_amount)
FROM rides
GROUP BY MONTH(ride_timestamp)
order by MONTH(ride_timestamp);

#9 Identify the most common pair of pickup and dropoff locations.
select pickup_location, dropoff_location ,count(*) from rides
GROUP BY pickup_location, dropoff_location
ORDER BY count(*) DESC
LIMIT 1;

#10 Calculate the total earnings for each driver and order them by earnings in descending order.
select driver_name, earnings from drivers
order by earnings DESC;

