CREATE DATABASE Assign ;
USE Assign ;
CREATE TABLE Sales (
id INT PRIMARY KEY,
employee VARCHAR(50),
department VARCHAR(40),
sales_amount INT,
sales_Date DATE 
);
INSERT INTO Sales (id , employee , department , sales_amount , sales_Date ) VALUES 
(1, 'Alice', 'A', 1000, '2024-01-01'),
(2, 'Bob', 'B', 1500, '2024-01-02'),
(3, 'Alice', 'A', 2000, '2024-01-03'),
(4, 'Bob', 'B', 1800, '2024-01-04'),
(5, 'Alice', 'A', 1200, '2024-01-05'),
(6, 'Bob', 'B', 1600, '2024-01-06');
#ANSWER I 
SELECT *,
SUM(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS running_total
FROM Sales;
#ANSWER II
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS row_num
FROM Sales;
#ANSWER III
SELECT *,
RANK() OVER(
    PARTITION BY department
    ORDER BY sales_amount DESC
) AS sales_rank
FROM Sales;
#ANSWER IV
SELECT *,
LEAD(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS next_sale
FROM Sales;
#ANSWER V
SELECT *,
LAG(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS previous_sale
FROM Sales;
#ANSWER VI
SELECT *,
AVG(sales_amount) OVER(
    PARTITION BY employee
) AS avg_sales
FROM Sales;
#ANSWER VII
SELECT *,
FIRST_VALUE(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS first_sale,

LAST_VALUE(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS last_sale

FROM Sales;
#ANSWER VIII
SELECT *,
AVG(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS cumulative_avg
FROM Sales;
#ANSWER IX
SELECT *,
AVG(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS cumulative_avg
FROM Sales;
#ANSWER X
SELECT *,
MAX(sales_amount) OVER(
    PARTITION BY employee
) AS highest_sale
FROM Sales;
#ANSWER XI
SELECT *,
sales_amount -
LAG(sales_amount) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS sales_difference
FROM Sales;
#ANSWER XII
SELECT *,
COUNT(*) OVER(
    PARTITION BY employee
    ORDER BY sale_date
) AS cumulative_count
FROM Sales;
#ANSWER XIII
SELECT *,
CASE
    WHEN sales_amount >
         AVG(sales_amount) OVER(PARTITION BY employee)
    THEN 'Above Average'
    ELSE 'Below Average'
END AS sale_status
FROM Sales;
#ANSWER XIV 
SELECT *
FROM (
    SELECT *,
    DENSE_RANK() OVER(
        PARTITION BY employee
        ORDER BY sales_amount DESC
    ) AS rnk
    FROM Sales
) t
WHERE rnk = 2;