/*
QUESTION 1) What is the average content of each nutrient and element per manufacturer?
 Nutrient = Carbohydrates (Sugars, dietary fiber), Proteins, Fats, Vitamins, and Minerals

 - 1) Find the average of each nutrient category (e.g. protein, fats etc.) per manufacturer
 - 2) Insert them into a CTE or temp table 

 Limitations = Vitamins in percentages, so average not representative.
  This is because the average represents the FDA recommended daily intake rather than 
  actual quantities of vitamins present in the cereal products. 
*/
 

-- View all the columns
select * 
FROM PortfolioProject_2..Cereal;

-- CTE for average nutrient content and ratings
With nutrients_average_CTE (Mfr,Avg_Protein, Avg_Fat, Avg_Vitamin, Avg_Fiber, Avg_Carbohydrate, Avg_Sodium, Avg_Potass) AS (

	-- Calcuate the averages of all the nutrients
	Select 
		mfr, 
		avg(protein) as avg_protein,
		avg(fat) as avg_fat,
		avg(vitamins) as avg_vitamin,
		avg(fiber) as avg_fiber,
		avg(carbo) as avg_carbohydrate,
		avg(sodium) as avg_sodium,
		avg(potass) as avg_potass
	From
		PortfolioProject_2..Cereal
	Group By
		mfr

), ratings_average as (
	Select 
		mfr, 
		avg(rating) as Avg_Brand_Rating
	From
		PortfolioProject_2..Cereal
	Group By 
		mfr
)

-- Join both the CTEs using the similar manufacturing name column in both the CTEs
Select 
	n.mfr,
	n.avg_protein,
	n.avg_fat,
	n.avg_vitamin,
	n.avg_fiber,
	n.avg_carbohydrate,
	n.avg_sodium,
	n.avg_potass,
	r.Avg_Brand_Rating
From
	nutrients_average_CTE n
	Join ratings_average r ON n.mfr = r.mfr
Order By
	Avg_Brand_Rating desc;

/*
QUESTION 2) What is the number of calories per ounce for each product?
*/
-- Determines the average calories per manufacturer
Select
	mfr,
	name,
	avg(calories) as Avg_Calories
From
	PortfolioProject_2..Cereal
Group By
	mfr, name
Order By
	mfr,name;

/*

QUESTION 3) What is the average rating per manufacturer? Is it somehow connected to average nutrient content?

*/
-- Determines the average brand rating
Select
	mfr,
	name,
	avg(rating) as Avg_Brand_Rating
From
	PortfolioProject_2..Cereal
Group By
	mfr, name
Order By
	mfr, name;

-- Calculate the correlation between rating (x) and protein (y)
--Select
	

--FROM
--	nutrients_average_CTE
/*
QUESTION 4) Which manufacturer possesses the best shelf location?
*/

-- Ranks the manufacturer based on average shelf location
Select 
	mfr,
	avg(shelf) as avg_shelf
From
	PortfolioProject_2..Cereal
Group By
	mfr
Order By
	avg_shelf desc;


/*
QUESTION 5) What is the nutritional value of each cereal according to protein, fat, and carbohydrate data.
*/

-- Find the nutritional value of each cereal
Select
	mfr, 
	name,
	protein, 
	fat, 
	carbo
From
	PortfolioProject_2..Cereal;

-- Find Top 5 cereals with the highest protein, fat, and carb content
Select Top 5
	mfr,
	name,
	protein as high_protein,
	fat as high_fat,
	carbo as high_carb
From
	PortfolioProject_2..Cereal
Where
	protein is not null 
	And
	fat is not null
	And
	carbo is not null
Order By
	protein desc,
	fat desc,
	carbo desc;



