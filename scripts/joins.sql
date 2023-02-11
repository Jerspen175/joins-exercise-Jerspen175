-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year,revenue.worldwide_gross 
FROM specs
LEFT JOIN revenue
ON specs.movie_id=revenue.movie_id
ORDER BY revenue.worldwide_gross ASC
LIMIT 1;
---Semi-Tough, 1977, 37187139

-- 2. What year has the highest average imdb rating?
SELECT 	release_year, AVG(rating.imdb_rating)
FROM specs
LEFT JOIN rating
ON specs.movie_id=rating.movie_id
GROUP BY release_year, rating.imdb_rating
ORDER BY imdb_rating DESC
LIMIT 5;
--- 2008

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT film_title, worldwide_gross, mpaa_rating, company_name
FROM distributors
LEFT JOIN specs
ON distributor_id = domestic_distributor_id
LEFT JOIN revenue 
ON revenue.movie_id = specs.movie_id
WHERE specs.mpaa_rating ='G'
ORDER BY revenue.worldwide_gross DESC
LIMIT 5;
--- Toy Story 4, Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT DISTINCT company_name, COUNT(film_title)
FROM distributors
LEFT JOIN specs 
ON distributor_id= domestic_distributor_id
WHERE specs.film_title IS NULL OR specs.film_title IS NOT NULL
GROUP BY company_name, film_title;
-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT DISTINCT distributors.company_name, AVG(film_budget)
FROM distributors
LEFT JOIN specs
ON distributor_id = domestic_distributor_id
LEFT JOIN revenue 
ON specs.movie_id=revenue.movie_id
WHERE film_budget IS NOT NULL
GROUP BY  distributors.company_name
ORDER BY AVG(film_budget) DESC
LIMIT 5;
-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT film_title, company_name, headquarters, imdb_rating
FROM distributors
LEFT JOIN specs
ON distributor_id=domestic_distributor_id
LEFT JOIN rating 
ON specs.movie_id=rating.movie_id
WHERE headquarters NOT LIKE '%CA%'
ORDER BY imdb_rating DESC;
--- Two comapanies are not in CA. Dirty Dancing was the highest grossing film made a company not in CA(The comapny is Vestron Pictures in Chicago,Ill.)

-- -- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
-- SELECT  AVG(imdb_rating), COUNT(specs.length_in_min), COUNT(film_title)
-- FROM specs 
-- LEFT JOIN rating
-- ON specs.movie_id=rating.movie_id
-- WHERE length_in_min >'120'
-- GROUP BY length_in_min, film_title,imdb_rating;
-- GROUP BY specs.length_in_min, film_title, imdb_rating
-- UNION ALL
SELECT AVG(imdb_rating),AVG(COUNT(length_in_min)), AVG(COUNT(film_title))
FROM specs 
LEFT JOIN rating
ON specs.movie_id=rating.movie_id
WHERE length_in_min <'120'
GROUP BY specs.length_in_min, film_title, imdb_rating
ORDER BY  length_in_min DESC;
---Movies over two hours long have a higher rating on average than movies less than two hours long.