#1. Count the number of clients per gender
select client_id, birth_number, district_id, sign(MID(birth_number, 2, 2)-49) as Gender from client;

select if(sign(MID(birth_number, 3, 2)-49)=-1, "Men", "Women")  as Gender, count(client_id) as NumberofPeople from client
group by Gender;
	## -1 = Male and 1= Female

SELECT IF(MOD(birth_number,10000) >=4000, 'women', 'men') AS genre, COUNT(client_id) AS genre_repartition
FROM client
GROUP BY genre;

#2. Are there any accounts that have more than 2 linked clients?
select account_id, count(account_id) as number from disp
group by account_id
having number > 1;
	## No account have more than 2 linked clients 

#3. What is the average transaction amount for each region?
select A3 as Region, sum(amount) as Transactions_Amount, count(amount) as Transactions_Number, sum(amount)/count(amount) as AvgTrans from trans
inner join account
on trans.account_id = account.account_id
inner join district
on account.district_id = district.A1
group by Region
order by AvgTrans desc;

#4. Based on the entire transaction volume (total amount), what's the percentage that was sent to another bank?
select sum(if(operation = "PREVOD NA UCET", amount, 0))/sum(amount)*100 as Percentage from trans;

#5. From which region do most of the clients that are account owners come from, that either have finished loan contracts that haven't been paid, or have running contracts but are in debt? Show the top 10 regions including the number of client that are owners.
select A3 as Region, count(client.client_id) as Number_Clients from disp
inner join client
on disp.client_id=client.client_id
inner join district
on client.district_id=district.A1
inner join loan
on disp.account_id = loan.account_id
where type = "OWNER" and (status = "B" or status = "C")
group by Region
order by Number_Clients desc;

#Challenge 1 - What is the most successful district? 
select district_id, count(account_id) from account
group by district_id
order by count(account_id)  desc;

#Challenge 2 - How many people changed their place of residence? 
select account_id, k_symbol, count(amount) from order_table
where k_symbol = "SIPO"
group by account_id
having count(amount)>1;

#Challenge 3 - Best Selling Districts
select loan.account_id, district_id, A2 as District_Name, amount from loan
inner join account
on loan.account_id = account.account_id
inner join district
on account.district_id = district.A1
order by amount desc;

#Challenge 4 - Best Selling Districts UPDATED
select district_id, A2 as District_Name, sum(amount) from loan
inner join account
on loan.account_id = account.account_id
inner join district
on account.district_id = district.A1
group by district_id, District_Name
order by sum(amount) desc;

#Challenge 5 - Best Selling Districts UPDATED
 select district_id, A2 as District_Name, sum(amount)/count(amount) as average,  from loan
inner join account
on loan.account_id = account.account_id
inner join district
on account.district_id = district.A1
group by district_id, District_Name
order by sum(amount) desc; 
	##The average was calculated here

SET @rowindex := -1;
 
SELECT
   AVG(loans.amount)
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex, amount FROM loan
    ORDER BY amount) AS loans
WHERE
loans.rowindex IN (FLOOR(@rowindex / 2) , CEIL(@rowindex / 2));


SELECT @rowindex:=@rowindex + 1 AS rowindex, district_id, loan.amount AS loan_amount FROM loan
inner join account
on loan.account_id = account.account_id
inner join district
on account.district_id = district.A1
group by district_id
ORDER BY loan.amount  desc

	## I didn't accomplished the calculation of the median, unfortunately.