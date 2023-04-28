-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar

CREATE TABLE student (
    student_id SERIAL,
    first_name VARCHAR,
    last_name VARCHAR,
    birthday DATE,
    phone VARCHAR
);

-- 2. Добавить в таблицу student колонку middle_name varchar

ALTER TABLE student
 ADD COLUMN middle_name VARCHAR;

-- 3. Удалить колонку middle_name

ALTER TABLE student
DROP COLUMN middle_name;

-- 4. Переименовать колонку birthday в birth_date

  ALTER TABLE student
RENAME COLUMN birthday
           TO birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)

  ALTER TABLE student
 ALTER COLUMN phone TYPE VARCHAR(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора

INSERT INTO student (first_name, last_name, birth_date, phone)
     VALUES
    ('Иван', 'Иванов', '2000-01-01', '89851234567'),
    ('Петр', 'Петров', '2002-02-02', '89851234563'),
    ('Сидор', 'Сидоров', '2003-03-03', '89851234562');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние

  TRUNCATE TABLE student
RESTART IDENTITY;
