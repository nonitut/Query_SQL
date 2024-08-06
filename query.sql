
-- Для вывода всех записей из таблицы `products`, включая поля `product_id`, `name` и `price`
SELECT product_id, name, price
FROM products;

-- Если тебе нужно вывести все столбцы из таблицы, ты можешь использовать звездочку `*`:
SELECT *
FROM products;

-- Теперь добавим сортировку к нашему запросу, чтобы отсортировать записи по наименованиям товаров в алфавитном порядке
SELECT product_id, name, price
FROM products
ORDER BY name;

-- При явном указании сортировки по возрастанию, то запрос будет таким:
SELECT product_id, name, price
FROM products
ORDER BY name ASC;

-- Для выполнения задания, в котором необходимо отсортировать таблицу `courier_actions` по нескольким колонкам и ограничить результат первыми 1000 строками, запрос будет выглядеть следующим образом:
SELECT courier_id, order_id, action, time
FROM courier_actions
ORDER BY courier_id ASC, action ASC, time DESC
LIMIT 1000;

-- Для определения 5 самых дорогих товаров в таблице `products`, необходимо отсортировать товары по цене в порядке убывания и ограничить количество выводимых записей до 5. 
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Переименования колонок `name` и `price` в `product_name` и `product_price` соответственно, запрос будет выглядеть следующим образом:
SELECT name AS product_name, price AS product_price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Определим товар с самым длинным названием в таблице `products`, нужно использовать функцию `LENGTH` для подсчета длины наименования, а затем отсортировать результаты по длине наименования и ограничить вывод одной записью. 
SELECT name, LENGTH(name) AS name_length, price
FROM products
ORDER BY name_length DESC
LIMIT 1;

-- Первое слово из наименования товара, преобразовать его в верхний регистр с помощью функций `UPPER` и `SPLIT_PART`, а затем вывести исходные наименования, новые наименования и цену, можно использовать следующий SQL-запрос:
SELECT name,
    UPPER(SPLIT_PART(name, ' ', 1)) AS first_word,
    price
FROM products
ORDER BY name ASC;

-- Изменим тип данных колонки `price` из таблицы `products` на `VARCHAR` и выводим наименование товаров, цену в исходном формате и цену в формате `VARCHAR`, можно использовать функцию `CAST`. 
SELECT name,
    price,
    CAST(price AS VARCHAR) AS price_char
FROM products
ORDER BY name ASC;

-- Чтобы вывести информацию о первых 200 записях из таблицы `orders` в формате, можно использовать функцию `CONCAT` для соединения строк. Мы также преобразуем значение даты из колонки `creation_time` с помощью функции `DATE` или `CAST`.
SELECT CONCAT('Заказ № ', order_id, ' создан ', DATE(creation_time)) AS order_info
FROM orders
LIMIT 200;

-- Чтобы извлечь идентификаторы курьеров и их годы рождения из таблицы `couriers`, воспользуемся функцией `DATE_PART` для получения года из колонки `birth_date`.
SELECT courier_id,
    DATE_PART('year', birth_date) AS birth_year
FROM couriers
ORDER BY birth_year DESC,
    courier_id ASC;

-- Извлечем идентификаторы курьеров и их годы рождения, заменяя `NULL` значения на текст "unknown", мы можем использовать функцию `COALESCE` в сочетании с `DATE_PART` и `CAST` для приведения года к типу `VARCHAR`
SELECT courier_id,
    COALESCE(CAST(DATE_PART('year', birth_date) AS VARCHAR), 'unknown') AS birth_year
FROM couriers
ORDER BY birth_year DESC,
    courier_id ASC;

-- Чтобы вывести идентификаторы товаров, их наименования, старые и новые цены с увеличением на 5%, мы можем использовать арифметические операции для вычисления новой цены
SELECT product_id,
    name,
    price AS old_price,
    price * 1.05 AS new_price
FROM products
ORDER BY new_price DESC,
        product_id ASC;

-- Чтобы повысить цену всех товаров на 5% и округлить новую цену до одного знака после запятой, мы будем использовать функцию `ROUND`. Запрос будет выглядеть следующим образом:
SELECT product_id,
    name,
    price AS old_price,
    ROUND(price * 1.05, 1) AS new_price
FROM products
ORDER BY new_price DESC,
    product_id ASC;

-- Чтобы повысить цену на 5% только для тех товаров, цена которых превышает 100 рублей, и исключить икру, можно использовать конструкцию `CASE`. 
SELECT product_id,
    name,
    price AS old_price,
    CASE
           WHEN price > 100 AND name <> 'икра' THEN price * 1.05
        ELSE price
    END AS new_price
FROM products
ORDER BY new_price DESC,
    product_id ASC;

-- Чтобы рассчитать НДС для каждого товара и определить цену без учета налога, можно использовать следующую формулу:
-- - НДС = (цена / 1.2) * 0.2
-- - Цена без НДС = цена / 1.2
-- На основании этого формулы можно составить SQL-запрос
SELECT product_id,
    name,
    price,
    ROUND(price * 0.2 / 1.2, 2) AS tax,
    ROUND(price / 1.2, 2) AS price_before_tax
FROM products
ORDER BY price_before_tax DESC,
    product_id ASC;


-- Таблица с тегами и их значениями:
-- | Тег          | Описание                                                                                         |
-- |--------------|--------------------------------------------------------------------------------------------------|
-- | SELECT       | Указывает, какие поля или вычисления нужно вернуть в результирующем наборе данных.               |
-- | FROM         | Указывает, из какой таблицы нужно извлечь данные.                                                |
-- | ORDER BY     | Указывает порядок сортировки результирующих записей.                                             |
-- | LIMIT        | Ограничивает количество выводимых записей до указанного значения.                                |
-- | AS           | Используется для присвоения псевдонима (алиаса) колонке или вычисляемому полю.                   |
-- | ROUND        | Функция для округления числовых значений до указанного числа знаков после запятой.               |
-- | COALESCE     | Возвращает первое не NULL значение из списка аргументов.                                         |
-- | DATE_PART    | Извлекает определённую часть даты (например, год, месяц, день) из значения даты.                 |
-- | CAST         | Преобразует одно значение в другой тип данных.                                                   |
-- | CONCAT       | Соединяет строки или значения из нескольких столбцов в одну строку.                              |
-- | LENGTH       | Возвращает длину строки.                                                                         |
-- | SPLIT_PART   | Делит строку по указанному разделителю и возвращает указанную часть.                             |
-- | CASE         | Условная конструкция для выполнения разных действий в зависимости от заданных условий.           |
-- | WHEN         | Указывает условие в конструкции CASE.                                                            |
-- | THEN         | Указывает результат, который будет возвращён, если условие в WHEN истинно.                       |
-- | ELSE         | Указывает значение, которое будет возвращено, если ни одно из условий не истинно (опционально).  |
-- | *            | Звёздочка, обозначающая выбор всех столбцов из указанной таблицы.                                |
-- | WHERE        | Условия для фильтрации данных в запросах (не использовались в приведённых примерах, но часто встречаются). |
