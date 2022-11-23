/* creating the table customer and fill it with data */
CREATE TABLE customer(
username VARCHAR2(8) PRIMARY KEY, passwd VARCHAR2(8) NOT NULL, first_name VARCHAR2(20) NOT NULL, last_name VARCHAR2(20) NOT NULL, profession VARCHAR2(20),
reg_date DATE NOT NULL,
salary NUMBER(7));
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('MrBig','MBisKING','Roger','nyberg','Officer',TO_DATE('1998-NOV-29','YYYY-MON- DD'),317000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('MEZcal','P33kssa','maria','Nyberg','psychologist',TO_DATE('1999-08-29','YYYY-MM- DD'),435000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('FISSIped','bintje','Tomas','kvist','Potatoe farmer',TO_DATE('2000-02-28','YYYY- MM-DD'),198000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('OlleBull','Bullas','hans','Lindqvist',NULL,TO_DATE('2002-05-05','YYYY-MM- DD'),116000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('MrMDI','MDIisit','Hans','Rosenboll','assistant professor',TO_DATE('1997-01- 15','YYYY-MM-DD'),307000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('King25','asdf1234','charlotte','Ortiz','dentist',TO_DATE('2003-12-10','YYYY-MM- DD'),586000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('h01hanro','T56xxL','Sven','Larsson',NULL,TO_DATE('2003-08-09','YYYY-MM- DD'),NULL);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('XXXL','IRule','Margareta','ek','MD',TO_DATE('2001-06-29','YYYY-MM-DD'),942000); 
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('Rolven','revolver','roger','nyberg',NULL,TO_DATE('1998-10-29','YYYY-MM- DD'),240000);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('IceMan','Quantos','Maria','Nyberg','Engineer',TO_DATE('1998-02-14','YYYY-MM- DD'),412000);
COMMIT;

------------------------------------------------------------------------------------------
/* Show all data about all customers, sort by last_name (a-ö) */

select
	* 
from
	customer 
order by
	last_name collate binary_ci asc;

------------------------------------------------------------------------------------------
/* Show all data about all customers, sort by last_name (ö-a) */

select
   * 
from
   customer 
order by
   last_name collate binary_ci desc;

------------------------------------------------------------------------------------------
/* Show the numbers of customers that are stored in the customer table (i.e. the number of rows) */

select
   count(*) 
from
   customer; 	
   
------------------------------------------------------------------------------------------
/* Show how many customers that have an annual (yearly) income that is greater than
300 000 SEK. */

   select
      count(*) 
   from
      customer 
   where
      salary > 300000;

------------------------------------------------------------------------------------------
/* Show how many customers that have an annual (yearly) income that is less than
300 000 SEK. */

select
   count(*) 
from
   customer 
where
   salary < 300000;

------------------------------------------------------------------------------------------
/* Show average annual income for all customers. The column headline should be: average_salary */

select
   avg( NVL( salary, 0 )) as average_salary 
from
   customer;

------------------------------------------------------------------------------------------
/* Show username, first_name, last_name and salary for those customers that have a salary that is less than the average annual income for all customers */

select
   username,
   first_name,
   last_name,
   salary
from
   customer 
where
   nvl(salary, 0) < (
   select
      avg( NVL( salary, 0 ))
   from
      customer);

------------------------------------------------------------------------------------------
/* Show first_name, last_name with UPPER-CASE LETTERS for those customers who have the letter 's' in the last name */

select
   upper(first_name) as first_name,
   upper(last_name) as last_name 
from
   customer 
where
   last_name like '%s%';

------------------------------------------------------------------------------------------
/* Show first_name, last_name and profession with lower-case letters for those customers who have a first name which ends with the letter 's'. 
Replace null-values in the column profession with the string 'jobless' */
select
   lower(first_name) as first_name,
   lower(last_name) as last_name,
   lower(nvl(profession, 'jobless')) as profession 
from
   customer 
where
   first_name like '%s';

------------------------------------------------------------------------------------------
/* Show profession and the number of customers in that profession category. Sort by profession (z-a).
The column headings should be profession and quantity. Replace null-values in the column profession with the string 'jobless'. 
Show profession capitalized. */

select
   initcap(nvl(profession, 'jobless')) as profession,
   count(*) as quantity 
from
   customer 
group by
   profession 
order by
   profession collate binary_ci desc;

------------------------------------------------------------------------------------------
/* Show first_name concatenated with a space and last_name under the heading customer_name. Show both names capitalized.  */

select
   initcap(first_name || ' ' || last_name) as customer_name 
from
   customer;

------------------------------------------------------------------------------------------
/* Show the number of customers who has the username = 'King25' and passwd = 'asdf1234' with the heading logged_in */

select
   count(*) as "logged_in" 
from
   customer 
where
   username = 'King25' 
   and passwd = 'asdf1234';

------------------------------------------------------------------------------------------
/* Show the number of customers who has the username = 'KING25' and passwd = 'ASDF1234' with the heading logged_in */

select
   count(*) as "logged_in" 
from
   customer 
where
   username = 'KING25' 
   and passwd = 'ASDF1234';

------------------------------------------------------------------------------------------
/* Show username, passwd and reg_date for those customers who registered before year 2000 */

select
   username,
   passwd,
   to_char(reg_date, 'yyyy-mm-dd') as reg_date 
from
   customer 
where
   reg_date < to_date ('2000-01-01', 'yyyy-mm-dd');

------------------------------------------------------------------------------------------
/* Show username, passwd and reg_date for those customers who registered between 01 january 2001 and 01 october 2003 */
select
   username,
   passwd,
   to_char(reg_date, 'YYYY-MM-DD') as reg_date 
from
   customer 
where
   reg_date between to_date ('2001-01-01', 'yyyy-mm-dd') and to_date ('2003-10-03', 'yyyy-mm-dd');

------------------------------------------------------------------------------------------
/* Add the following rows in the table customer */

INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('MrBig2','MBisKING','Roger','kvist','Researcher',TO_DATE('2016-NOV-29','YYYY-MON- DD'),NULL);
INSERT INTO customer(username,passwd,first_name,last_name,profession,reg_date,salary) 
	VALUES('MEZcal33','P33kssa','roger','eriksson','carpenter',TO_DATE('2013-08-29','YYYY- MM-DD'),NULL);
Commit;

------------------------------------------------------------------------------------------
/* Show username, passwd, first_name, last_name for those customers who has a last name equalto'nyberg'or'kvist'and firstnamenotequalto'roger' */

select
   username,
   passwd,
   first_name,
   last_name 
from
   customer 
where
   (
      last_name = 'nyberg' collate binary_ci 
      or last_name = 'kvist' collate binary_ci
   )
   and first_name <> 'roger' collate binary_ci;

-------------------------------------------------------------------------------------------
/* Show first_name, last_name and salary for the customer with the highest salary of all customers */

select
   first_name,
   last_name,
   salary 
from
   customer 
where
   salary = 
   (
      select
         max(salary) 
      from
         customer
   )
;

-------------------------------------------------------------------------------------------
/* Show first_name, last_name and salary for the customer with the lowest salary of all customers. 
Do not include customers with NULL salary */

select
   first_name,
   last_name,
   salary 
from
   customer 
where
   salary = 
   (
      select
         min(salary) 
      from
         customer
   )
;

------------------------------------------------------------------------------------------
/* Show first_name and last_name for those customers who has a NULL value in the profession column */

select
   first_name,
   last_name 
from
   customer 
where
   profession is null;