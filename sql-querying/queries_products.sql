-- Comments in SQL Start with dash-dash --
You are now connected to database "products_db" as user "justinprice".
products_db-# \l
                                                    List of databases
    Name     |    Owner    | Encoding |   Collate   |    Ctype    | ICU Locale | Locale Provider |   Access privileges   
-------------+-------------+----------+-------------+-------------+------------+-----------------+-----------------------
 justinprice | justinprice | UTF8     | en_US.UTF-8 | en_US.UTF-8 | en-US      | icu             | 
 postgres    | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | en-US      | icu             | 
 products_db | justinprice | UTF8     | en_US.UTF-8 | en_US.UTF-8 | en-US      | icu             | 
 template0   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | en-US      | icu             | =c/postgres          +
             |             |          |             |             |            |
                 | postgres=CTc/postgres
 template1   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | en-US      | icu             | =c/postgres          +
             |             |          |             |             |            |                 | postgres=CTc/postgres
(5 rows)

products_db-# \d
                 List of relations
 Schema |      Name       |   Type   |    Owner    
--------+-----------------+----------+-------------
 public | products        | table    | justinprice
 public | products_id_seq | sequence | justinprice
(2 rows)

products_db-# \d products
                                     Table "public.products"
     Column      |       Type       | Collation | Nullable |               Default                
-----------------+------------------+-----------+----------+--------------------------------------
 id              | integer          |           | not null | nextval('products_id_seq'::regclass)
 name            | text             |           | not null | 
 price           | double precision |           |          | 
 can_be_returned | boolean          |           | not null | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "products_price_check" CHECK (price > 0::double precision)

...skipping...
     Column      |       Type       | Collation | Nullable |               Default                
-----------------+------------------+-----------+----------+--------------------------------------
 id              | integer          |           | not null | nextval('products_id_seq'::regclass)
 name            | text             |           | not null | 
 price           | double precision |           |          | 
 can_be_returned | boolean          |           | not null | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "products_price_check" CHECK (price > 0::double precision)

products_db-# insert into products (name, price)
products_db-# values ('chair', 44.00);
ERROR:  syntax error at or near "c"
LINE 1: c/ products_db
        ^
products_db=# insert into products (name, price, can_be_returned)
products_db-# values ('chair', 44.00, 'false');
INSERT 0 1
products_db=# \d products
                                     Table "public.products"
     Column      |       Type       | Collation | Nullable |               Default                
-----------------+------------------+-----------+----------+--------------------------------------
 id              | integer          |           | not null | nextval('products_id_seq'::regclass)
 name            | text             |           | not null | 
 price           | double precision |           |          | 
 can_be_returned | boolean          |           | not null | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "products_price_check" CHECK (price > 0::double precision)

products_db=# select * from products
products_db-# select name from products
products_db-# insert into products (name, price, can_be_returned)               values ('stool', 25.99, 'true');
ERROR:  syntax error at or near "select"
LINE 2: select name from products
        ^
products_db=# select * from products                                            select name from products                                                       insert into products (name, price, can_be_returned)                             values ('stool', 25.99, 'true');
ERROR:  syntax error at or near "select"
LINE 2: select name from products
        ^
products_db=# select * from products;
 id | name  | price | can_be_returned 
----+-------+-------+-----------------
  1 | chair |    44 | f
(1 row)

products_db=# insert into products (name, price, can_be_returned)               values ('stool', 25.99, 'true');                                                
INSERT 0 1
products_db=# insert into products (name, price, can_be_returned)               values ('table', 124.00, 'false');
INSERT 0 1
products_db=# select * from products
products_db-# ;
 id | name  | price | can_be_returned 
----+-------+-------+-----------------
  1 | chair |    44 | f
  2 | stool | 25.99 | t
  3 | table |   124 | f
(3 rows)

products_db=# select name from products;
 name  
-------
 chair
 stool
 table
(3 rows)

products_db=# select name, price from products;
 name  | price 
-------+-------
 chair |    44
 stool | 25.99
 table |   124
(3 rows)

products_db=# insert into products (name, price, can_be_returned)
products_db-# values ('couch', 100000, 'true');
INSERT 0 1
products_db=# select name, price from products where can_be_returned
products_db-# ;
 name  | price  
-------+--------
 stool |  25.99
 couch | 100000
(2 rows)

products_db=# select name, price from products where price < 44.00              ;
 name  | price 
-------+-------
 stool | 25.99
(1 row)

products_db=# select name, price from products where price > 44.00 && price < 99
.99                                                                             ;
ERROR:  syntax error at or near "<"
LINE 1: ...me, price from products where price > 44.00 && price < 99.99
                                                                ^
products_db=# select name, price from products where price > 44.00 and  price < 99.99                                                                           ;
 name | price 
------+-------
(0 rows)

products_db=# select name, price from products where price >= 44.00 && price < 99.99                                                                            ;
ERROR:  syntax error at or near "<"
LINE 1: ...e, price from products where price >= 44.00 && price < 99.99
                                                                ^
products_db=# select name, price from products where price >= 44.00 && price <= 99.99                                                                           ;
ERROR:  syntax error at or near "<="
LINE 1: ..., price from products where price >= 44.00 && price <= 99.99
                                                               ^
products_db=# select name, price from products where price between 44.00 and 99.99
products_db-# ;
 name  | price 
-------+-------
 chair |    44
(1 row)

products_db=# update products set price = price - 20
products_db-# ;
UPDATE 4
products_db=# select * from products;
 id | name  |       price       | can_be_returned 
----+-------+-------------------+-----------------
  1 | chair |                24 | f
  2 | stool | 5.989999999999998 | t
  3 | table |               104 | f
  4 | couch |             99980 | t
(4 rows)

products_db=# delete from products where price < 25.00
products_db-# ;
DELETE 2
products_db=# select * from products
products_db-# ;
 id | name  | price | can_be_returned 
----+-------+-------+-----------------
  3 | table |   104 | f
  4 | couch | 99980 | t
(2 rows)

products_db=# update products set price = price + 20;
UPDATE 2
products_db=# update products set ca_be_returned = 'true'
products_db-# ;
ERROR:  column "ca_be_returned" of relation "products" does not exist
LINE 1: update products set ca_be_returned = 'true'
                            ^
products_db=# update products set can_be_returned = 'true'                      ;
UPDATE 2