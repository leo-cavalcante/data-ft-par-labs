select * from acidity;

select * from body;

select * from appelations;

select * from countries;

select * from critics;

select * from grapes;

select * from meat_info;

select * from merchants;

select * from prices;

select * from vintages;
select count(*) from vintages;
select count(distinct id) from vintages;

select * from wine;
select count(*) from wine;
select count(distinct wine_id) from wine;

# The foods that go with each wine
select wine_id, group_concat(distinct name) from meat_wine mw
inner join meat_info mi
on mw.food_id=mi.id
group by wine_id;

# Top 10 wines that match everything
select wine_id, group_concat(distinct name) as Foods, count(distinct name) as Number_of_Foods from meat_wine mw
inner join meat_info mi
on mw.food_id=mi.id
group by wine_id
order by 3 desc
limit 10;

# we can see that the top 1 has values coming from 2 different vintages
select * from wine where (wine_id=47154);

select type, count(wine_id) from wine
group by type;
# 3392 x 208

select type, count(distinct wine_id) from wine
group by type;
# 690 x 104

# How many datapoints do we have per country ?
select country, count(distinct wine_id) from wine
group by country
order by 2 desc;

# The previously explains why we are going to focus only on the wines from France

# Understanding why there's a missing value in Countries:
select * from wine where country is null;
select * from countries;

# AVG Price of wine in the supermarket per country
select wine.country, round(avg(price),2) as AVGprice, round(max(price),2) as MaxPrice, round(mIN(price),2) as MINPrice from prices
inner join vintages on prices.vintage_id=vintages.id
inner join wine on vintages.wine_id=wine.wine_id
group by wine.country
order by 2 desc;

# Number of wines per region (both sample and population)
	## Population
select regions.name_en, sum(number_of_wines) as Number_of_Wines from winery
inner join regions on winery.region=regions.region_id
group by regions.name_en
order by 2 desc;

	## Sample
select regions.name_en, count(distinct wine_id) as Number_of_Wines from wine
inner join regions on wine.region_id=regions.region_id
group by regions.name_en
order by 2 desc;

# Select the share of winery per region (percentage of wineries in each region)
select region, count(id) as Wines_Region, (select count(distinct id) from winery) as Total_Wines, round(count(id)/(select count(distinct id) from winery)*100,2) as Share
from winery
group by region
order by 3 desc;


#
with 
    t1 as (
        select region, sum(number_of_wines) as population
        from winery 
        group by region
        order by 2 desc),
    t2 as (
        SELECT rg.region_id, rg.name_en, count(distinct w.wine_id) as sample 
        from wine w
        inner join regions rg on w.region_id=rg.region_id
        group by rg.name_en
        order by 2 DESC)
    select name_en, sample, population, 
    sample/sum(sample) over()*100, 
    population/sum(population) over()*100, 
    (sample/sum(sample) over()*100)/(population/sum(population) over()*100)
    from t1
    inner join t2 on t1.region=t2.region_id;