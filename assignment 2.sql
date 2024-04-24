create database assignment;

use assignment;

select * from jomato;

--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’.
    -- Eg: ‘Quick Chicken Bites’.

CREATE FUNCTION MOD_RESTAURANT_TYPE (@name NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
	SET @name=STUFF(@name,6,0,'Chicken')
	RETURN @name
END

GO

UPDATE JOMATO
SET RestaurantType = dbo.MOD_RESTAURANT_TYPE(RestaurantType)
WHERE RestaurantType LIKE 'Quick Bites%'

GO


--2. Use the function to display the restaurant name and cuisine type which has the
    --maximum number of rating.

SELECT RestaurantName, RestaurantType 
FROM JOMATO 
WHERE NO_OF_RATING = (SELECT MAX(NO_OF_RATING) FROM JOMATO);


--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
    --star rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is 
    --above 3 and below 3.5 and ‘Bad’ if it is below 3 star rating.

SELECT RATING,
CASE
	WHEN RATING>=4 THEN 'Excellent'
	WHEN RATING>=3.5 AND RATING<4 THEN 'Good'
	WHEN RATING>=3 AND RATING<3.5 THEN 'Average'
	ELSE 'Bad'
END AS RatingStatus
FROM JOMATO;

--4. Find the Ceil, floor and absolute values of the rating column and display the current date
    --and separately display the year, month_name and day.

SELECT CEILING(RATING) AS 'CELING RATING', 
FLOOR(RATING) AS 'FLOOR RATING', 
ABS(RATING) AS 'ABSOLUTE RATING', 
CAST( GETDATE() AS Date ) As 'DATE', 
YEAR(CAST( GETDATE() AS Date )) AS 'YEAR', 
DAY(CAST( GETDATE() AS Date )) AS 'DAY', 
DATENAME(WEEKDAY,CAST( GETDATE() AS Date )) AS 'DAYNAME',
DATENAME(MONTH,CAST( GETDATE() AS Date )) AS 'MONTHNAME'
FROM JOMATO
GO;

--5. Display the restaurant type and total average cost using rollup.

SELECT RestaurantType, SUM(AverageCost) as 'total average cost'
FROM JOMATO
GROUP BY ROLLUP (RestaurantType);