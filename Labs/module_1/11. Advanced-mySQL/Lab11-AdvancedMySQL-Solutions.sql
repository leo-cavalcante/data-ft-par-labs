# Challenge 1 - Most Profiting Authors
## Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication

select titleauthor.au_id as Author_ID,
		titleauthor.title_id as Title_ID,
		titles.advance * titleauthor.royaltyper/100 as Advance,
		titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100  as Royalty
from titleauthor
inner join titles
on titleauthor.title_id  = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

## Step 2: Aggregate the total royalties for each title and author

select Author_ID, Title_ID, Advance, sum(Royalty) as Sum_Royalty
from (select titleauthor.au_id as Author_ID,
		titleauthor.title_id as Title_ID,
		titles.advance * titleauthor.royaltyper/100 as Advance,
		titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100  as Royalty
from titleauthor
inner join titles
on titleauthor.title_id  = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id) summary1
group by Author_ID, Title_ID, Advance;

## Step 3: Calculate the total profits of each author

select Author_ID, Advance+Sum_Royalty as Profit
from
(select Author_ID, Title_ID, Advance, sum(Royalty) as Sum_Royalty
from (select titleauthor.au_id as Author_ID,
		titleauthor.title_id as Title_ID,
		titles.advance * titleauthor.royaltyper/100 as Advance,
		titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100  as Royalty
from titleauthor
inner join titles
on titleauthor.title_id  = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id) summary1
group by Author_ID, Title_ID, Advance) as summary2
order by Profit desc
limit 3;


# Challenge 2 - Alternative Solution
## Step 1:
create temporary table if not exists summary1
select titleauthor.au_id as Author_ID,
		titleauthor.title_id as Title_ID,
		titles.advance * titleauthor.royaltyper/100 as Advance,
		titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100  as Royalty
from titleauthor
inner join titles
on titleauthor.title_id  = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

select * from summary1;

## Step 2:
create temporary table if not exists summary2
select Author_ID, Title_ID, Advance, sum(Royalty) as Sum_Royalty
from summary1
group by Author_ID, Title_ID, Advance;

select * from summary2;

## Step 3:
select Author_ID, Advance+Sum_Royalty as Profit
from summary2
order by Profit desc
limit 3;


# Challenge 3 - Alternative Solution 
create table most_profiting_authors
select Author_ID, Advance+Sum_Royalty as Profit
from summary2
order by Profit desc
limit 3;

select * from most_profiting_authors;