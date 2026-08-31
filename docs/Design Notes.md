## Design Notes

## 

**Schema Modifications**

The sample database provided consisted of 3 main tables:
customers,payments and rentals. They provide a suitable structure for
what they represent.

To personalise the schema provided I added a phone attribute to the
customers table, because I thought that phone numbers are an important
piece of information regarding customer information

ALTER TABLE customers

ADD COLUMN phone VARCHAR(20);

**Data Quality variation**

For this part I set one customer's email address to null, ie:-

UPDATE customers

SET email = NULL

WHERE customer_id = 4;

This shows a situation where a customer\'s email address has not been
provided.

The data issue can be found using:

SELECT \* FROM customers

WHERE email IS NULL;

**Data Scaling**

7 Additional customer records were inserted to the database totalling to
10. This means that more payments and rental records can be associated
with different customers.

60 additional payment records were inserted totalling to 65, these
records contain:

A valid Customer id,

Payment amount,

Payment date.

This means that a customer\'s gross payment transactions can be
calculated.

The total is found using:-

SELECT COUNT(\*)

FROM payments;

20 additional rental records were inserted totalling to 24, these
records contain:

A valid Customer id

Rental date

Return date

The total is found using:-

SELECT COUNT(\*)

FROM rentals;

**Parameter Personalisation**

The spending threshold is required to be 100 + last 3 digits of student
ID. My student_id ends in 752 so my personalized threshold is 852.

**Creating an index**

I was required to create an index for one of the tasks as I later
compared performance before and after the index was created, I used :

CREATE INDEX index_payments_customer_id

ON payments(customer_id);

I used customer_id because this always involves transactions and is used
to connect the customers with their payment records in both the
correlated subquery and JOIN query.

Explain Analyze is used to compare the execution plans and performance
for before and after creating the index.

**Creating Function and Procedure**

The function I created accepts customer_id and the result is stored in
rental_count. This displays the total number of rentals for a given
customer

This stored procedure I created can be used to modify all attributes for
a given customer provided the customer exists

**Data Creation and Updates**

For MongoDB I decided to create documents for 2 customers and embed them
with 2 orders each. Each order contains a product and belongs to a
category.

I proceeded to use the \$push to add new items to the customer. In my
case, I added "Airpods" to customer_id 1.

I used \$set to change any attribute of the customer, in my case I
changed the last name to "Jackson" for customer_id 1.

**Aggregation and Analysis**

The aggregation pipelines were used and adopted to the actual field
names. The calculations for each was relatively straightforward.
