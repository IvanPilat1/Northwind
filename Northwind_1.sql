-- 1.Запит на вибірку всіх продуктів з їхніми цінами та кількостями в наявності:
-- Це дозволить вам переглянути інвентар продуктів, які доступні в магазині.

select  product_name 
       ,unit_price 
       ,units_in_stock 
       ,unit_price * units_in_stock as total_cost
FROM products p;

-- 2.Запит на вибірку 10 клієнтів , які зробили найбільшу кількість замовлень: 
-- Це дозволить вам ідентифікувати найактивніших клієнтів.

 select customer_id 
        ,count(*)
from orders o  
group by customer_id
order by customer_id desc 
limit 10;

-- 3.Запит на вибірку замовлень за певний період часу: 
-- Це дозволить вам аналізувати тенденції замовлень в залежності від часу.

select   *
from orders o  
WHERE order_date BETWEEN '1998-01-01' AND '1998-12-31';

-- 4.Запит на вибірку працівників та їхніх даних про зайнятість:
-- Це дозволить вам оцінити робочу активність працівників.

select e.employee_id 
       ,e.last_name 
       ,e.first_name 
       ,e.title  
       ,count( o.order_date) as number_of_orders
from  employees e
join orders o on e.employee_id = o.employee_id 
group by e.employee_id,e.last_name ,e.first_name ,e.title 
order by e.employee_id;


-- 5.Запит на вибірку категорій продуктів та кількості продуктів в кожній категорії:
-- Це дозволить вам оцінити розподіл продуктів за категоріями.

select c.category_id 
       ,c.category_name 
       ,COUNT(p.product_id) AS product_count
from categories c 
join products p on c.category_id = p.category_id 
group by c.category_id 
order by c.category_id 

-- 6.Запит на вибірку найпопулярніших товарів за кількістю замовлень:
-- Це дозволить вам визначити найбільш популярні продукти.

select p.product_name 
       ,count(o.order_id) 
from order_details od 
join orders o on od.order_id = o.order_id 
join products p on od.product_id = p.product_id 
group by 1
order by 2 desc
limit 10;


-- 7.Запит на вибірку країн, з яких здійснюються замовлення, та загальної суми замовлень за кожну країну:
-- Це дозволить вам оцінити географічний розподіл замовлень.


select c.region 
       , round(sum(CAST(od.unit_price AS decimal)),2)
from orders o 
join customers c on o.customer_id = c.customer_id 
join order_details od on o.order_id = od.order_id 
group by 1;

-- 8.Запит на вибірку середньої ціни продуктів за кожною категорією: 
-- Це дозволить вам порівняти ціни на продукти в різних категоріях.

SELECT c.category_name, 
       AVG(p.unit_price) AS average_price
FROM categories c 
JOIN products p ON c.category_id = p.category_id 
GROUP BY c.category_name;


-- 9.Запит на вибірку товарів, які необхідно замовити, оскільки їх кількість в наявності занадто мала: 
-- Це дозволить вам керувати запасами та вчасно робити замовлення.

select product_id 
       ,product_name 
       ,(units_in_stock - units_on_order) * -1 as ReorderLevel
from products p 
where units_in_stock - units_on_order < 0;

-- 10.Запит на вибірку товарів, які були замовлені, але не мають відповідного запису у таблиці відвантажень:
-- Цей запит допоможе виявити товари, які були замовлені, але за якими ще не проведена відвантаження.
-- Це може бути корисно для виявлення потенційних проблем з логістикою або відслідковування замовлень, які ще не були виконані.

select order_id 
       ,order_date 
       ,shipped_date 
from orders o  
where shipped_date is Null

 