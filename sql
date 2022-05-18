/*CREATION*/
/*create table courses (
id integer primary key autoincrement,
name text not null unique,
lessons_amount integer);*/
/*
create table streams (
id integer primary key autoincrement,
number integer not null unique,
course_id integer not null,
start_date text not null,
foreign key (course_id) references courses (id)
);*/
/*create table students (
id integer primary key autoincrement,
surname text not null,
firstname text not null
);*/
/*create table grades (
student_id integer not null,
stream_id integer not null,
grade real not null,
primary key(student_id, stream_id),  // составной первичный ключ
foreign key (student_id) references students (id),
foreign key (stream_id) references streams (id)
);*/

/* --------------------------------------------------------------------------------------*/

/*MODIFICATION*/
/*ALTER TABLE 'Имя Таблицы' RENAME TO 'Новое Имя';*/
/*alter table grades rename to final_grades;*/

/*Изменение имени столбца
ALTER TABLE 'Имя Таблицы' RENAME COLUMN 'Старое Имя Столбца' TO 'Новое Имя
Столбца';*/
/*alter table final_grades rename column grade to final_grade;*/

/*Добавление столбца в таблицу*/
/*alter table students add column email text;*/

/*Удаление таблицы
DROP TABLE 'Имя Таблицы';
DROP TABLE final_grades;*/

/*Простая выборка данных
SELECT 'Столбец 1', 'Столбец 2', 'Столбец N' FROM 'Имя Таблицы';
select * from courses;*/

/*Добавление новых данных в таблицу*/
/*insert into courses (id, name, lessons_amount) values (1, 'Базы данных', 12);*/
/*insert into courses (name, lessons_amount) values // у нас id autoincrement поэтому можно вручную это не писать. И также можно сразу несколько значении добавлять в таблицу
    ('Linux. Рабочая станция', 8),
    ('Основы Python', 8);*/
 
   
/*UPDATE 'Имя Таблицы'
SET 'Столбец 1' = 'Значение1', 'Столбец 2' = 'Значение 2', 'Столбец N' =
'Значение N'
WHERE ['Условие'];*/
/*update courses set lessons_amount = 8 where id = 1;*/
/*update courses set lessons_amount = 7, name = 'Базы данных1' where id = 1;*/
/*update courses set lessons_amount = 12 where name = 'Базы данных';*/

/*Удаление данных
DELETE FROM 'Имя таблицы' WHERE [Условие];
Важно! Если для команды DELETE не указать условие, то удалятся все строки таблицы.*/
/*DELETE FROM courses WHERE name = 'Основы Python';*/

/* --------------------------------------------------------------------------------------*/
/*Выборка данных, агрегация данных*/

/*select * from students where surname = 'Иванов';*/
/*select stream_id, final_grade from grades where student_id = 1;*/

/*select stream_id, final_grade from grades where student_id = 1 limit 1;*/

/*Сортировка результатов*/
/*select * from grades order by final_grade desc;*/

/*Получение только уникальных значений*/
/*select distinct(student_id) from grades;*/

/*Условие неравенства*/
/*select name from courses where lessons_amount != 12;*/

/*Условие «больше или меньше»*/
/*select name from courses where lessons_amount < 12;
select name from courses where lessons_amount > 8;*/

/*Условие по нескольким критериям*/
/*select * from streams where number > 40 and number < 50;*/
/*select * from streams where course_id = 1 or course_id = 3;*/

/*Поиск по диапазону значений, BETWEEN*/
/* Найдём потоки с номерами, лежащими в диапазоне
значений между 45 и 50 включительно*/
/*SELECT * FROM streams WHERE number BETWEEN 45 AND 50;*/

/*Поиск по списку значений, IN*/
/*SELECT lessons_amount FROM courses WHERE name = 'Linux. Рабочая станция'
OR name = 'Основы Python';
lessons_amount
--------------
8
8*/
/*Но со списками удобнее работать, используя ключевое слово IN, для которого в скобках мы
перечисляем все искомые значения:*/
/*SELECT lessons_amount FROM courses WHERE name IN('Linux. Рабочая
станция', 'Основы Python');
lessons_amount
--------------
8
8*/
/*select * from students where id in (2,3,4);*/

/*Условия равенства для значения NULL*/
/*SELECT * FROM students WHERE email IS NOT NULL;*/
/*SELECT * FROM students  WHERE email IS NULL;*/

/*Поиск по шаблону, LIKE*/
/*select * from students where firstname like 'Игорь';*/
/*select * from students where firstname like '%сия';*/
/*select * from students where firstname like 'А%';*/
/*select * from students where firstname like '%а%';*/
/*select * from students where firstname like '%а%' and firstname like '%н%';*/

/*Функции для работы с датой и временем*/
/*select current_timestamp;*/ /*Чтобы получить текущее значение даты и времени, применяется функция CURRENT_TIMESTAMP:*/
/*sqlite> SELECT DATE('now');
DATE('now')
-----------
2021-01-10
sqlite> SELECT TIME('now');
TIME('now')
-----------
09:04:57
sqlite> SELECT DATETIME('now');
DATETIME('now')
-------------------
2021-01-10 09:05:02*/

/*Дата и время также выделяются из строки:*/
/*sqlite> SELECT DATE('2021-01-05 17:21:20');
---------------------------
2021-01-05
sqlite> SELECT TIME('2021-01-05 17:21:20');
---------------------------
17:21:20*/

/*Определим, в каких позициях символов находится значение года — год начинается с позиции 1, и
вырезать потребуется 4 символа. Тогда для получения подходящего значения надо воспользоваться
выражением SUBSTR(CURRENT_TIMESTAMP, 1, 4):*/
/*select substr(current_timestamp, 1, 4);*/

/*SELECT started_at FROM streams;
select current_timestamp;
select substr(started_at, 7, 4) || '-' || substr(started_at,4,2) || '-' || substr(started_at,1 , 2) from streams;*/
/*update streams set started_at = substr(started_at, 7, 4) || '-' || substr(started_at,4,2) || '-' || substr(started_at,1 , 2);*/

/*Понятие группировки, нахождение среднего значения*/
/*select avg(final_grade) from grades;*/

/*Но как быть, если нам надо найти среднюю оценку по всем курсам для каждого ученика? В этом
случае потребуется группировка. То есть надо явным образом указать, по какому набору строк мы
хотим подсчитать результат. Если нам требуются данные в разрезе учеников, то логично в качестве
значения для группировки указать идентификатор ученика:*/
/*SELECT student_id, AVG(final_grade) FROM grades GROUP BY student_id;*/

/*SELECT course_id, COUNT(*) FROM streams GROUP BY course_id;*/

/* SELECT student_id, MAX(final_grade) AS 'max_grade' FROM grades GROUP BY
student_id;
/*
SELECT student_id, MIN(final_grade) AS 'min_grade' FROM grades GROUP BY
student_id;*/

/*Подсчитаем общее количество занятий по
всем курсам. Обратите внимание, что в этом случае группировка не требуется:
SELECT SUM(lessons_amount) AS 'lessons_total' FROM courses;*/


/*Определить условие через WHERE мы можем только для данных, которые уже есть в таблице. В
рассмотренном примере значение min_grade рассчитывается посредством функции, то есть получаем
результат во время выполнения запроса. Мы получили ошибку, потому что условие WHERE нельзя
применять для рассчитываемых значений.
Для определения условия в таких случаях вместо WHERE применяется ключевое слово HAVING,
которое имеет тот же смысл — определяет фильтр для вывода результата:
SELECT student_id, MIN(final_grade) AS min_grade FROM grades GROUP BY
student_id HAVING min_grade > 4.7;*/


