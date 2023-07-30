This repository contains SQL queries that demonstrate various date-related operations, working with intervals, removing duplicates using DISTINCT, and using GROUPING SETS for grouping and aggregation. The SQL queries are designed to work with a database that includes tables such as "order_table," "products," "stock_level," and "orders."

Some of the key features and concepts covered in the SQL queries are:

Working with Dates:

Using DATE_TRUNC to round down dates to the first day of the month.
Utilizing EXTRACT to select specific components of a date, such as the month.
Date Arithmetic:

Using NOW() to get the current date and time.
Working with intervals using the interval keyword to perform date arithmetic.
DISTINCT:

Using DISTINCT to remove duplicate rows from the results.
Casting and Formatting Dates:

Employing casting to convert data types, for example, ::date.
Formatting dates using to_char to display the month in a specific format.
UNION and UNION ALL:

Combining results using UNION to return only unique values.
Demonstrating the difference between UNION and UNION ALL (which retains duplicates).
Aggregation and GROUP BY:

Grouping data using GROUP BY for aggregation purposes.
Calculating revenue and the number of orders for each product using SUM and COUNT.
Using GROUPING SETS to create multiple grouping sets for aggregated data.
Common Table Expressions (CTEs):

Utilizing CTEs to organize and simplify complex queries.
The SQL queries in this repository provide valuable examples of handling dates, performing calculations, aggregating data, and creating meaningful insights from the given database tables. Developers and SQL enthusiasts can learn from and adapt these queries for their specific projects or database scenarios.
