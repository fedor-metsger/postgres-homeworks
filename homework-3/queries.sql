-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT DISTINCT customers.company_name, CONCAT(first_name, ' ', last_name) AS name
  FROM orders
  JOIN employees
 USING (employee_id)
  JOIN customers
 USING (customer_id)
  JOIN shippers ON shippers.company_name = 'United Package'
 WHERE customers.city = 'London'
   AND employees.city = 'London';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT product_name, units_in_stock, company_name, phone
  FROM products
  JOIN categories
 USING (category_id)
  JOIN suppliers s
 USING (supplier_id)
 WHERE discontinued = 0
   AND units_in_stock < 25
   AND category_name IN ('Dairy Products', 'Condiments')
 ORDER BY units_in_stock;


-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT company_name
  FROM customers
 WHERE NOT EXISTS (
   SELECT order_id
     FROM orders
    WHERE customers.customer_id = orders.customer_id);


-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT product_name
  FROM products
 WHERE product_id IN (
   SELECT product_id
     FROM order_details
     WHERE quantity = 10);
