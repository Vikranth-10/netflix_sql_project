--Netflix Project

CREATE Table Netflix
(
	show_id	VARCHAR(6),
	type    VARCHAR(10),
	title	VARCHAR(150),
	director VARCHAR(208),
	casts	VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(50),
	release_year INT,
	rating	VARCHAR(10),
	duration	VARCHAR(20),
	listed_in	VARCHAR(80),
	description VARCHAR(250)
);

SELECT * FROM netflix;


SELECT 
count(*) as total_content
from netflix;

SELECT 
 Distinct type
from netflix;


SELECT count(*) from netflix;

-- 15 Business Problems & Solutions

1. Count the number of Movies vs TV Shows

select 
type, 
count(*) as total_content1
from netflix 
group by type





2. Find the most common rating for movies and TV shows

select 
type,
rating,
count(*),
Rank() over (partition by type order by count(*)DESC) as ranking
from netflix
group by 1,2
--order by 1,3 DESC

3. List all movies released in a specific year (e.g., 2020)

select * 
from netflix
where type='Movie'
AND release_year=2020;


4. Find the top 5 countries with the most content on Netflix

Select 
unnest(string_to_array(country,',')) as new_country,
count(show_id)AS total_content
from netflix
group by 1
order by 2 desc
limit 5

select 
unnest(string_to_array(country,',')) as new_country
from netflix


5. Identify the longest movie

select * from netflix 
where
type='Movie'
and
duration=(select max(duration) from netflix)

6. Find content added in the last 5 years

select 
*,
to_date(date_added,'month DD,YYYY')
from netflix 
where
to_date(date_added,'month DD,YYYY')>=Current_date-Interval'5 years'

select Current_date - Interval '5  years'


7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

Select * from netflix
where director like '%Rajiv Chilaka%'


8. List all TV shows with more than 5 seasons

select
*,
 Split_part(duration,' ',1) AS sessions 
from netflix
where 
    type = 'Tv Show'
    duration > 5 sessions
 
select * from netflix;


9. Count the number of content items in each genre

select 
   unnest (String_to_array(listed_in,','))as genre,
   count(show_id)
 from netflix
 group By 1

10.Find each year and the average numbers of content  release in India on netflix. 
return top 5 year with highest avg content release!

select 
   extract(year from To_Date(date_added,'Month DD,YYYY')) as year,
   count(*),
   count(*)/(select Count(*) from netflix where country='India')*100 as avg_content_year
from netflix
where Country='India'
group by 1




11. List all movies that are documentaries

select * from netflix
 where
  listed_in Ilike '%documentaries%'

12. Find all content without a director

select * from netflix
 where
 director is null

13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select * from netflix
 where 
  casts Ilike '%Salman khan%'
  AND 
  release_year> extract(year from current_date) - 10


14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

select 
unnest(string_to_array(casts,','))as actors,
count(*) as total_content
from netflix
where country ilike '%india'
group by 1
order by 2 desc
limit 10

15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

select * ,
  case 
  when description ilike '%kill%' or 
  description ilike '%violence%' then 'bed_content'
  else 'good content'
  end category
from netflix

where
description ilike '%kill%'
or
description ilike '%violence%'


