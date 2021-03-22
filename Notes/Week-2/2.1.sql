use publications;

select * from jobs;

select * from new.orders;

select * from authors;

SELECT 
    *
FROM
    AUTHORS
;

select price
from titles;

select *
from titles
where price is not null;

select distinct type from titles;

select title, type, price from titles;

select * 
from titles
order by price;

select * 
from titles
order by price, title desc;

select *
from authors
limit 5;

select *
from titles;

select count(*)
from titles;

select type, count(*)
from titles
group by type;

select type, count(*) as number_of_titles_per_type
from titles
group by type;

select min(price), max(price) 
from titles;

select min(price), max(price), count(price), avg(price), sum(price), type
from titles
group by type;

#top 10 jobs with highest value of min_lvl
select * from jobs;

select *
from jobs
order by min_lvl desc 
limit 10;

select *
from authors
where state='CA';

select *
from authors
where state='CA' and contract!=1;

#select freelancers from CA and everyone from KS
select *
from authors
where state='KS' or (state='CA' and contract=0);

#either from IN or from KS
select *
from authors
where state='IN' or state='KS';

select *
from authors
where state in ('IN','KS');

select *
from authors
where state not in ('IN','KS');

select *
from authors
where state in ('IN','KS','Paris');

select *
from authors
where au_fname like '%star';

select *
from authors
where au_fname like '%star%';

select *
from authors
where au_fname like '%ar%';

select *
from authors
where zip like '9%';

select * from publishers;
#count how many titles each publisher has published

select * from titles;

select pub_name, count(title_id) as titles
from titles t right join publishers p
on t.pub_id=p.pub_id
group by pub_name;

select *
from titles t right join publishers p
on t.pub_id=p.pub_id;

select * from employee e
left join jobs j on e.job_id=j.job_id
union 
select * from employee e
right join jobs j on e.job_id=j.job_id;


select *
from employee e, jobs j
where e.job_id=j.job_id;

select * from jobs j
left join employee e on j.job_id=e.job_id