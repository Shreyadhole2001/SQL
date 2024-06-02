create database demo1;
use demo1;
select * from netflix;

-- WHERE CLAUSE

-- Display all data from table where gener is drama
select * from netflix where genre='drama';

-- Display genre,language,imdb score whose runtime is more than 100
select genre,language,imdb_score from netflix where runtime>100;

-- Display all the data from table whose premiere is before 4/14/2021
select * from netflix where premiere<'4-14-2021';

-- Display title,language, year from netflix data whose year is 2018,2019,2020
select title,language,year from netflix where year in(2018,2019,2020);

-- Display title,language,year from netflix data whose year is not 2018,2019,2020
select title,language,year from netflix where year not in(2018,2019,2020);

-- Display the data whose title ends with 't'
select * from netflix where title like '%t';

-- Display all data from table whose letter u,a,n in their title.sort the query in descending order by imbd score
select * from netflix  where title like '%u%' or title like '%a%' or title like '%n%' order by imdb_score desc; 

-- Display title,premiere,imdb_score whose title doesn't have the letter 'm' sort the query in ascending order by runtime
select title,premiere,imdb_score  from netflix where title not like '%m%' order by runtime;

-- Display all data from netflix table without runtime
select * from netflix where runtime is null;

-- Display the title concatenate with genre seperated by '-'  and imdb score range between 5.6 to 8.5
select concat(title,'-',genre)as title_genre ,imdb_score from netflix where imdb_score between 5.6 and 8.5;

-- Display the title concatenate with genre with hyphen whose imdb score is not between 7.2 to 8.5 name the column as name_genre and score
select concat(title,'-',genre) as title_genre ,imdb_score as score from netflix where imdb_score not between 7.2 and 8.5;

-- Display all dta from netflix whose imdb score between 6.3 to 8.5 and runtime  is not equal to 83,70,90 and premiere is before 3/30/2018
select * from netflix where imdb_score between 6.3 and 8.5 and runtime not in (83,70,90) and premiere<'3-30-2018';

-- Display title concat with genre ,premiere ,imdb_score,language and runtime whose runtime is greater than 79 and last digit is 8 .sort the query in descending order by title
select concat(title,'-',genre) as title_genre ,premiere,imdb_score,language,runtime from netflix where runtime>79 and runtime like '%8' order by title desc;

-- Display the genre and imdb_score whose runtime equal to 118 or 126 .perform this excersice one by using in in operator ,once by using or opertor
select genre,imdb_score,runtime from netflix where runtime in(118,126);
select genre,imdb_score,runtime from netflix where runtime=118 or runtime=126;

-- scaler and numeric

-- display the title ,runtime from netflix table whose runtime is between 86 to 126
select upper(title),runtime from netflix where runtime between 83 and 126;

-- Top 10 Highest Rated Movies:
-- Write a query to find the top 10 highest-rated movies available on Netflix, along with their titles, IMDb scores, and genres.
select title,imdb_score,genre from netflix order by imdb_score desc limit 10;

-- Most Common Genres:
-- Create a query to identify the top 5 most common genres in the Netflix dataset, along with the count of movies or TV shows belonging to each genre.
select count(title),genre from netflix group by genre order by count(title) desc limit 5;

-- Longest Movies on Netflix:
-- Write a query to find the top 10 longest movies available on Netflix, sorted by their runtime. Include the title, runtime, and release year.
select title,runtime ,year from netflix  order by runtime desc limit 10;

-- Languages with Most Content:
-- Identify the top 3 languages in which the majority of Netflix content is available. Display the language along with the count of titles available in that language.
select count(title),language from netflix group by language order by count(title) desc limit 3 ;

-- Newest Titles:
-- List the top 10 newest titles (movies or TV shows) added to Netflix, ordered by their premiere date.
select title,premiere from netflix order by premiere desc limit 10;

-- Oldest Titles:
-- Similarly, find the top 10 oldest titles available on Netflix, ordered by their premiere date.
select title ,premiere from netflix order by premiere limit 10;

-- Movies vs. TV Shows:
-- Compare the count of documentary to the count of comedy shows available on Netflix.
Select(Select count(*) from netflix where genre = 'Documentary') as documentary_count,
    (select COUNT(*) from netflix where genre = 'Comedy') as comedy_count;

-- Average IMDb Score by Genre:
-- Calculate the average IMDb score for each genre and rank them from highest to lowest average score.
select genre, avg(imdb_score) as average_score from netflix group by genre order by average_score desc;


-- Titles Released Each Year:
-- Display the count of titles (movies and TV shows) released each year on Netflix, ordered by the release year.
select count(title),year from netflix group by year order by count(title) ;


-- Titles by Genre and Language:
-- Produce a report that shows the count of titles in each genre and language combination.
select genre, language, count(title) AS title_count from netflix group by  genre, language order by genre, language;






