**Explanation of key outputs**

**Data Expansion**

The database originally was small. I expanded the dataset by adding 7
more customers, 60 more payment records and 20 more rental records.

I verified the number of records using "COUNT (\*)" queries.

The output represents the total number of rows stored in each table so
it is correct.

**Schema Personalisation**

To personalise the schema provided I added a phone attribute to the
customers table, because I thought that phone numbers are an important
piece of information regarding customer information.

ALTER TABLE customers

ADD COLUMN phone VARCHAR(20);

I also updated the 3 existing customers with newly inserted phone
numbers for consistency.

**Parameter Personalization**

The spending threshold is required to be 100 + last 3 digits of student
ID. My student_id ends in 752 so my personalized threshold is 852.

**Customer Spending Analysis**

The correlated subquery was calculated based on the amount spent by each
customer.

The inner query was correlated because it referred to the customer_id.

SELECT

c.customer_id,

c.first_name,

c.last_name,

(

SELECT SUM(p.amount)

FROM payments p

WHERE p.customer_id = c.customer_id

) AS total_spending

FROM customers c

WHERE (

SELECT SUM(p.amount)

FROM payments p

WHERE p.customer_id = c.customer_id

) \> 852;

SUM(p.amount) adds all payments that belong to each customer.

WHERE compares the total to my personalized threshold of 852.

**Join Based Approach**

I then changed my spending analysis query and added JOIN, GROUP BY and
HAVING.

The JOIN connects the customers to their corresponding payment record.

GROUP BY makes sure that every calculation is done separately.

HAVING is used to filter the results and displays customers who exceed
the threshold

SELECT

c.customer_id,

c.first_name,

c.last_name,

SUM(p.amount) AS total_spending

FROM customers c

JOIN payments p

ON c.customer_id = p.customer_id

GROUP BY

c.customer_id,

c.first_name,

c.last_name

HAVING SUM(p.amount) \> YOUR_THRESHOLD;

**Create Index and compare performance**

I was required to create an index for one of the tasks as I later
compared performance before and after the index was created, I used :

CREATE INDEX index_payments_customer_id

ON payments(customer_id);

I used customer_id because this always involves transactions and is used
to connect the customers with their payment records in both the
correlated subquery and JOIN query.

Explain Analyze is used to compare the execution plans and performance
for before and after creating the index.

EXPLAIN ANALYZE

SELECT

c.customer_id,

c.first_name,

c.last_name,

(

SELECT SUM(p.amount)

FROM payments p

WHERE p.customer_id = c.customer_id

) AS total_spending

FROM customers c

WHERE (

SELECT SUM(p.amount)

FROM payments p

WHERE p.customer_id = c.customer_id

) \> 852;

After performing the index scan I observe a minor improvement in the
execution time. This tells me that the dataset is not big enough to see
a dramatic improvement using the sequential scan. The query planner may
decide that scanning sequentially is cheaper than index scanning.

**Procedural Programming**

**Creating a function**

The function I created accepts customer_id and runs the query :

SELECT COUNT(\*)

FROM rentals

WHERE customer_id = 1;

The result is then stored in rental_count

CREATE OR REPLACE FUNCTION get_total_rentals(p_customer_id INT)

RETURNS INT

LANGUAGE plpgsql

AS \$\$

DECLARE

rental_count INT;

BEGIN

SELECT COUNT(\*)

INTO rental_count

FROM rentals

WHERE customer_id = p_customer_id;

RETURN rental_count;

END;

\$\$;

Once the function is created it is ran by using:

SELECT get_total_rentals("customer_id");

**Stored Procedure**

This stored procedure can be used to update a customers information

CREATE OR REPLACE PROCEDURE update_customer_information(

p_customer_id INT,

p_first_name VARCHAR(50),

p_last_name VARCHAR(50),

p_email VARCHAR(100),

p_phone VARCHAR(20)

)

LANGUAGE plpgsql

AS \$\$

BEGIN

UPDATE customers

SET

first_name = p_first_name,

last_name = p_last_name,

email = p_email,

phone = p_phone

WHERE customer_id = p_customer_id;

END;

\$\$;

Once the stored procedure is created it is ran by using:

CALL update_customer_info(

customer_id,

\'first_name\',

\'last_name\',

\'email\',

\'number\'

);

Test cases:-

**Case 1**

SELECT get_total_rentals(7);

Get_total_rentals = 2

**Case 2**

CALL update_customer_information(

6,

\'Terry\',

\'Cruise\',

\'Terry.Cruise@example.com\',

\'0873234547\'

);

SELECT \*

FROM customers

WHERE customer_id = 6;

6 \"Terry\" \"Cruise" \"Terry.Cruise@example.com\" \"0873234547\"
\"C12345682\"

**Part B**

**Data creation and updates:-**

I created 2 customer_id and inserted both with 2 orders containing 2
items.

db.customers.updateOne(

{ customer_id: 1 },

{ \$push: { orders: { order_id: 3, order_date: ISODate(\"2023-04-10\"),

items: \[ { product: \"Airpods\", category: \"Electronics\", quantity:
1, price: 150 } \] } } } );

I used the \$push to add new items to the customer. In my case, I added
"Airpods" to the customer.

I used \$set to change any attribute of the customer, in my case i
change the last name to "Jackson".

db.customers.updateOne(

{ customer_id: 1 },

{ \$set: { last_name: \"Jackson\" } } );

**Aggregation and Analysis**

I used this query to find the total quantity per product

db. customers. aggregate(\[

{ Şunwind: \"Şorders\" },

{ Şunwind: \"Şorders. items\" },

§group: {

\_id: \"Sorders. items. product\",

total_quantity: {

Şsum: \"Şorders. items. quantity\"}}}

Şsort: {

total_quantity: -1}}\]) ;

Output:-

‹ {

\_id: \'Tesla\', total_quantity: 1}{

\_id: \'Airpods\', total_quantity: 1}{

\_id: \'Iphone-15\', total quantity: 1}{

\_id: \'Ferari\', total_quantity: 1}{

\_id: \'Ipad-11\', total_quantity: 1}

I used this query to find the average price per category:-

db. customers. aggregate (\[

{ Sunwind: \"Sorders\" },

¿ Sunwind: \"Sorders. items\" },

\$group: {

\_ id: \"Sorders.items.category\",

average \_price: {

Şavg: \"Sorders.items.price\"}},

Şsort: {

average \_price: -1}\]);

Output:-

{\_id: \'Cars\',average_price: 27500}

{\_id: \"Electronics\',

average_price: 583.3333333333334}

**OPTIMIZATION**

**Dataset and Schema**

An improvement would be to introduce better data validation constraints.

Like for the email attribute it can have a validation rule so the
customer contact information meets the format that is required

**Customer Spending Analysis**

The queries can be improved by calculating the customers total once and
then filter the result. Rather than repeating calculations

**Function**

The function can be improved by providing additional information.
Information like a customer's most recent rental date

**Stored Procedure**

The stored procedure can be improved by adding validation. For example
checking whether the customer_id exists before trying to update

**MongoDB Creating and Updating**

It can be improved here by following a more structured document for
example every order must contain :

order_id, order_date, items, product, quantity, price, category

**MongoDB Aggregation**

The Aggregation pipeline could be improved by adding additional
information. For example the product quantity aggregation can include
the total number of customers who bought each product.

**Challenges Encounter**

**Managing the Dataset**

One of the main challenges was making sure that the dataset satisfied
all of the requirements and it was expanded. I needed to make sure that
some customers have passed my personalized threshold.

**Correlated Subqueries**

I found correlated subquery difficult to understand because the inner
query depends on a value from the outer query.

The c.customer_id belongs to the outer query, while p.customer_id
belongs to the inner query. the inner query is linked to the current row
being processed by the outer query.

**MongoDB Data**

The MongoDB section was a challenge because the data was structured as
nested documents. The customer document contained an array of orders,
and each order contained an array of items. To perform analysis on
items, I needed to use \$group. \$unwind.This helped me understand how
MongoDB aggregation pipelines work.

**Handling Data Issue**

I introduced a realistic data-quality issue by setting the email address
of one customer to NULL .

UPDATE customers SET email = NULL

WHERE customer_id = 4;

To identify the affected customer, I then used:

SELECT \* FROM customers

WHERE email IS NULL;

The query handles the issue correctly because SQL uses IS NULL rather
than = NULL when testing for missing values. The spending analysis
itself does not depend on the customer\'s email address. So the customer
with a missing email can still participate in payment and spending
calculations.
