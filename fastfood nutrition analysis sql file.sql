-- top 5 restraunts with lowest average calorie per meal
select restaurant , avg(calories) as av from fastfood_calories 
group by restaurant 
order by av
limit 5

-- top 5 restraunts with highest average calorie per meal
select restaurant , avg(calories) as av from fastfood_calories 
group by restaurant 
order by av desc
limit 5

-- top 5 restraunts with lowest calories to protein ratio 
select restaurant , avg(calories/protein) as cal_to_pro_ratio from fastfood_calories 
group by restaurant
order by cal_to_pro_ratio 
limit 5

-- top 5 restraunts with highest calories to protein ratio 
select restaurant , avg(calories/protein) as cal_to_pro_ratio from fastfood_calories 
group by restaurant
order by cal_to_pro_ratio desc
limit 5

-- highest calorie item from each restaurant
with cte as (select restaurant,item,calories,
rank() over(partition by restaurant order by calories desc) as rnk 
from fastfood_calories)

select restaurant,item,calories 
from cte where rnk = 1
order by calories desc


-- lowest calorie meal from each restraunt 
with cte as (select restaurant,item,calories,
rank() over(partition by restaurant order by calories ) as rnk 
from fastfood_calories)

select restaurant,item,calories 
from cte where rnk = 1
order by calories 

-- high protein meal from each restaurant
with cte as (select restaurant,item,protein,
rank() over(partition by restaurant order by protein desc) as rnk 
from fastfood_calories)

select restaurant,item,protein
from cte where rnk = 1
order by protein desc

-- items and thier protein calories out of the total calories 
select restaurant,item,protein,calories,(protein * 4) * 100 /calories as protein_cal from fastfood_calories
order by protein_cal desc

-- top 5 low sodium foods
select restaurant,item,sodium from fastfood_calories 
order by sodium 
limit 5


-- top 5 high sodium foods
select restaurant,item,sodium from fastfood_calories 
order by sodium desc
limit 5

-- top 5 high sugary foods
select restaurant,item,sugar from fastfood_calories 
order by sugar desc
limit 5


--  5 low sugary foods
select restaurant,item,sugar from fastfood_calories 
order by sugar 
limit 5

-- percentage of good fat  out of total fat 
select restaurant,item,
(total_fat - (sat_fat + trans_fat)) * 100/ total_fat as good_fat_percentage from fastfood_calories
order by good_fat_percentage desc
