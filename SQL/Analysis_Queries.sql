CREATE DATABASE IF NOT EXISTS EcommerceProfitLeakage;

use EcommerceProfitLeakage; 

create table categories (
CategoryID varchar(10) primary key,
CategoryName varchar(100) not null);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/categories.csv'
INTO TABLE categories
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CategoryID, CategoryName);

select * from categories;

CREATE TABLE suppliers (
    SupplierID VARCHAR(10) PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/suppliers.csv'
INTO TABLE suppliers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from suppliers;

CREATE TABLE products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Brand VARCHAR(100),
    CategoryID VARCHAR(10),
    SupplierID VARCHAR(10),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2),
    Description TEXT
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from products;

drop table warehouses;

CREATE TABLE warehouses (
    WarehouseID VARCHAR(10) PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    State VARCHAR(50),
    OpenedDate DATE,
    MaximunCapacity INT,
    ISactive VARCHAR(5)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/warehouses.csv'
INTO TABLE warehouses
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select *  from warehouses;

CREATE TABLE customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    RegistrationDate DATE,
    IsActive VARCHAR(5)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from customers;

CREATE TABLE promotions (
    PromotionID VARCHAR(10) PRIMARY KEY,
    ProductID VARCHAR(10) NOT NULL,
    DiscountPercent DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE,
    PromotionReason VARCHAR(255)
);

truncate table promotions;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/promotions.csv'
INTO TABLE promotions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from promotions;

CREATE TABLE inventory (
    InventoryID VARCHAR(10) PRIMARY KEY,
    ProductID VARCHAR(10) NOT NULL,
    WarehouseID VARCHAR(10) NOT NULL,
    StockQuantity INT,
    ReorderLevel INT,
    LastRestocked DATE
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/inventory.csv'
INTO TABLE inventory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from inventory;

CREATE TABLE orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    OrderDate DATE,
    OrderStatus VARCHAR(30),
    ExpectedDeliveryDate DATE,
    Delivereddate DATE
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    OrderID,
    CustomerID,
    OrderDate,
    OrderStatus,
    ExpectedDeliveryDate,
    @DeliveredDate
)
SET DeliveredDate = NULLIF(@DeliveredDate, 'none');

select * from orders;

drop table order_items;

CREATE TABLE order_items (
    OrderItemID VARCHAR(20) PRIMARY KEY,
    OrderID VARCHAR(20),
    ProductID VARCHAR(20),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    DiscountPercent DECIMAL(5,2),
    FinalSellingPrice DECIMAL(10,2),
    LineTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from order_items
limit 10;

CREATE TABLE payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) NOT NULL,
    PaymentMethod VARCHAR(30),
    PaymentStatus VARCHAR(30),
    PaymentDate DATE,
    AmountPaid DECIMAL(10,2)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from payments;

CREATE TABLE shipments (
    ShipmentID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) NOT NULL,
    WarehouseID VARCHAR(10) NOT NULL,
    ShippingPartner VARCHAR(100),
    ShipmentDate DATE,
    DeliveryDate DATE,
    ShipmentStatus VARCHAR(30)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/shipments.csv'
INTO TABLE shipments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    ShipmentID,
    OrderID,
    WarehouseID,
    ShippingPartner,
    @ShipmentDate,
    @DeliveryDate,
    ShipmentStatus
)
SET
    ShipmentDate = NULLIF(@ShipmentDate, ''),
    DeliveryDate = NULLIF(@DeliveryDate, '');
    
select * from shipments;    

CREATE TABLE returns (
    ReturnID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) NOT NULL,
    ReturnDate DATE,
    ReturnReason VARCHAR(100),
    RefundAmount DECIMAL(10,2),
    ReturnStatus VARCHAR(30)
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/returns.csv'
INTO TABLE returns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from returns;

drop table reviews;

CREATE TABLE reviews (
    ReviewID VARCHAR(10) PRIMARY KEY,
    OrderItemID VARCHAR(10) NOT NULL,
    Rating INT,
    ReviewTitle VARCHAR(255),
    ReviewText TEXT,
    ReviewDate DATE
);

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/E-commerce_dataset/E-commerce_dataset/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from reviews;

# validating the data.
select 'customers' as table_name, count(*) as total_records from customers 
union all 
select 'orders', count(*) from orders
union all
select 'order_items', count(*) from order_items 
union all
select 'products', count(*) from products 
union all 
select 'categories', count(*) from categories 
union all 
select 'suppliers', count(*) from suppliers 
union all
select 'warehouse', count(*) from warehouses 
union all
select 'inevntory', count(*) from inventory
union all 
select 'payments', count(*) from payments
union all 
select 'shipments', count(*) from shipments 
union all 
select 'returns', count(*) from returns 
union all 
select 'reviews', count(*) from reviews 
union all 
select 'promotions', count(*) from promotions 

select 'customers' as table_name,
sum(CustomerID is NULL) as missing_ID,
sum(CustomerName is NULL) as missing_name 
from customers 
union all 
select 'orders',
sum(OrderID is NULL),
sum(CustomerID is NULL)
from orders 
union all 
select 'products',
sum(ProductID is NULL),
sum(CategoryID is NULL)
from products 
union all 
select 'payments',
sum(PaymentID is NULL),
sum(OrderID is NULL)
from payments 
union all 
select 'returns',
sum(ReturnID is NULL),
sum(OrderID is NULL)
from returns 
union all 
select 'reviews',
sum(ReviewID is NULL),
sum(OrderItemID is NULL) 
from reviews;

# total revenue 
select sum(AmountPaid) as total_amount
from payments;

# average order value 
select round(sum(AmountPaid)/count(OrderID), 2) as average_order_value 
from payments;

# Which product categories generated the most revenue?
select c.CategoryName,round(sum(oi.FinalSellingPrice),2) as total_revenue
from order_items oi 
join products p 
on p.ProductID=oi.ProductID 
join categories c
on c.CategoryID=p.CategoryID 
group by CategoryName 
order by total_revenue desc;

# top 10 highest revenue products
select p.ProductName,round(sum(oi.FinalSellingPrice),2) as total_revenue 
from order_items oi 
join products p 
on p.ProductID=oi.ProductID 
group by ProductName 
order by total_revenue desc
limit 10;

# Which products generate the highest profit?
select p.ProductName, round(sum(oi.LineTotal - (p.CostPrice * oi.Quantity)), 2) as profit 
from order_items oi 
join products p
on p.ProductID=oi.ProductID
group by p.ProductID, p.ProductName
order by profit desc
limit 10;

# Show me the profit generated by each category.?
select c.CategoryName, round(sum(oi.LineTotal - (p.CostPrice*oi.Quantity)),2) as profit 
from order_items oi 
join products p 
on p.ProductID=oi.ProductID 
join categories c 
on p.CategoryID=c.CategoryID 
group by c.CategoryName;

# profit margin of each category
select c.CategoryName, sum(oi.LineTotal) as revenue, sum(p.CostPrice-oi.Quantity) as total_cost, sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit,
round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) as profit_margin 
from order_items oi 
join products p 
on p.ProductID=oi.ProductID 
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName 
order by profit_margin desc;

# How many orders has NOVACART received?
select count(*) as total_orders 
from orders;

# total unit sold 
select sum(Quantity) as total_unit_sold 
from order_items;

# average order value 
select (sum(LineTotal)/(count(*)))as average_order_value 
from order_items;

# How has our revenue changed month by month? Are sales growing, declining, or seasonal?
select month(OrderDate) as month_number, monthname(OrderDate) as month, sum(LineTotal) as revenue 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID
group by month, month_number
order by month_number;

# How many orders did we receive each month? Is the increase in revenue due to more orders or because customers spent more per order?
select month(OrderDate) as month_number, monthname(OrderDate) as month, count(*) as total_orders 
from orders 
group by month_number, month 
order by month_number desc;

# How many products were sold each month?
select month(OrderDate) as month, monthname(OrderDate) as month_name, sum(Quantity) as total_units_sold 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID 
group by month_name, month 
order by month;

# On which days do we generate the highest and lowest revenue?
select day(OrderDate) as day, sum(LineTotal) as revenue
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID 
group by day
order by revenue;

# Do customers spend more on weekdays or weekends?
select dayname(OrderDate) as day_name, sum(LineTotal) as revenue 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID 
group by day_name;

# Which product categories generate the most revenue?
select c.CategoryName, sum(oi.LineTotal) as revenue
from order_items oi 
join products p 
on p.ProductID=oi.ProductID 
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName
order by revenue desc;

# Which brands generate the highest revenue?
select p.Brand, sum(oi.LineTotal) as revenue 
from order_items oi 
join products p 
on oi.ProductID=p.ProductID 
group by p.Brand 
order by revenue desc;

# Top 10 Products by Revenue?
select p.ProductName, sum(oi.LineTotal) as revenue 
from order_items oi
join products p 
on p.ProductID=oi.ProductID
group by p.ProductName 
order by revenue desc 
limit 10;

# Which products are sold the most?
select p.ProductName, sum(oi.Quantity) as total_units_sold
from products p 
join order_items oi 
on oi.ProductID=p.ProductID 
group by p.ProductName 
order by total_units_sold desc 
limit 10;

# Find the Top 3 highest revenue-generating products in each category?
select * 
from 
(
    select 
      CategoryName,
      ProductName,
      revenue,
      rank() over (partition by CategoryName order by revenue desc) as productrank
	from
    ( 
       select c.CategoryName, p.ProductName, sum(oi.LineTotal) as revenue 
       from order_items oi 
       join products p 
       on p.ProductID=oi.ProductID 
       join categories c 
       on c.CategoryID=p.CategoryID 
       group by c.CategoryName, p.ProductName
    ) as revenuedata
) as rankedproducts
where productrank<=3 
order by CategoryName, productrank; 

# Some customers place multiple orders. I only want the latest order of every customer.?
select * 
from
( 
   select
        CustomerID,
        OrderID,
        OrderDate,
        row_number() over (partition by CustomerID order by OrderDate desc) as customer_rank
    from orders
) as latest
where customer_rank=1
order by OrderDate desc;

# Show the percentage increase or decrease in spending compared to the previous order?
select CustomerID,
       OrderID, 
       OrderDate, 
       order_amount,
       lag(order_amount) over (partition by CustomerID order by OrderDate) as previous_order
from 
( 
select
      o.OrderID,
      o.CustomerID,
      o.OrderDate,
      sum(oi.LineTotal) as order_amount 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID 
group by o.CustomerID,o.OrderDate,o.OrderID 
) as order_summary;

# increased or decreased in customers spending and percent_change
with order_summary as(
select o.OrderID,o.OrderDate,o.CustomerID, sum(oi.LineTotal) as order_amount
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID 
group by o.OrderID, o.OrderDate,o.CustomerID 
),
previousorder as 
( 
select OrderID,OrderDate,CustomerID,order_amount,
lag(order_amount) over (partition by CustomerID order by OrderDate) as previous_order 
from order_Summary 
) 
select OrderID,OrderDate,CustomerID,previous_order,order_amount,
case 
    when previous_order is null then 'first_order' 
    when order_amount > previous_order then 'increased' 
    else 'decreased' 
end as status, 
round(
((order_amount-previous_order)/previous_order)*100,2) as percentage_change
from previousorder;

# Which states generate the highest revenue?
select c.State,sum(oi.LineTotal) as revenue 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID 
join customers c 
on c.CustomerID=o.CustomerID
group by c.State 
order by revenue desc;

# which warehouses generate the highest revenue?
select w.WarehouseID,w.WarehouseName,sum(oi.LineTotal) as revenue 
from warehouses w 
join inventory i 
on w.WarehouseID=i.WarehouseID
join products p
on i.ProductID=p.ProductID 
join order_items oi 
on oi.ProductID=p.ProductID 
group by w.WarehouseID,w.WarehouseName 
order by revenue desc;

# which suppliers genetate the most revenue?
select s.SupplierID,s.SupplierName,sum(oi.LineTotal) as revenue
from suppliers s 
join products p
on s.SupplierID=p.SupplierID
join order_items oi 
on oi.ProductID=p.ProductID
group by s.SupplierID,s.SupplierName 
order by revenue desc;

# How much revenue does each category generate?
select c.CategoryID,c.CategoryName,sum(oi.LineTotal) as revenue,
round((
sum(LineTotal)/
( 
select sum(LineTotal) as total_revenue
from order_items)
)*100,2) as revenue_contribution
from categories c 
join products p 
on p.CategoryID=c.CategoryID
join order_items oi 
on oi.ProductID=p.ProductID
group by c.CategoryID,c.CategoryName
order by revenue desc;

 # PHASE 2 ANALYSIS
 
# Which categories are growing month-over-month, and which ones are declining?
with monthly_revenue as( 
select month(OrderDate) as month,c.CategoryName,sum(oi.LineTotal) as revenue 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID
join products p 
on p.ProductID=oi.ProductID
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName,month(OrderDate)
),
previous_month as(
select month,
	   CategoryName,
       revenue,
       lag(revenue) over (partition by CategoryName order by month) as previous_month 
from monthly_revenue
),
percentage_change as(
select month,
       CategoryName,
       revenue,
       previous_month,
       round(
       ( 
       (revenue-previous_month)
       /previous_month)
       *100,
       2) as month_growth
from previous_month
)
select * 
from percentage_change
order by CategoryName, month;

# Find the Top 3 fastest-growing categories based on average Month-over-Month growth.?
with monthly_revenue as( 
select month(OrderDate) as month,c.CategoryName,sum(oi.LineTotal) as revenue 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID
join products p 
on p.ProductID=oi.ProductID
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName,month(OrderDate)
),
previous_month as(
select month,
	   CategoryName,
       revenue,
       lag(revenue) over (partition by CategoryName order by month) as previous_month 
from monthly_revenue
),
percentage_change as(
select month,
       CategoryName,
       revenue,
       previous_month,
       round(
       ( 
       (revenue-previous_month)
       /previous_month)
       *100,
       2) as month_growth
from previous_month
),
average_growth as(
select avg(month_growth) as avg_growth, CategoryName
from percentage_change 
group by CategoryName 
),
ranking as( 
select CategoryName, avg_growth,
dense_rank() over (order by avg_growth desc) as growth_rank 
from average_growth
) 
select * 
from ranking 
where growth_rank<=3;

# Which category is the most profitable?
with monthly_revenue as( 
select month(OrderDate) as month,c.CategoryName,sum(oi.LineTotal) as revenue 
from orders o 
join order_items oi 
on o.OrderID=oi.OrderID
join products p 
on p.ProductID=oi.ProductID
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName,month(OrderDate)
),
previous_month as(
select month,
	   CategoryName,
       revenue,
       lag(revenue) over (partition by CategoryName order by month) as previous_month 
from monthly_revenue
),
percentage_change as(
select month,
       CategoryName,
       revenue,
       previous_month,
       round(
       ( 
       (revenue-previous_month)
       /previous_month)
       *100,
       2) as month_growth
from previous_month
),
average_growth as(
select avg(month_growth) as avg_growth, CategoryName
from percentage_change 
group by CategoryName 
),
category_profit as( 
select c.CategoryName, round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity)),2) as profit 
from order_items oi 
join products p 
on p.ProductID=oi.ProductID 
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName
),
combined_metrics as( 
select ag.avg_growth, cp.CategoryName, cp.profit 
from category_profit cp 
join average_growth ag 
on cp.CategoryName=ag.CategoryName 
)
select CategoryName,profit,avg_growth 
from combined_metrics 
order by profit desc, avg_growth desc 
limit 3;

# Which products look successful but actually make us very little money?
select p.ProductName,sum(oi.LineTotal) as revenue, sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit,
round(sum(oi.LineTotal-(P.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) as profit_margin 
from products p 
join order_items oi 
on p.ProductID=oi.ProductID 
group by p.ProductName 
having sum(oi.LineTotal) > 50000000 and 
round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) < 5
order by revenue desc;

# Are higher discounts causing lower profit margins?
select sum(oi.LineTotal) as revenue, 
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit, 
round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) as profit_margin,
case 
    when oi.DiscountPercent between 0 and 10 then '0-10%'
    when oi.DiscountPercent between 11 and 20 then '11-20%' 
    when oi.DiscountPercent between 21 and 30 then '21-30%'
    when oi.DiscountPercent between 31 and 40 then '31-40%'
    else '40%+' 
end as discount_bucket
from products p 
join order_items oi 
on p.ProductID=oi.ProductID 
join promotions pi 
on pi.ProductID=oi.ProductID 
group by discount_bucket
order by profit_margin asc;
 
# Top 10 products that have the highest revenue but a profit margin below 10%.?
select p.ProductName,
sum(oi.LineTotal) as revenue, 
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit, 
round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) as profit_margin
from products p 
join order_items oi 
on p.ProductID=oi.ProductID 
join promotions pi 
on pi.ProductID=oi.ProductID 
where oi.DiscountPercent between 0 and 10 
group by p.ProductName 
having round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) < 10 
order by revenue desc 
limit 10;

# PHASE 3 

# Why are we losing money on every sale despite giving only a small discount? 
select p.ProductName,p.CostPrice,sum(oi.Quantity) as total_units,avg(FinalSellingPrice) as avg_selling_price,
round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.Quantity),2) as profit_per_unit,
round((p.CostPrice-avg(oi.FinalSellingPrice))/avg(oi.FinalSellingPrice)*100,2) as required_price_increase_pct
from products p 
join order_items oi 
on oi.ProductID=p.ProductID 
where ProductName in ('Galaxy S25','MacBook Air M4','ThinkPad E14') 
and DiscountPercent between 0 and 10 
group by p.ProductName,p.CostPrice; 

# Are some suppliers providing products that generate high revenue but poor profitability? Which suppliers should we investigate or renegotiate with?
select s.SupplierName,sum(oi.LineTotal) as revenue,
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit,round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) as profit_margin,
count(distinct p.ProductID) as products_supplied  
from suppliers s 
join products p 
on s.SupplierID=p.SupplierID 
join order_items oi 
on oi.ProductID=p.ProductID
group by s.SupplierName 
having profit_margin < 5 
order by revenue desc;

# Which products supplied by Redington India and Evergreen Wholesale are causing their losses? 
select s.SupplierName,p.ProductName,sum(oi.LineTotal) as revenue,
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit, 
round(sum(oi.LineTotal-(p.CostPrice*oi.Quantity))/sum(oi.LineTotal)*100,2) as profit_margin
from suppliers s 
join products p 
on p.SupplierID=s.SupplierID 
join order_items oi 
on oi.ProductId=p.ProductID 
where s.SupplierName in ('Redington India','Evergreen Wholesale')
group by s.SupplierName,p.ProductName 
having profit<0 
order by profit asc;

# Which products lose the largest amount of expected profit because of discounts, even if they remain profitable overall?
select p.ProductName, sum((p.SellingPrice-p.CostPrice)*oi.Quantity) as expected_profit, 
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as actual_profit, 
sum((p.SellingPrice-p.CostPrice)*oi.Quantity) - (sum(oi.LineTotal-(p.CostPrice*oi.Quantity))) as profit_leakage
from products p 
join order_items oi 
on oi.ProductID=p.ProductID 
group by p.ProductName 
order by profit_leakage desc;

# What percentage of expected profit is being lost due to discounts? 
with leakage as(
select p.ProductName, sum((p.SellingPrice-p.CostPrice)*oi.Quantity) as expected_profit, 
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as actual_profit, 
sum((p.SellingPrice-p.CostPrice)*oi.Quantity) - (sum(oi.LineTotal-(p.CostPrice*oi.Quantity))) as profit_leakage
from products p 
join order_items oi 
on oi.ProductID=p.ProductID 
group by p.ProductName 
order by profit_leakage desc
)
select productname,expected_profit,actual_profit,profit_leakage,
round(profit_leakage/expected_profit*100,2) as leakage_pct 
from leakage
order by profit_leakage desc; 

# Which products have BOTH high absolute leakage and high leakage percentage? 
with leakage as(
select p.ProductName, sum((p.SellingPrice-p.CostPrice)*oi.Quantity) as expected_profit, 
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as actual_profit, 
sum((p.SellingPrice-p.CostPrice)*oi.Quantity) - (sum(oi.LineTotal-(p.CostPrice*oi.Quantity))) as profit_leakage
from products p 
join order_items oi 
on oi.ProductID=p.ProductID 
group by p.ProductName 
order by profit_leakage desc
)
select productname,expected_profit,actual_profit,profit_leakage,
round(profit_leakage/expected_profit*100,2) as leakage_pct 
from leakage 
where profit_leakage > 10000000 and round(profit_leakage/expected_profit*100) > 60
order by profit_leakage desc;

# Which discount levels are responsible for the most estimated margin leakage? 
with leakage as(
select oi.DiscountPercent, sum(oi.LineTotal) as revenue, sum((p.SellingPrice-p.CostPrice)*oi.Quantity) as expected_profit,
sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as actual_profit, 
sum((p.SellingPrice-p.CostPrice)*oi.Quantity) - sum(oi.LineTotal-(p.CostPrice*oi.Quantity)) as profit_leakage
from products p 
join order_items oi 
on oi.ProductID=p.ProductID 
group by oi.DiscountPercent
) 
select discountpercent,expected_profit,actual_profit,profit_leakage,
round(profit_leakage/expected_profit*100,2) as leakage_pct 
from leakage 
order by profit_leakage desc;

# PHASE 4 
# How much revenue and potential profit is being lost because of returned/refunded orders, and which products/categories contribute most?

# How many orders are Delivered, Returned, and Cancelled?
select OrderStatus,count(OrderID) total_orders,
round(count(OrderID)/sum(count(OrderID)) over()*100,2) as status_rate
from orders
group by OrderStatus;

# How much order value is associated with Returned and Cancelled orders? 
select o.OrderStatus,count(distinct o.OrderID) as total_orders,sum(oi.LineTotal) as total_order_value 
from orders o 
join order_items oi
on o.OrderID=oi.OrderID 
where o.OrderStatus in ('Returned','Cancelled') 
group by o.OrderStatus; 

# How much money has actually been refunded, and what are the major reasons for returns? 
select ReturnReason,count(ReturnID) as total_returns, sum(RefundAmount) as total_refundamount, avg(RefundAmount) as avg_refundamount 
from returns 
where ReturnStatus='Refunded'
group by ReturnReason
order by total_refundamount desc;

# late-deliveries by shipping partners? 
select s.ShippingPartner,count(ReturnID) as late_returns,sum(r.RefundAmount) as total_refund,avg(r.RefundAmount) as avg_refund
from shipments s 
join returns r 
on r.OrderID=s.OrderID
where r.ReturnReason='late delivery' and r.ReturnStatus='Refunded' 
group by s.ShippingPartner 
order by total_refund desc;

# Is Delhivery actually the worst-performing partner, or does it simply have the highest refund amount because it handles the most shipments?
with total_shipments as(
select ShippingPartner,count(ShipmentID) as total_shipments 
from shipments 
group by ShippingPartner
), 
late_returns as( 
select s.ShippingPartner,count(ReturnID) as late_returns,sum(r.RefundAmount) as total_refund,avg(r.RefundAmount) as avg_refund
from shipments s 
join returns r 
on r.OrderID=s.OrderID
where r.ReturnReason='late delivery' and r.ReturnStatus='Refunded' 
group by s.ShippingPartner 
)
select ts.shippingPartner,ts.total_shipments,lr.late_returns,
round(late_returns/total_shipments*100,2) as late_return_rate 
from total_shipments ts 
join late_returns lr 
on ts.ShippingPartner=lr.ShippingPartner 
order by late_return_rate desc;

# Are certain warehouses associated with more late-delivery refunded returns? 
select w.WarehouseName,count(r.ReturnID) as late_returns,sum(r.RefundAmount) as total_refund,avg(r.RefundAmount) as avg_refund 
from warehouses w 
join shipments s 
on s.WarehouseID=w.WarehouseID
join returns r 
on r.OrderID=s.OrderID 
where r.ReturnReason='late delivery' and r.ReturnStatus='Refunded'
group by w.WarehouseName 
order by total_refund desc;

with warehouse_shipments as(
select w.WarehouseID,w.WarehouseName,count(s.ShipmentID) as total_shipments 
from warehouses w 
join shipments s
on s.WarehouseID=w.WarehouseID
group by w.WarehouseID
), 
late_return as( 
select w.WarehouseID,count(r.ReturnID) as late_returns 
from warehouses w 
join shipments s 
on s.WarehouseID=w.WarehouseID
join returns r 
on r.OrderID=s.OrderID 
where r.ReturnReason='late delivery' and r.ReturnStatus='Refunded'
group by w.WarehouseID
)
select ws.WarehouseName,ws.total_shipments,lr.late_returns,
round(lr.late_returns/ws.total_shipments*100,2) as late_return_rate 
from warehouse_shipments ws 
join late_return lr 
on lr.WarehouseID=ws.WarehouseID 
order by late_return_rate desc;

# PHASE 5 
# Identify whether poor inventory management is creating lost-sales opportunities or tying up money in excess stock. 

# Which inventory records are currently at or below their reorder level?
select p.ProductName,w.WarehouseName,i.StockQuantity,i.ReorderLevel 
from inventory i 
join products p 
on p.ProductID=i.ProductID 
join warehouses w 
on w.WarehouseID=i.WarehouseID 
where i.StockQuantity<=i.ReorderLevel;

# Which high-selling products currently have low stock?
select p.ProductName,w.WarehouseName,sum(oi.Quantity) as units_sold,i.StockQuantity,i.ReorderLevel
from shipments s 
join order_items oi
on oi.OrderID=s.OrderID 
join products p 
on p.ProductID=oi.ProductID 
join warehouses w 
on w.WarehouseID=s.WarehouseID 
join inventory i 
on i.ProductID=p.ProductID and w.WarehouseID=i.WarehouseID 
where i.StockQuantity<=i.ReorderLevel
group by p.ProductID,p.ProductName,w.WarehouseID,w.WarehouseName,i.StockQuantity,i.ReorderLevel
order by units_sold desc;

# hyderabad warehouse overview 
select p.ProductName,w.WarehouseName,sum(oi.Quantity) as units_sold,i.StockQuantity,i.ReorderLevel,
round(i.StockQuantity/sum(oi.Quantity),2) as stock_sales_ratio
from shipments s 
join order_items oi
on oi.OrderID=s.OrderID 
join products p 
on p.ProductID=oi.ProductID 
join warehouses w 
on w.WarehouseID=s.WarehouseID 
join inventory i 
on i.ProductID=p.ProductID and w.WarehouseID=i.WarehouseID 
where w.WarehouseName='Hyderabad Central Dc'
group by p.ProductID,p.ProductName,w.WarehouseID,w.WarehouseName,i.StockQuantity,i.ReorderLevel
order by stock_sales_ratio asc;

# How many products are below the reorder level in each warehouse? 
select w.WarehouseName,count(*) as products_below_reorder 
from warehouses w 
join inventory i 
on i.WarehouseID=w.WarehouseID 
where i.StockQuantity<i.ReorderLevel 
group by w.WarehouseName 
order by products_below_reorder desc;

# Which warehouse has the greatest business impact because of low inventory?
select w.WarehouseName,count(distinct i.ProductID) as low_stock_products,sum(oi.Quantity) as total_units_sold 
from inventory i 
join warehouses w 
on w.WarehouseID=i.WarehouseID
join shipments s 
on s.WarehouseID=w.WarehouseID
join order_items oi 
on s.OrderID=oi.OrderID and oi.ProductID=i.ProductID 
where i.StockQuantity<i.ReorderLevel 
group by w.WarehouseName
order by total_units_sold desc;

# inventory gap and shortage of prodcuts? 
with demand as( 
select w.WarehouseName,sum(oi.Quantity) as total_units_sold 
from shipments s 
join order_items oi 
on oi.OrderID=s.OrderID 
join warehouses w 
on w.WarehouseID=s.WarehouseID 
group by w.WarehouseName 
),
storage as( 
select w.WarehouseName,count(distinct i.ProductID) as low_stock_products,sum(i.ReorderLevel-i.StockQuantity) as inventory_gap 
from inventory i  
join warehouses w 
on w.WarehouseID=i.WarehouseID 
where i.StockQuantity<i.ReorderLevel
group by w.WarehouseName
) 
select d.WarehouseName,s.low_stock_products,d.total_units_sold,s.inventory_gap 
from demand d 
join storage s 
on s.WarehouseName=d.WarehouseName 
order by inventory_gap desc;

# Show me the products that are below the reorder level and tell me how much each product has been sold till now.?
with units_sold as ( 
select s.WarehouseID,oi.ProductID,sum(oi.Quantity) as total_units_sold 
from shipments s 
join order_items oi 
on oi.OrderID=s.OrderID 
group by s.WarehouseID,oi.ProductID 
),
low_stock as(
select i.WarehouseID,i.ProductID,i.StockQuantity,i.ReorderLevel,(i.ReorderLevel-i.StockQuantity) as inventory_gap 
from inventory i
where i.StockQuantity<i.ReorderLevel 
)
select w.WarehouseName,p.ProductName,ls.StockQuantity,ls.ReorderLevel,ls.inventory_gap,us.total_units_sold 
from low_stock ls 
join units_sold us 
on us.WarehouseID=ls.WarehouseID and us.ProductID=ls.ProductID 
join warehouses w 
on w.WarehouseID=ls.WarehouseID
join products p 
on p.ProductID=ls.ProductID 
order by ls.inventory_gap desc,us.total_units_sold desc;

# Which products have significantly more stock than required while experiencing low demand? 
with product_sales as(
select oi.ProductID,sum(oi.Quantity) as total_units_sold,ntile(3) over (order by sum(oi.Quantity) desc) as movement_group
from order_items oi
group by oi.ProductID 
),
stocks as ( 
select i.ProductID,i.StockQuantity,i.ReorderLevel 
from inventory i 
where i.Stockquantity > i.ReorderLevel*2 
)
select p.ProductName,s.StockQuantity,s.ReorderLevel,ps.total_units_sold,
case 
   when movement_group=1 then 'Fast Moving' 
   when movement_group=2 then 'Medium Moving'
   else 'Slow Moving' 
end as movement_category    
from stocks s 
join product_sales ps 
on ps.ProductID=s.ProductID 
join products p 
on p.ProductID=ps.ProductID
order by ps.total_units_sold asc,s.StockQuantity desc;

# Which products currently have inventory but have never been sold?
select p.ProductID,p.ProductName,c.CategoryName,i.StockQuantity,i.ReorderLevel 
from inventory i  
left join order_items oi 
on oi.ProductID=i.ProductID 
inner join products p 
on p.ProductID=i.ProductID 
inner join categories c 
on c.CategoryID=p.CategoryID 
where oi.ProductID is null;

# Which products are selling quickly, and which products are moving slowly?
with product_sales as(
select oi.ProductID,sum(oi.Quantity) as total_units_sold,
ntile(3) over (order by sum(oi.Quantity) desc) as movement_group
from order_items oi 
group by oi.ProductID 
),
movement_classification as( 
select ProductID,total_units_sold,
case 
   when movement_group=1 then 'fast moving'
   when movement_group=2 then 'medium moving'
   else 'slow moving' 
end as movement_category 
from product_sales 
)
select p.ProductID,p.ProductName,c.CategoryName,mc.total_units_sold,mc.movement_category 
from movement_classification mc
inner join products p 
on p.ProductID=mc.ProductID 
inner join categories c 
on c.CategoryID=p.CategoryID 
order by mc.total_units_sold desc;

# Which product categories are healthy, and which categories need our attention?
with category_sales as( 
select c.CategoryName,sum(oi.LineTotal) as total_sales,sum(oi.Quantity) as demand 
from order_items oi 
join products p 
on oi.ProductID=p.ProductID 
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName 
),
stock as ( 
select c.CategoryName,sum(i.StockQuantity) as total_stock
from inventory i 
join products p 
on i.ProductID=p.ProductID 
join categories c 
on c.CategoryID=p.CategoryID 
group by c.CategoryName
)
select cs.CategoryName,cs.total_sales,cs.demand,coalesce(s.total_stock,0) as total_stock,
case 
   when s.total_stock>cs.demand then 'overstocked' 
   when s.total_stock<cs.demand then 'understocked' 
   else 'healthy' 
end as stocks_health 
from category_sales cs 
left join stock s 
on cs.CategoryName=s.CategoryName 
order by cs.total_sales desc; 

# "Which product categories are moving quickly, and which are sitting in our warehouse for too long?
with sales as( 
select c.CategoryName,sum(oi.Quantity) as total_units_sold 
from order_items oi 
join products p 
on p.ProductID=oi.ProductID
join categories c 
on c.CategoryID=p.CategoryID
group by c.CategoryName 
), 
category_stocks as( 
select c.CategoryName,sum(i.StockQuantity) as total_stock 
from inventory i 
join products p 
on p.ProductID=i.ProductID
join categories c 
on c.CategoryID=p.CategoryID
group by c.CategoryName 
)
select s.CategoryName,s.total_units_sold,cs.total_stock,(s.total_units_sold/nullif(cs.total_stock,0)) as inventory_turnover 
from sales s 
left join category_stocks cs 
on cs.CategoryName=s.CategoryName 
order by inventory_turnover desc;

# PHASE 6 
# This is one of the most valuable phases because companies don't just want to know what was sold—they want to understand who is buying and how customers behave.

# How much revenue did each customer generate(top 10)?
select c.CustomerID,c.CustomerName,sum(oi.LineTotal) as revenue 
from customers c 
join orders o
on c.CustomerID=o.CustomerID 
join order_items oi 
on o.OrderID=oi.OrderID 
group by c.CustomerID,c.CustomerName 
order by revenue desc
limit 10;

# How many orders has each customer placed? 
select c.CustomerID,CustomerName,count(OrderID) as total_orders 
from customers c 
join orders o 
on o.CustomerID=c.CustomerID 
group by c.CustomerID,c.CustomerName 
order by total_orders desc;

# On average, how much money does a customer spend in a single order? 
select c.CustomerID,c.CustomerName,count(distinct o.OrderID) as total_order,sum(oi.LineTotal) as revenue, 
sum(oi.LineTotal)/count(distinct o.OrderID) as average_order_value 
from customers c 
join orders o 
on c.CustomerID=o.CustomerID 
join order_items oi 
on oi.OrderID=o.OrderID 
group by c.CustomerName,c.CustomerID
order by average_order_value desc;

# If I have a budget to retain only 100 customers, which customers should I invest in?
select c.CustomerID,c.CustomerName,sum(oi.LineTotal) as clv,min(o.OrderDate) as first_order,max(o.OrderDate) as latest_order,
datediff(max(o.OrderDate),min(o.OrderDate)) as customer_days,c.IsActive
from customers c 
join orders o 
on c.CustomerID=o.CustomerID 
join order_items oi 
on oi.OrderID=o.OrderID 
group by c.CustomerID,c.CustomerName 
order by clv desc;

# I want to know which customers are still active and which customers have stopped buying from us?
with latest_date as (
select max(OrderDate) as latest_order_date
from orders 
),
customer_recency as ( 
select c.CustomerID,c.CustomerName,sum(oi.LineTotal) as customer_value,min(o.OrderDate) as first_order,
max(o.OrderDate) as latest_order,datediff(max(o.OrderDate),min(o.OrderDate)) as customer_days,
datediff(ld.latest_order_date,max(o.OrderDate)) as recency_days 
from customers c 
join orders o 
on o.CustomerID=c.CustomerID
join order_items oi
on oi.OrderID=o.OrderID 
cross join latest_date ld 
group by c.CustomerID,c.CustomerName,ld.latest_order_date 
)
select CustomerID,CustomerName,first_order,latest_order,customer_value,customer_days,recency_days,
case 
    when recency_days <=30 then 'Active' 
    when recency_days<=90 then 'IN Active' 
    else 'Lost'
 end as customer_status 
 from customer_recency 
 order by customer_value desc;
 
# I have 50,000 customers. I can't give discounts to everyone. Tell me which customers deserve rewards,
# which customers are becoming inactive, and which customers we've already lost.?
with latest_date as (
select max(OrderDate) as latest_order_date
from orders 
),
customer_recency as ( 
select c.CustomerID,c.CustomerName,sum(oi.LineTotal) as monetary,count(distinct o.OrderID) as frequency,
datediff((select latest_order_date from latest_date),max(o.OrderDate)) as recency_days 
from customers c 
join orders o 
on c.CustomerID=o.CustomerID
join order_items oi
on o.OrderID=oi.OrderID 
group by c.CustomerID,c.CustomerName
),
rfm_scores as (
select CustomerID,CustomerName,monetary,frequency,recency_days,
6-ntile(5) over (order by monetary desc) as m_score,
6-ntile(5) over (order by frequency desc) as f_score, 
6-ntile(5) over (order by recency_days asc) as r_score 
from customer_recency 
)
select CustomerID,CustomerName,monetary,frequency,recency_days,m_score,f_score,r_score,
concat(r_score,f_Score,m_score) as rfm_score, 
case
when concat(r_score,f_score,m_score) in ('555','554','545','544','455') 
then 'champion' 
when concat(r_score,f_score,m_score) in ('454','445','444','543','453','443','355') 
then 'Loyal Customer' 
when concat(r_score,f_score,m_score) in ('553','552','551','452','451','442','441') 
then 'Potential Loyalist' 
when r_score=5 and f_score<=2 
then 'New Customer' 
when r_score=3 and f_score<=3  
then 'Need Attention' 
when r_score<=2 and f_score>=4 
then 'At Risk' 
when r_score=1 and f_score=1 
then 'Lost Customer' 
else 'others' 
end as  customer_segment
from rfm_scores
order by r_score desc,f_score desc,m_score desc;
