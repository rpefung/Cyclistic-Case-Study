

SELECT * FROM Dec_2023

/*Checking for null values*/
SELECT * FROM Dec_2023
WHERE ride_id IS NULL  

SELECT * FROM Dec_2023
WHERE rideable_type IS NULL 

/*Checking for duplicates*/
SELECT COUNT(*) FROM Dec_2023
GROUP BY ride_id
HAVING COUNT(ride_id) > 1

/*Formating and changing to the correct data type*/
ALTER TABLE Dec_2023
ALTER COLUMN started_at DATETIME2(0)

ALTER TABLE Dec_2023
ALTER COLUMN ended_at DATETIME2(0)

ALTER TABLE Dec_2023
ALTER COLUMN ride_length TIME(0)

ALTER TABLE Dec_2023
ALTER COLUMN start_station_name NVARCHAR(MAX)

ALTER TABLE Dec_2023
ALTER COLUMN end_station_name NVARCHAR(MAX)

/*Checking the number of rides: total, by members, casuals, and day of week*/
SELECT DISTINCT member_casual FROM Dec_2023

SELECT COUNT(*) FROM Dec_2023
--224073

SELECT member_casual, COUNT(*) AS rides FROM Dec_2023
WHERE member_casual = 'member'
GROUP BY member_casual
ORDER BY rides DESC
--172401

SELECT member_casual, COUNT(*) AS rides FROM Dec_2023
WHERE member_casual = 'casual'
GROUP BY member_casual
ORDER BY rides DESC
--51672 

SELECT day_of_week, COUNT(day_of_week) AS rides FROM Dec_2023
GROUP BY day_of_week
ORDER BY rides DESC

SELECT day_of_week, COUNT(day_of_week) AS rides FROM Dec_2023
WHERE member_casual = 'member'
GROUP BY day_of_week
ORDER BY rides DESC
-- 5,4,3,2,6,1,7 

SELECT day_of_week, COUNT(day_of_week) AS rides FROM Dec_2023
WHERE member_casual = 'casual'
GROUP BY day_of_week
ORDER BY rides DESC
--6,5,4,7,3,2,1 

/*Checking which hour of the day members/casuals like to ride*/
SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC

SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
WHERE member_casual = 'member'
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC

SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
WHERE member_casual = 'casual'
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC

SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
WHERE member_casual = 'casual' and day_of_week between 1 and 5
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC

SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
WHERE member_casual = 'casual' and day_of_week between 6 and 7
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC 
--casuals tend to start riding earlier on weekends than weekdays


SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
WHERE member_casual = 'member' and day_of_week between 1 and 5
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC

SELECT DATEPART(HOUR,started_at) AS [started riding], COUNT(started_at) AS rides FROM Dec_2023
WHERE member_casual = 'member' and day_of_week between 6 and 7
GROUP BY DATEPART(HOUR,started_at)
ORDER BY rides DESC

/*Avg time riding*/
SELECT CAST(CAST(AVG(CAST(CAST(ride_length AS DATETIME) AS FLOAT)) AS DATETIME) AS TIME) AS [avg ride length] FROM Dec_2023


SELECT CAST(CAST(AVG(CAST(CAST(ride_length AS DATETIME) AS FLOAT)) AS DATETIME) AS TIME) AS [avg ride length] FROM Dec_2023
WHERE member_casual = 'member'


SELECT CAST(CAST(AVG(CAST(CAST(ride_length AS DATETIME) AS FLOAT)) AS DATETIME) AS TIME) AS [avg ride length] FROM Dec_2023
WHERE member_casual = 'casual'


/*Start and end destination*/
SELECT start_station_name, COUNT(*) AS rides FROM Dec_2023
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY rides DESC

SELECT start_station_name, COUNT(*) AS rides FROM Dec_2023
WHERE start_station_name IS NOT NULL AND day_of_week between 1 and 5
GROUP BY start_station_name
ORDER BY rides DESC

SELECT start_station_name, COUNT(*) AS rides FROM Dec_2023
WHERE start_station_name IS NOT NULL AND day_of_week between 6 and 7
GROUP BY start_station_name
ORDER BY rides DESC

SELECT start_station_name, COUNT(*) AS rides FROM Dec_2023
WHERE start_station_name IS NOT NULL AND member_casual = 'casual' 
GROUP BY start_station_name
ORDER BY rides DESC

SELECT end_station_name, COUNT(*) AS rides FROM Dec_2023
WHERE end_station_name IS NOT NULL AND member_casual = 'casual' 
GROUP BY end_station_name
ORDER BY rides DESC

SELECT end_station_name, COUNT(*) AS rides FROM Dec_2023
WHERE end_station_name IS NOT NULL AND member_casual = 'casual' AND day_of_week BETWEEN 1 AND 5
GROUP BY end_station_name
ORDER BY rides DESC
--members and casuals start and end stations are different from each other

/*Repeated the above steps for every dataset*/

/*Start and end destinations by seasons and all year
Repeated this same step for every seasons */
SELECT station.start_station_name, COUNT(*) AS rides FROM 
(
	SELECT start_station_name FROM Dec_2023
	UNION ALL
	SELECT start_station_name FROM Jan_2024
	UNION ALL
	SELECT start_station_name FROM Feb_2024
) AS station
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY rides DESC

SELECT station.end_station_name, COUNT(*) AS rides FROM 
(
	SELECT end_station_name FROM Dec_2023
	UNION ALL
	SELECT end_station_name FROM Jan_2024
	UNION ALL
	SELECT end_station_name FROM Feb_2024
) AS station
WHERE end_station_name IS NOT NULL 
GROUP BY end_station_name
ORDER BY rides DESC

SELECT station.start_station_name, station.member_casual, COUNT(*) AS rides FROM 
(
	SELECT start_station_name, member_casual FROM [dbo].[Mar_2024]
	UNION ALL
	SELECT start_station_name, member_casual FROM [dbo].[Apr_2024]
	UNION ALL
	SELECT start_station_name, member_casual FROM [dbo].[May_2024]
) AS station
WHERE start_station_name IS NOT NULL AND member_casual = 'member' 
GROUP BY start_station_name, member_casual
ORDER BY rides DESC

SELECT station.start_station_name, COUNT(*) AS rides FROM 
(
	SELECT start_station_name FROM Dec_2023
	UNION ALL
	SELECT start_station_name FROM Jan_2024
	UNION ALL
	SELECT start_station_name FROM Feb_2024
	UNION ALL
	SELECT start_station_name FROM Mar_2024
	UNION ALL
	SELECT start_station_name FROM Apr_2024
	UNION ALL
	SELECT start_station_name FROM May_2024
	UNION ALL
	SELECT start_station_name FROM Jun_2024
	UNION ALL
	SELECT start_station_name FROM Jul_2024
	UNION ALL
	SELECT start_station_name FROM Aug_2024
	UNION ALL
	SELECT start_station_name FROM Sep_2024
	UNION ALL
	SELECT start_station_name FROM Oct_2024
	UNION ALL
	SELECT start_station_name FROM Nov_2024
) AS station
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY rides DESC

SELECT station.start_station_name, station.member_casual, COUNT(*) AS rides FROM 
(
	SELECT start_station_name, member_casual FROM Dec_2023
	UNION ALL
	SELECT start_station_name,member_casual FROM Jan_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Feb_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Mar_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Apr_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM May_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Jun_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Jul_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Aug_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Sep_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Oct_2024
	UNION ALL
	SELECT start_station_name,member_casual FROM Nov_2024
) AS station
WHERE start_station_name IS NOT NULL AND member_casual = 'casual' 
GROUP BY start_station_name, member_casual
ORDER BY rides DESC

/*Ride time by seasons*/
SELECT CAST(CAST(AVG(CAST(CAST(ride_length AS DATETIME) AS FLOAT)) AS DATETIME) AS TIME) FROM 
(
	SELECT ride_length FROM Sep_2024
	UNION ALL
	SELECT ride_length FROM Oct_2024
	UNION ALL
	SELECT ride_length FROM Nov_2024
) AS time_riding

SELECT CAST(CAST(AVG(CAST(CAST(ride_length AS DATETIME) AS FLOAT)) AS DATETIME) AS TIME) FROM 
(
	SELECT ride_length FROM Sep_2024
	WHERE member_casual = 'member'
	UNION ALL
	SELECT ride_length FROM Oct_2024
	WHERE member_casual = 'member'
	UNION ALL
	SELECT ride_length FROM Nov_2024
	WHERE member_casual = 'member'
) AS time_riding 


SELECT CAST(CAST(AVG(CAST(CAST(ride_length AS DATETIME) AS FLOAT)) AS DATETIME) AS TIME) FROM 
(
	SELECT ride_length FROM Dec_2023
	WHERE member_casual = 'casual'
	UNION ALL
	SELECT ride_length FROM Jan_2024
	WHERE member_casual = 'casual'
	UNION ALL
	SELECT ride_length FROM Feb_2024
	WHERE member_casual = 'casual'
) AS time_riding 
--casuals ride longer