-- Создание таблицы "Заказы" (Orders)
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date date
);

-- Вставка данных в таблицу "Заказы"
INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
    (1, 101, '2024-02-01'),
    (2, 102, '2024-02-03'),
    (3, 103, '2024-02-05'),
    (4, 101, '2024-02-07'),
    (5, 104, '2024-02-10');

-- Создание таблицы "Товары в заказе" (Order_Items)
CREATE TABLE Order_Items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER
);

-- Вставка данных в таблицу "Товары в заказе"
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity)
VALUES
    (1, 1, 201, 2),
    (2, 1, 202, 1),
    (3, 2, 203, 3),
    (4, 3, 201, 1),
    (5, 3, 204, 2),
    (6, 4, 205, 1),
    (7, 5, 206, 4);

-- Создание таблицы "Клиенты" (Customers)
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT
);

-- Вставка данных в таблицу "Клиенты"
INSERT INTO Customers (customer_id, customer_name)
VALUES
    (101, 'Иванов Иван'),
    (102, 'Петров Петр'),
    (103, 'Сидоров Сидор'),
    (104, 'Алексеев Алексей'),
    (105, 'Дмитров Дмитрий'),
    (106, 'Леонов Леон')
;

-- Создание таблицы "Товары" (Products)
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    price DECIMAL(10, 2),
    category TEXT
);

-- Вставка данных в таблицу "Товары"
INSERT INTO Products (product_id, product_name, price, category)
VALUES
    (201, 'Товар1', 10.00, 'Категория1'),
    (202, 'Товар2', 15.00, 'Категория2'),
    (203, 'Товар3', 20.00, 'Категория1'),
    (204, 'Товар4', 25.00, 'Категория2'),
    (205, 'Товар5', 30.00, 'Категория1'),
    (206, 'Товар6', 35.00, 'Категория2');


CREATE view vw_report as 
    WITH first as (
    	SELECT order_id, sum(quantity*price) sum_order  from Order_Items
    	join Products on Products.product_id = Order_Items.product_id
    	GROUP by order_id 
    ),second as (
    	SELECT customer_id, max(sum_order) max_sum_order from Orders
    	join first on Orders.order_id = first.order_id
    	group by customer_id
    )
    SELECT customer_name, second.customer_id from second
    join Customers on Customers.customer_id = second.customer_id
    order by max_sum_order DESC LIMIT 3;
