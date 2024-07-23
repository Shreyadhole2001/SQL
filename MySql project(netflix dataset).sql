create database demo;
use demo;
select*from netflix;

-- Display all data from table where genre is drama
select * from netflix where genre = 'drama';

-- Display genre, language, IMDB score whose runtime is more than 100
select genre, language, imdb_score from netflix where runtime > 100;

-- Display all the data from table whose premiere is before 4/14/2021
select * from netflix where premiere < '2021-04-14';

-- Display title, language, year from Netflix data whose year is 2018,2019,2020
select title, language, year from netflix where year in (2018, 2019, 2020);

-- Display title, language, year from Netflix data whose year is not 2018,2019,2020
select title, language, year from netflix where year not in (2018, 2019, 2020);

-- Display the data whose title ends with 't'
select * from netflix where title like '%t';

-- Display all data from table whose letter ‘u’, ‘a’, ‘n’ in their title sort the query in descending order by IMBD score
select * from netflix where title like '%u%' or title like '%a%' or title like '%n%' order by imdb_score desc;

-- Display title, premiere, imdb_score whose title doesn't have the letter 'm' sort the query in ascending order by runtime
select title, premiere, imdb_score from netflix where title not like '%m%' order by runtime asc;

-- Display all data from Netflix table without runtime
select title, language, year from netflix where year not in (2018, 2019, 2020);

-- Display the title concatenate with genre separated by '-'  and IMDB score range between 5.6 to 8.5
select CONCAT(title, '-', genre) AS title_genre from netflix where imdb_score between 5.6 and 8.5;

-- Display the title concatenate with genre with hyphen whose IMBD score is not between 7.2 to 8.5 name the column as name genre and score
select concat(title, '-', genre) as name_genre_and_score from netflix where imdb_score not between 7.2 and 8.5;

-- Display all data from Netflix whose IMDB score between 6.3 to 8.5 and runtime  is not equal to 83,70,90 and premiere is before 3/30/2018
select * from netflix where imdb_score between 6.3 and 8.5 and runtime not in (83, 70, 90) and premiere < '2018-03-30';

-- Display title concat with genre ,premiere ,IMDB score, language and runtime whose runtime is greater than 79 and last digit is 8 .sort the query in descending order by title
select concat(title, '-', genre) as title_genre, premiere, imdb_score, language, runtime from netflix where runtime > 79 and runtime % 10 = 8 order by title desc;

-- Display the genre and IMDB score whose runtime equal to 118 or 126 .perform this exercise one by using in in operator ,once by using or operator
select genre, imdb_score from netflix where runtime in (118, 126);

-- Display the title ,runtime from Netflix table whose runtime is between 86 to 126
select title, runtime from netflix where runtime between 86 and 126;

-- Top 10 Highest Rated Movies:
-- Write a query to find the top 10 highest-rated movies available on Netflix, along with their titles, IMDb scores, and genres.
select title, imdb_score, genre from netflix order by imdb_score desc limit 10;

-- Most Common Genres:
-- Create a query to identify the top 5 most common genres in the Netflix dataset, along with the count of movies or TV shows belonging to each genre.
select genre, count(*) as count from netflix group by genre order by count desc limit 5;

-- Longest Movies on Netflix:
-- Write a query to find the top 10 longest movies available on Netflix, sorted by their runtime. Include the title, runtime, and release year
select title, runtime, year from netflix order by runtime desc limit 10;

-- Languages with Most Content:
-- Identify the top 3 languages in which the majority of Netflix content is available. Display the language along with the count of titles available in that language.
select language, count(*) as count from netflix group by language order by count desc limit 3;

-- Newest Titles:
-- List the top 10 newest titles (movies or TV shows) added to Netflix, ordered by their premiere date.
select title, premiere from netflix order by premiere desc limit 10;

-- Oldest Titles:
-- Similarly, find the top 10 oldest titles available on Netflix, ordered by their premiere date.
select title, premiere from netflix order by premiere asc limit 10;

-- Movies vs. TV Shows:
-- Compare the count of documentary to the count of comedy shows available on Netflix.
select 'Documentary' as type, count(*) as count from netflix where genre = 'documentary'
union
select 'Comedy' as type, count(*) as count from netflix where genre = 'comedy';

-- Average IMDB Score by Genre:
-- Calculate the average IMDB score for each genre and rank them from highest to lowest average score.
select genre, avg(imdb_score) as avg_score from netflix group by genre order by avg_score desc;

-- Titles Released Each Year:
-- Display the count of titles (movies and TV shows) released each year on Netflix, ordered by the release year.
select year, count(*) as count from netflix group by year order by year;

-- Titles by Genre and Language:
-- Produce a report that shows the count of titles in each genre and language combination.
select genre, language, count(*) as count from netflix group by genre, language order by count desc;

-- The top 3 genres with the highest average IMDb scores
select genre, avg(imdb_score) as avg_score from netflix group by genre order by avg_score desc limit 3;

-- Find the longest movie title for each genre
select genre, title from netflix where runtime = (select max(runtime) from netflix as sub where sub.genre = netflix.genre);

-- The movies that have a higher IMDb score than the average IMDb score of their genre
select * from netflix as n where imdb_score > (select avg(imdb_score) from netflix as sub where sub.genre = n.genre);

-- Find the top 5 languages with the most movies and their average IMDb score
select language, count(*) as count, avg(imdb_score) as avg_score from netflix group by language order by count DESC limit 5;

-- Calculate the cumulative runtime of movies per year
select year, sum(runtime) as cumulative_runtime from netflix group by year order by year;

-- Get the genres with more than one movie and their average IMDb score
select genre, avg(imdb_score) as avg_score from netflix group by genre having count(*) > 1;

-- Find movies that have been released in the same year and have the same IMDb score
select title, year, imdb_score
from netflix
where (year, imdb_score) in (
    select year, imdb_score
    from netflix
    group by year, imdb_score
    having count(*) > 1
)
order by year, imdb_score;

-- Identify the languages in which movies have an above-average IMDb score for their genre
select language 
from netflix as n 
where imdb_score > (select avg(imdb_score) from netflix as sub where sub.genre = n.genre) 
group by language;

-- Find the number of movies and average IMDb score for genres that have movies in more than 3 different languages
select genre, count(*) as movie_count, avg(imdb_score) as avg_score 
from netflix 
where genre in (
    select genre 
    from netflix 
    group by genre 
    having count(distinct language) > 3
)
group by genre;
