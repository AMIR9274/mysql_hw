-- 1.Вывести сколько фильмов сняла кинокомпания Universal Pictures
SELECT COUNT(*) AS film_count
FROM movies m
JOIN companies c ON m.companies_id = c.id
WHERE c.title = 'Universal Pictures';

-- 2.Вывести сколько всего фильмов было снято режиссером Фрэнсисом Фордом Копполой
SELECT COUNT(*) AS film_count
FROM movies m
JOIN directors d ON m.directors_id = d.id
WHERE d.full_name = 'Фрэнсис Форд Коппола';

-- 3.Вывести количество снятых фильмов за последние 20 лет
SELECT COUNT(*) AS film_count_last_20_years
FROM movies
WHERE year >= 2005;

-- 4.Вывести все жанры фильмов в которых снимал Стивен Спилберг в течении всей своей карьеры
SELECT DISTINCT g.title AS genre
FROM movies m
JOIN directors d ON m.directors_id = d.id
JOIN genres g ON m.genres_id = g.id
WHERE d.full_name = 'Стивен Спилберг';

-- 5.Вывести названия, жанры и режиссеров 5 самых дорогих фильмов
SELECT 
    m.title AS movie,
    g.title AS genre,
    d.full_name AS director,
    m.budget
FROM movies m
JOIN genres g ON m.genres_id = g.id
JOIN directors d ON m.directors_id = d.id
ORDER BY m.budget DESC
LIMIT 5;

-- 6.Вывести имя режиссера с самым большим количеством фильмов
SELECT 
    d.full_name AS director,
    COUNT(m.id) AS movie
FROM movies m
JOIN directors d ON m.directors_id = d.id
GROUP BY d.id
ORDER BY movie DESC
LIMIT 1;

-- 7.Вывести названия и жанры фильмов, снятые самой большой кинокомпанией (по сумме всех бюджетов фильмов)
SELECT 
    m.title AS movie,
    g.title AS genre
FROM movies m
JOIN genres g ON m.genres_id = g.id
WHERE m.companies_id = (
    SELECT companies_id
    FROM movies
    GROUP BY companies_id
    ORDER BY SUM(budget) DESC
    LIMIT 1
);

-- 8.Вывести средний бюджет фильмов, снятых кинокомпанией Warner Bros.
SELECT 
    AVG(budget) AS average_budget
FROM movies
WHERE companies_id = (
    SELECT id FROM companies WHERE title = 'Warner Bros.'
);

-- 9.Вывести количество фильмов каждого жанра и средний бюджет по жанру
SELECT 
    genres.title AS genre,
    COUNT(movies.id) AS movie_count,
    ROUND(AVG(movies.budget)) AS average
FROM movies
JOIN genres ON movies.genres_id = genres.id
GROUP BY genres.title;

-- 10.Найти и удалить комедию "Дикие истории" 2014-го года
SELECT 
    movies.id, 
    movies.title, 
    movies.year, 
    genres.title AS genre
FROM movies
JOIN genres ON movies.genres_id = genres.id
WHERE movies.title = 'Дикие истории' AND movies.year = 2014 AND genres.title = 'Комедия';
DELETE FROM movies
WHERE id = 208;
