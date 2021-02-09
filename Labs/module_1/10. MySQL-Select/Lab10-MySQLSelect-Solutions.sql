# Challenge 1 - Who Have Published What At Where?

select authors.au_id as AUTHOR_ID, au_lname as LAST_NAME, au_fname as FIRST_NAME, title as TITLE, publishers.pub_id as PUBLISHER
from publishers

inner join titles
on publishers.pub_id = titles.pub_id

inner join titleauthor
on titles.title_id = titleauthor.title_id

inner join authors
on titleauthor.au_id = authors.au_id;

# Challenge 2 - Who Have Published How Many At Where?

select titleauthor.au_id as AUTHOR_ID, au_lname as LAST_NAME, au_fname as FIRST_NAME, publishers.pub_id as PUBLISHER, count(title)
from titleauthor

inner join titles
on titles.title_id = titleauthor.title_id

inner join publishers
on publishers.pub_id = titles.pub_id

inner join authors
on titleauthor.au_id = authors.au_id
group by titleauthor.au_id, PUBLISHER;


# Challenge 3 - Best Selling Authors

select authors.au_id as AUTHOR_ID, authors.au_lname as LAST_NAME, authors.au_fname as FIRST_NAME, sum(qty) as TOTAL
from sales
inner join titleauthor
on sales.title_id = titleauthor.title_id
inner join authors
on titleauthor.au_id = authors.au_id
group by authors.au_id
order by TOTAL desc
limit 3;

# Challenge 4 - Best Selling Authors Ranking
select authors.au_id as AUTHOR_ID, authors.au_lname as LAST_NAME, authors.au_fname as FIRST_NAME, coalesce(sum(qty),0) as TOTAL
from sales
inner join titleauthor on sales.title_id = titleauthor.title_id
right join authors on titleauthor.au_id = authors.au_id
group by authors.au_id
order by TOTAL desc 