#Who Have Published What At Where?

select a.au_id, a.au_fname, a.au_lname, t.title, p.pub_name
from titles t
inner join titleauthor ta on t.title_id=ta.title_id
inner join authors a on ta.au_id=a.au_id
inner join publishers p on p.pub_id=t.pub_id;

# Who Have Published How Many At Where?
select a.au_id, a.au_fname, a.au_lname, p.pub_name, count(t.title)
from titles t
inner join titleauthor ta on t.title_id=ta.title_id
inner join authors a on ta.au_id=a.au_id
inner join publishers p on p.pub_id=t.pub_id
group by a.au_id, p.pub_name;

#Who are the top 3 authors who have sold the highest number of titles? 
select a.au_id, a.au_fname, a.au_lname, sum(qty) as total
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on t.title_id=ta.title_id
inner join sales s on s.title_id=ta.title_id
group by a.au_id
order by 4 desc
limit 3;

select a.au_id, a.au_fname, a.au_lname, coalesce(sum(qty),0) as total
from authors a
left join titleauthor ta on ta.au_id=a.au_id
left join titles t on t.title_id=ta.title_id
left join sales s on s.title_id=ta.title_id
group by a.au_id
order by 4 desc;

select *
from sales s 
inner join titleauthor ta on s.title_id=ta.title_id
right join authors a on ta.au_id=a.au_id;



Select st.stor_name AS Store, 
       Count(Distinct(ord_num)) AS Orders, 
       Count(title_id) AS Items, 
       Sum(qty) AS Qty
From sales s
Inner Join stores st ON st.stor_id=s.stor_id
Group by Store;

Select st.stor_name AS Store, 
       Count(title_id)/Count(Distinct(ord_num)) AS titles_per_order, 
       Sum(qty)/Count(title_id) AS Qty_per_title
From sales s
Inner Join stores st ON st.stor_id=s.stor_id
Group by Store;

select store, items/orders, qty/items
from (
	Select st.stor_name AS Store, 
		   Count(Distinct(ord_num)) AS Orders, 
		   Count(title_id) AS Items, 
		   Sum(qty) AS Qty
	From sales s
	Inner Join stores st ON st.stor_id=s.stor_id
	Group by Store) as summary;


select store, ord_num, ord_date, title, s.qty, price, t.type
from (
	Select st.stor_id,
		   st.stor_name AS Store, 
		   Count(Distinct(ord_num)) AS Orders, 
		   Count(title_id) AS Items, 
		   Sum(qty) AS Qty
	From sales s
	Inner Join stores st ON st.stor_id=s.stor_id
	Group by Store) as summary
inner join sales s on s.stor_id=summary.stor_id
inner join titles t on t.title_id=s.title_id
where items/orders>1;

with summary as 
(
	Select st.stor_id,
		   st.stor_name AS Store, 
		   Count(Distinct(ord_num)) AS Orders, 
		   Count(title_id) AS Items, 
		   Sum(qty) AS Qty
	From sales s
	Inner Join stores st ON st.stor_id=s.stor_id
	Group by Store)
select store, ord_num, ord_date, title, s.qty, price, t.type
from summary
inner join sales s on s.stor_id=summary.stor_id
inner join titles t on t.title_id=s.title_id
where items/orders>1;


select * from summary;

create temporary table summary
Select st.stor_id,
		   st.stor_name AS Store, 
		   Count(Distinct(ord_num)) AS Orders, 
		   Count(title_id) AS Items, 
		   Sum(qty) AS Qty
	From sales s
	Inner Join stores st ON st.stor_id=s.stor_id
	Group by Store;
    
select * from summary;


select store, ord_num, ord_date, title, s.qty, price, t.type
from summary
inner join sales s on s.stor_id=summary.stor_id
inner join titles t on t.title_id=s.title_id
where items/orders>1;

create table summary1
Select st.stor_id,
		   st.stor_name AS Store, 
		   Count(Distinct(ord_num)) AS Orders, 
		   Count(title_id) AS Items, 
		   Sum(qty) AS Qty
	From sales s
	Inner Join stores st ON st.stor_id=s.stor_id
	Group by Store;
    
select * from summary1;

delete from summary1
where qty<80;

select * from summary;

update summary1
set qty=qty+5
where items=6;

drop table summary1;

select * from summary1;


#Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication
select s.ord_num, a.au_id, a.au_fname, a.au_lname, t.title, t.pub_id, s.qty, t.price, t.advance, t.royalty, ta.royaltyper, t.advance*ta.royaltyper/100 as advance, s.qty*t.price*t.royalty/100*ta.royaltyper/100 as royalty
from sales s
inner join titles t
on s.title_id=t.title_id
inner join titleauthor ta
on t.title_id=ta.title_id
inner join authors a
on ta.au_id=a.au_id
order by 1;


#Step 2: Aggregate the total royalties for each title and author
select au_id, au_fname, au_lname, title, sum(royalty) as total_royalties_per_title, advance
from (
select a.au_id, a.au_fname, a.au_lname, t.title, s.qty*t.price*t.royalty/100*ta.royaltyper/100 as royalty, t.advance*ta.royaltyper/100 as advance
from sales s
inner join titles t
on s.title_id=t.title_id
inner join titleauthor ta
on t.title_id=ta.title_id
inner join authors a
on ta.au_id=a.au_id) t1
group by au_id, title;

#Step 3: Calculate the total profits of each author
select au_id, au_fname, au_lname, sum(total_royalties_per_book+advance) as total_profit from(
select au_id, au_fname, au_lname, title, sum(royalty) as total_royalties_per_book, advance
from (
select a.au_id, a.au_fname, a.au_lname, t.title, s.qty*t.price*t.royalty/100*ta.royaltyper/100 as royalty, t.advance*ta.royaltyper/100 as advance
from sales s
inner join titles t
on s.title_id=t.title_id
inner join titleauthor ta
on t.title_id=ta.title_id
inner join authors a
on ta.au_id=a.au_id) t1
group by au_id, title) t2
group by au_id;
