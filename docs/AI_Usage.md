**Ai Usage:** 1

**Task Context:**

The assessment required at least 50--100 additional payment records and
additional rental records. The

The original database only contained a small number of records.

I used AI to understand how PostgreSQL could generate a larger dataset
efficiently rather than manually writing every INSERT statement.

**Tool Used:**

ChatGPT

**Example prompt:**

" I need to insert over 50 payment records and additional 20 renal
records. Guide me on how I can insert this data without manual
insertion.

**How the output was modified:**

A generate_series() approach was suggested for creating additional
payment and rental records.

I would adapt the generated values to match the customers actually
present in my database and verify the final number of records using
COUNT(\*).

**What I learnt:**

I learned how generate_series() can be used in PostgreSQL to generate
test data efficiently.

**Ai Usage:** 2

**Task Context:**

The assessment required a query using a correlated subquery to identify
customers whose total spending exceeded the personalised threshold.

**Tool Used:**

ChatGPT

**Example prompt:**

\"Explain the correlated subquery requirement step by step using my
customers and

payment tables.\"

**How the output was modified:**

The suggested query was adapted to my actual table and column names.

I replaced MY_THRESHOLD with my personalised value based on my
student_id.

**What I learnt:**

I learned why the query is called a correlated subquery. The inner query
references c.customer_id from the outer query. So the inner query
depends on the current customer being processed by the outer query.

**Ai Usage:** 3

**Task Context:**

The assessment required the correlated-subquery solution to be rewritten
using a JOIN-based approach.

**Tool Used:**

ChatGPT

**Example prompt:**

\"Show me how to rewrite the correlated spending query using a JOIN and
explain the

Difference.\"

**How the output was modified:**

I adapted the query to my database:

I then compared the results against the correlated-subquery version to
ensure both approaches identified the same customers.

**What I learnt:**

I learned how JOINs can be used with GROUP BY , SUM() , and HAVING to
perform aggregate analysis.

**Ai Usage:** 4

**Task Context:**

The assessment required a PostgreSQL function that returns the total
number of rentals for a specified customer.

**Tool Used:**

ChatGPT

**Example prompt:**

\"Explain how to create a PostgreSQL function that accepts a customer ID
and returns the

number of rentals for that customer.\"

**How the output was modified:**

The suggested function was adapted to the actual rentals table.

I then tested it with several customer IDs.

**What I learnt:**

I learned the difference between a PostgreSQL function and an ordinary
SQL query. The function

accepts a parameter, performs database operations, and returns a value.

**Ai Usage:** 5

**Task Context:**

The assessment required a stored procedure that updates customer
information.

**Tool Used:**

ChatGPT

**Example prompt:**

\"Create a PostgreSQL stored procedure that updates customer information
using my

personalised customer table.\"

**How the output was modified:**

The procedure was adapted to include the personalised phone attribute:

I then tested the procedure by checking a customer\'s information before
and after calling the

procedure.

**What I learnt:**

I learned how stored procedures can accept multiple parameters and
modify database records.

**Ai Usage:** 6

**Task Context:**

The assessment required MongoDB customer documents containing embedded
orders and items.

**Tool Used:**

ChatGPT

**Example prompt:**

\"Explain how to represent customers with embedded orders and items in
MongoDB

based on my retail database scenario.\"

How the output was modified:

I used the suggested document structure as a starting point and adapted
the customer and product information to my own dataset.

**What I learnt:**

I learned the difference between relational and document-oriented data
modelling. In PostgreSQL, related information is stored across tables
and connected using foreign keys. In MongoDB, related information can be
embedded within a customer document.

**Ai Usage:** 7

**Task Context:**

The assessment required two aggregation analyses:

1.Total quantity ordered per product.

2.Average price per category.

**Tool Used:**

ChatGPT

Example prompt:

\"Explain step by step how to calculate total quantity ordered per
product using MongoDB

aggregation with embedded orders and items.\"

**How the output was modified:**

The aggregation pipelines were adapted to the actual field names in my
MongoDB documents.

For total quantity per product, the pipeline uses with \$sum :

**What I learnt:**

I learned how MongoDB aggregation pipelines process documents in stages.
In particular, I learned why \$unwind is necessary when working with
arrays of embedded orders and items, and how\$group, \$sum , and \$avg
can be used to produce analytical results.
