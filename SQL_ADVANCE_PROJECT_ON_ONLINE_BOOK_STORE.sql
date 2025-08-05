create database OnlineBookstore;
use OnlineBookstore;

drop table if exists Books;
create table Books (
Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int
);

drop table if exists Customers;
create table Customers (
Customer_ID serial primary key,
Name varchar(100),
Email varchar(100),
Phone int ,
City varchar(50),
Country varchar(150)
);

select * from Books;
select * from Customers; 
select * from Orders; 

-- Basic Queries questions:

-- 1. Retrieve all books in the "Fiction" genre:
select Book_ID, Title, Genre from Books 
where Genre="Fiction"; 

select * from Books 
where Genre="Fiction";

-- 2. Find books published after the year 1950:
select * from Books
where Published_Year >= 1950;

-- 3. List all customers from the Canada:
select * from Customers
where Country = "Canada";

-- 4. Show orders placed in November 2023:
select * from Orders
where Order_Date 
between "2023-11-01"and "2023-11-30";

-- 5. Retrieve the total stock of Books available :
select sum(Stock) as Total_stock 
from Books;

-- 6. Find the details of the most expensive book:
select * 
from Books 
order by Price desc limit 1;

-- 7. Show all customers who ordered more than 1 quantity of a book:
select * from Orders 
where Quantity >1;

-- 8. TRetrieve all orders where the total amount exeeds $20:
select * from Orders 
where Total_Amount > 20.00;

-- 9. list all genre available in the book table:
select distinct Genre 
from Books;

-- 10. Find the book with the lowest stock:
select * from Books 
order by Stock asc limit 1;

-- 11. Calculate the total revenue generated from all orders:
select sum(Total_Amount) as Revanue 
from Orders;

-- ADVANCE QUESTIONS :

-- 1. Retrieve the total number of books sold for each genre :
select b.Genre,sum( o.Quantity) as Total_sold_by_genre
from Books b Join Orders o on b.Book_ID = o.Book_ID
group by b.Genre 
order by Total_sold_by_genre desc;

-- 2. Find the average price of books in the "Fantasy" genre :
select Genre, avg(Price) as Average
from Books 
where Genre="Fantasy"; 

-- 3. List customers who have placed at least 2 orders:'''
SELECT o.Customer_ID, c.Name, COUNT(Order_ID) AS Order_Count
FROM orders o
JOIN customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(Order_ID) >=2;

-- 4. Find the most frequently ordered book:
SELECT o.Book_ID, b.Title,COUNT(o.Order_ID) AS Order_Count
FROM orders o 
JOIN books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC LIMIT 1; 

-- 5. Show the top 3 most expensive books of "Fantasy" Genre:
SELECT * FROM books
WHERE Genre = "Fantasy"
ORDER BY Price DESC LIMIT 3;

-- 6. Retrieve the total quantity of books sold by each author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM orders o 
JOIN books b ON o.Book_ID = b.Book_ID 
GROUP BY b.Author;

-- 7. List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City, Total_amount
FROM orders o 
JOIN customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_amount > 30; 

-- 8. Fund the customers whon spent the most on orders:
SELECT c.Customer_ID, c.Name, SUM(o.Total_amount) AS Total_Spent 
FROM orders o 
JOIN customers c ON o.Customer_ID = c.Customer_ID 
GROUP BY c.Customer_ID, c.Name 
ORDER BY Total_Spent DESC LIMIT 1; 

-- 9. Calculate the stock remaining after fulfilling all orders:
SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity),0) AS Order_Quantity, 
b.Stock-COALESCE(SUM(o.Quantity),0) AS Reamainig_Quantity
FROM books b
LEFT JOIN orders o ON b.Book_ID = o.Book_ID 
GROUP BY b.Book_ID ORDER BY b.Book_ID;