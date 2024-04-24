use assignment;

select * from jomato;

--1. Create a stored procedure to display the restaurant name, type and cuisine where the
   --table booking is not zero.

CREATE PROCEDURE DISP_DETAILS
AS
SELECT RestaurantName, RestaurantType, CuisinesType
FROM JOMATO
WHERE TableBooking<>0
GO
EXEC DISP_DETAILS
GO

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
   --and rollback it.

SELECT * FROM JOMATO WHERE RestaurantType like 'Cafe';

BEGIN TRAN UP_CAFE
UPDATE JOMATO SET RestaurantType='Cafeteria' WHERE  RestaurantType like 'Cafe'  

SELECT  RestaurantType FROM JOMATO

ROLLBACK TRAN UP_CAFE

SELECT  RestaurantType FROM JOMATO
GO

--3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.

SELECT AREA, RATING, ROW_NUMBER() OVER (PARTITION BY AREA ORDER BY RATING DESC) row_num 
FROM JOMATO
GO

-- To get top 5 areas with the highest rating 
WITH CTE_RESTAURANTS AS (
SELECT AREA, RATING, ROW_NUMBER() OVER (PARTITION BY AREA ORDER BY RATING DESC) row_num 
FROM JOMATO
) SELECT TOP(5) AREA, RATING
FROM CTE_RESTAURANTS
WHERE row_num=1
ORDER BY RATING DESC;


--4. Use the while loop to display the 1 to 50.

DECLARE @count INT;
SET @count = 1;
    
WHILE @count<= 50
BEGIN
   PRINT @count
   SET @count = @count + 1;
END
GO

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.

CREATE VIEW TOP_RATING_VIEW
AS
SELECT TOP(5) RATING FROM JOMATO ORDER BY RATING DESC 
GO

SELECT * FROM TOP_RATING_VIEW


--6. Write a trigger that sends an email notification to the restaurant owner whenever a new
  --record is inserted.

CREATE TRIGGER TRIG_ON_INSERT ON JOMATO
AFTER INSERT
AS
BEGIN
	PRINT 'New Row Inserted'
	-- if we had email address here, use EXEC msdb.dbo.send.dbmail to send mail
END
GO
