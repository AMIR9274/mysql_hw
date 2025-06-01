-- 1. Найти автора с самым большим числом книг и вывести его имя
SELECT a.name, COUNT(ab.books_id) AS books_count
FROM authors a
JOIN authors_books ab ON a.id = ab.authors_id
GROUP BY a.id, a.name
ORDER BY books_count DESC
LIMIT 1;

-- 2.Вывести пять самых старых книг у которых указан год издания
SELECT title, year
FROM books
WHERE year IS NOT NULL 
ORDER BY year ASC
LIMIT 5;

-- 3.Вывести общее количество книг на полке в кабинете
SELECT COUNT(*) AS total_books_in_cabinet
FROM books
JOIN shelves ON books.shelves_id = shelves.id
WHERE shelves.title LIKE '%кабинет%';

-- 4.Вывести названия, имена авторов и годы издания книг, которые находятся на полке в спальне
SELECT 
b.title AS book_title,
a.name AS author_name,
b.year AS publication_year
FROM books b
JOIN shelves s ON b.shelves_id = s.id
JOIN authors_books ab ON b.id = ab.books_id
JOIN authors a ON ab.authors_id = a.id
WHERE s.title LIKE '%спальне%';

-- 5.Вывести названия и годы издания книг, написанных автором 'Лев Толстой'
SELECT
b.title,
b.year
FROM books b
JOIN authors_books ab ON b.id = ab.books_id
JOIN authors a ON ab.authors_id = a.id
WHERE a.name = 'Лев Толстой';

-- 6.Вывести название книг, которые написали авторы, чьи имена начинаются на букву "А"
SELECT DISTINCT b.title
FROM books b
JOIN authors_books ab ON b.id = ab.books_id
JOIN authors a ON ab.authors_id = a.id
WHERE a.name LIKE 'А%';

-- 7.Вывести название книг и имена авторов для книг, которые находятся на полках, названия которых включают слова «верхняя» или «нижняя»
SELECT b.title AS book_title, a.name AS author_name
FROM books b	
JOIN shelves s ON b.shelves_id = s.id
JOIN authors_books ab ON b.id = ab.books_id
JOIN authors a ON ab.authors_id = a.id
WHERE s.title LIKE '%Верхняя%'
OR s.title LIKE '%Нижняя%';

-- 8.Книгу «Божественная комедия» автора «Данте Алигьери» одолжили почитать другу Ивану Иванову, необходимо написать один или несколько запросов которые отразят это событие в БД
SELECT id FROM books WHERE title = 'Божественная комедия';

SELECT id FROM friends WHERE name = 'Иванов Иван';

UPDATE books
SET friends_id = (SELECT id FROM friends WHERE name = 'Иванов Иван')
WHERE id = 9;

-- 9.Добавить в базу книгу «Краткие ответы на большие вопросы», год издания 2020, автор «Стивен Хокинг», положить ее на полку в кабинете
SELECT id FROM shelves WHERE title LIKE '%кабинете%';

SELECT id FROM authors WHERE name = 'Стивен Хокинг';

SELECT id FROM books WHERE title = 'Краткие ответы на большие вопросы';

INSERT INTO authors_books (books_id, authors_id)
VALUES (176, 145);