/*creating sequence starting from number 1

create sequence my_seq
start with
	1;

/*creating customer table*/
	create table customer (
		cust_id number,
		username varchar2(50) not null,
		passwd varchar2(50) not null,
		first_name varchar2(50) not null,
		last_name varchar2(50) not null,
		credit_type varchar2(9) not null,
		phone number, /*optional field*/
		constraint customer_cust_id_pk primary key (cust_id), /*primary key constraint*/
		constraint customer_credit_type_ck check (credit_type in ('high', 'average', 'low')), /*constraint to check credit type*/
		constraint customer_username_uq unique (username) /*constraint to enforce uniqueness in usernames*/
	);
    
/*creating customer orders table*/
create table cust_order (
		ord_id number default my_seq.nextval, /*using the above created sequence to populate this field during data insert operations*/
		cust_id number not null,
		order_date date default sysdate not null, /*order date field populated from system date during data insert operations*/
		constraint cust_order_order_id_pk primary key (ord_id), /*primary key constraint*/
		constraint cust_order_cust_id_fk foreign key (cust_id) references customer (cust_id) /*foreign key constraint*/
	);
    
/*creating prod_group table*/
create table prod_group (
		group_id number,
		group_name varchar2(50) not null,
		constraint prod_group_group_id_pk primary key (group_id) /*primary key constraint*/
	);
    
/*creating products table*/
create table product (
		prod_id number,
		group_id number not null,
		prod_name varchar2(50) not null,
		price number(8, 2) not null, 
		constraint product_prod_id_pk primary key (prod_id), /*primary key constraint*/
		constraint product_group_id_fk foreign key (group_id) references prod_group (group_id) /*foreign key constraint*/
	);
    
/*creating cart table*/
create table cart (
		row_id number default my_seq.nextval, /*using the above created sequence to populate this field during data insert operations*/
		ord_id number not null,
		prod_id number not null,
		quantity number not null,
		constraint cart_row_id_pk primary key (row_id), /*primary key constraint*/
		constraint cart_ord_id_fk foreign key (ord_id) references cust_order (ord_id), /*foreign key constraint*/
		constraint cart_prod_id_fk foreign key (prod_id) references product (prod_id) /*foreign key constraint*/
	);
    
/*creating product pictures table*/
create table prod_pict (
		pict_id number,
		prod_id number not null,
		file_type number not null,
		width number(7, 2) not null,
		height number(7, 2) not null,
		path varchar2(50) not null,
		constraint prod_pict_pict_id_pk primary key (pict_id), /*primary key constraint*/
		constraint prod_pict_prod_id_fk foreign key (prod_id) references product (prod_id), /*foreign key constraint*/
		constraint prod_pict_file_type_ck check (file_type in ('gif', 'jpg')) /*constraint to check file type*/
	);
    
/* Insert three rows in the customer table.*/
insert into
	customer (
		cust_id,
		username,
		passwd,
		first_name,
		last_name,
		credit_type,
		phone
	)
values(
		001,
		'harry_potter',
		'wsdefr',
		'harry',
		'potter',
		'high',
		0722334455
	);
    
insert into
	customer (
		cust_id,
		username,
		passwd,
		first_name,
		last_name,
		credit_type,
		phone
	)
values(
		002,
		'ron_weasley',
		'dewsfr',
		'ron',
		'weasley',
		'low',
		0733445566
	);
    
insert into
	customer (
		cust_id,
		username,
		passwd,
		first_name,
		last_name,
		credit_type,
		phone
	)
values(
		003,
		'hermione_granger',
		'wsfrde',
		'hermione',
		'granger',
		'average',
		0744556677
	);


/*Insert two rows in the prod_group table*/
insert into
	prod_group (
		group_id, 
        group_name
	)
values(
		01, 
        'prod_group1'
	);
    
insert into
	prod_group (
		group_id, 
        group_name
	)
values(
		02, 
        'prod_group2'
	);

/*Insert two rows in the product table*/
insert into
	product (
		prod_id, 
        group_id, 
        prod_name, 
        price
	)
values(
		9001, 
        01, 
        'nimbus_2000', 
        2000.00
	);

insert into
	product (
		prod_id, 
        group_id, 
        prod_name, 
        price
	)
values(
		9002, 
        02, 
        'nimbus_300', 
        300.00
	);


/*Perform a sale by creating one row in the cust_order table and two rows in the cart table*/
/*Remember to use the sequence to generate primary key in the tables*/
insert into
	cust_order (cust_id)
values(01);

insert into
/*row_id column being populated from the above created sequence hence not used in this query*/
	cart (ord_id, prod_id, quantity) 
	/*selecting the order id from the customer orders table to be inserted to the cart table as they have to be the same value*/
values(
		(
			select
				ord_id
			from
				cust_order
			where
				ord_id =(
					select
						max(ord_id)
					from
						cust_order
				)
		),
		9001,
		1
	);

insert into
/*row_id column being populated from the above created sequence hence not used in this query*/
	cart (ord_id, prod_id, quantity)
    /*selecting the order id from the customer orders table to be inserted to the cart table as they have to be the same value*/
values(
		(
			select
				ord_id
			from
				cust_order
			where
				ord_id =(
					select
						max(ord_id)
					from
						cust_order
				)
		),
		9002,
		1
	);


/*price being updated to 12% increased value over the all rows of the product table*/
update 
	product
set
	price = price * 1.12; 


/*updating the telephone number of a cutomer*/
update 
	customer
set
	phone = 0788991122
where
	username = 'ron_weasley';


/*Delete all rows from the cust_order table, by using DML*/
/*since we have foreign key constraints in place, we first have to delete data from the cart table where ord_id is used as a foreign key, 
before we delete data from the cust_orders table*/
delete from 
	cart;

/*once the data from cart table are deleted we can delete data from cust_order as there are no integrity constraint violations*/
delete from 
	cust_order;