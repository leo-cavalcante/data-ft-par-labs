use publications;

select * from jobs;

select * from discounts;

select * from authors;

select price from titles;

select min(price), max(price), count(price), type
from titles
group by type;

select * from authors
where au_fname like '%ar%';

select * from authors
where zip like '9%'; 

select * from authors
where address regexp '(\d+ [A-Za-z]+.)';  

select * from authors
where address regexp (\d+ [A-Za-z]); 