/*
 * RDBMS-Fast-Food-Franchise
 *   
 * This file includes all script for creation tables and views of the schema
 * for the FastFood franchise
 *  
 * Create a new schema (user) before running the script
 * You can do this by running the following 3 scripts
 * 
 * create user g_assessm identified by password123;
 * grant connect, resource, create session, unlimited tablespace to g_assessm;
 * grant create view to g_assessm;
 *     
 * #1 CREATE TABLES
 *
 * #1.1
 * Create Locations Table
 */
CREATE TABLE LOCATIONS (Loc_ID NUMBER(5,0) CONSTRAINT loc_id_pk PRIMARY KEY,
						Street1 varchar2(50) NOT NULL,
						Street2 varchar2(30),
						Town varchar2(30),
						City varchar2(30) NOT NULL,
						PostCode varchar2(10) NOT NULL);
/
--Create Sequence for auto numeration					
CREATE SEQUENCE loc_seq START WITH 1;
/
--Create Trigger for auto nummeration
CREATE OR REPLACE TRIGGER loc_bir
	BEFORE INSERT ON Locations
	FOR EACH ROW
BEGIN
	IF :NEW.loc_id IS NULL THEN 
		SELECT	loc_seq.nextval 
		INTO 	:NEW.loc_id
		FROM	dual;
	END IF ;
END;
/
--insert location's values
INSERT INTO LOCATIONS VALUES (NULL, '2A Edinburgh Street', NULL, 'Midlothian', 'Edinburgh', 'EH1 2DJ');
INSERT INTO LOCATIONS VALUES (NULL, '50 Royal Mile', NULL, 'Midlothian', 'Edinburgh', 'EH3 3XU');
INSERT INTO LOCATIONS VALUES (NULL, '14 Lewisham Way', NULL, 'Livingston', 'Edinburgh', 'EH54 5UX');
INSERT INTO LOCATIONS VALUES (NULL, '3 George Square', NULL, NULL, 'Glasgow', 'G1 1AB');
INSERT INTO LOCATIONS VALUES (NULL, '1 Princes Street', NULL, 'Rutherglen', 'Glasgow', 'G71 1LJ');
/
/*
 * #1.2
 * Create Outlets Table
 */
CREATE TABLE OUTLETS (Outlet_ID varchar(10) CONSTRAINT outlet_id_pk PRIMARY KEY,
					  Outlet_Name varchar2(40) NOT NULL,
					  Loc_ID NUMBER(5,0) NOT NULL CONSTRAINT outlet_loc_fk REFERENCES LOCATIONS(Loc_ID));
/	
--insert outlet's values
INSERT INTO OUTLETS VALUES ('Edi-01', 'Edinburgh, 2A Edinburgh Street', 1);
INSERT INTO OUTLETS VALUES ('Edi-02', 'Edinburgh, 50 Royal Mile', 2);
INSERT INTO OUTLETS VALUES ('Liv-01', 'Livingston, 14 Lewisham Way', 3);
INSERT INTO OUTLETS VALUES ('Gla-01', 'Glasgow, 3 George Square', 4);
INSERT INTO OUTLETS VALUES ('Gla-02', 'Rutherglen, 1 Princes Street', 5);
/					 
/*
 * #1.3
 * Create Jobs Table
 */
CREATE TABLE JOBS (Job_ID varchar2(10) CONSTRAINT jobs_id_pk PRIMARY KEY,
				   Job_Title varchar2(20) NOT NULL CONSTRAINT jobs_title_uk UNIQUE);
/	
--insert job's values
INSERT INTO JOBS VALUES ('manager', 'managers of outlets');
INSERT INTO JOBS VALUES ('others', 'main staff');
INSERT INTO JOBS VALUES ('cook', q'[kitchen's staff]');
/				  
/*
 * #1.4
 * Create Employees Table 
 */
CREATE TABLE EMPLOYEES (Employee_ID NUMBER(6,0) CONSTRAINT emp_id_pk PRIMARY KEY,
						Employee_Name varchar2(20) NOT NULL,
						Employee_Surname varchar2(20) NOT NULL,
						Job_ID varchar2(10) NOT NULL CONSTRAINT emp_job_fk REFERENCES JOBS (Job_ID),
						Outlet_ID varchar2(10) NOT NULL CONSTRAINT emp_outlet_fk REFERENCES OUTLETS (Outlet_ID),
						Employee_NI varchar2(9) NOT NULL CONSTRAINT emp_NI_uk UNIQUE,
						Employee_Phone varchar2(20) NOT NULL,
						Employee_Address varchar2(70) NOT NULL);
/
--Create Sequence for auto numeration
CREATE SEQUENCE emp_seq START WITH 1;
/
--Create Trigger for auto nummeration
CREATE OR REPLACE TRIGGER emp_bir
	BEFORE INSERT ON Employees
	FOR EACH ROW
BEGIN
	IF :NEW.employee_id IS NULL THEN 
		SELECT	emp_seq.nextval 
		INTO 	:NEW.employee_id
		FROM	dual;
	END IF ;
END;
/
--insert employees' values
--Edi-01 outlet
INSERT INTO EMPLOYEES VALUES (NULL, 'Steven', 'King', 'manager', 'Edi-01', 'SY123456A', 
							  '07789 123 456', '1/1, 10 Main Road, Edinburgh, EH1 2DJ');
INSERT INTO EMPLOYEES VALUES (NULL, 'Neena', 'Kachhar', 'manager', 'Edi-01', 'SY223456B', 
							  '07789 223 457', '25 Main Road, Edinburgh, EH1 3DJ');
INSERT INTO EMPLOYEES VALUES (NULL, 'Alexandr', 'Hunold', 'others', 'Edi-01', 'SY323457C', 
							  '07789 323 458', '0/1, 10 London Street, Edinburgh, EH1 4DG');
INSERT INTO EMPLOYEES VALUES (NULL, 'Bruce', 'Ernst', 'others', 'Edi-01', 'SY423458D', 
							  '07789 423 459', '4/4, 22 London Street, Edinburgh, EH2 4DH');
INSERT INTO EMPLOYEES VALUES (NULL, 'David', 'Austin', 'cook', 'Edi-01', 'SY523459E', 
							  '07789 023 455', '2A Lybster Crescent, Edinburgh, EH3 5DK');
INSERT INTO EMPLOYEES VALUES (NULL, 'Diana', 'Lorentz', 'cook', 'Edi-01', 'SY623450F', 
							  '07789 923 454', '44 Edmonton Terrace, Edinburgh, EH4 6DL');
--Edi-02 outlet
INSERT INTO EMPLOYEES VALUES (NULL, 'Nancy', 'Greenberg', 'manager', 'Edi-02', 'DB123456A', 
							  '07780 123 456', '1/1, 2 Main Road, Edinburgh, EH1 2DJ');
INSERT INTO EMPLOYEES VALUES (NULL, 'Daniel', 'Faviet', 'manager', 'Edi-02', 'DB223456B', 
							  '07780 223 457', '15 Main Road, Edinburgh, EH1 3DJ');
INSERT INTO EMPLOYEES VALUES (NULL, 'John', 'Chen', 'others', 'Edi-02', 'DB323457C', 
							  '07780 323 458', '0/1, 3 London Street, Edinburgh, EH1 4DG');
INSERT INTO EMPLOYEES VALUES (NULL, 'Ismael', 'Sciarra', 'others', 'Edi-02', 'DB423458D', 
							  '07780 423 459', '4/4, 11 London Street, Edinburgh, EH2 4DH');
INSERT INTO EMPLOYEES VALUES (NULL, 'Luis', 'Popp', 'cook', 'Edi-02', 'DB523459E', 
							  '07780 023 455', '3A Lybster Crescent, Edinburgh, EH3 5DK');
INSERT INTO EMPLOYEES VALUES (NULL, 'Den', 'Raphaely', 'cook', 'Edi-02', 'DB623450F', 
							  '07780 923 454', '10 Edmonton Terrace, Edinburgh, EH4 6DL');							 
--Liv-01 outlet
INSERT INTO EMPLOYEES VALUES (NULL, 'Alexander', 'Khoo', 'manager', 'Liv-01', 'AB123456A', 
							  '07788 123 456', '1/1, 5 Main Road, Livingston, EH54 6UA');
INSERT INTO EMPLOYEES VALUES (NULL, 'Shelli', 'Baida', 'manager', 'Liv-01', 'AB223456B', 
							  '07788 223 457', '35 Main Road, Livingston, EH54 7UB');
INSERT INTO EMPLOYEES VALUES (NULL, 'Sigal', 'Tobias', 'others', 'Liv-01', 'AB323457C', 
							  '07788 323 458', '0/1, 10 London Street, Livingston, EH54 8UF');
INSERT INTO EMPLOYEES VALUES (NULL, 'Guy', 'Himuro', 'others', 'Liv-01', 'AB423458D', 
							  '07788 423 459', '4/4, 25 London Street, Livingston, EH54 9UD');
INSERT INTO EMPLOYEES VALUES (NULL, 'Matthew', 'Weiss', 'cook', 'Liv-01', 'AB523459E', 
							  '07788 023 455', '10 Lybster Crescent, Livingston, EH54 1UC');
INSERT INTO EMPLOYEES VALUES (NULL, 'Adam', 'Fripp', 'cook', 'Liv-01', 'AB623450F', 
							  '07788 923 454', '5 Edmonton Terrace, Livingston, EH54 2UE');								 
--Gla-01 outlet							 
INSERT INTO EMPLOYEES VALUES (NULL, 'Payam', 'Kaufling', 'manager', 'Gla-01', 'CF123456A', 
							  '07787 123 456', '1/1, 41 Main Road, Glasgow, G1 1AB');
INSERT INTO EMPLOYEES VALUES (NULL, 'Shanta', 'Vollman', 'manager', 'Gla-01', 'CF223456B', 
							  '07787 223 457', '34 Main Road, Glasgow, G2 2AC');
INSERT INTO EMPLOYEES VALUES (NULL, 'Kevin', 'Mourgos', 'others', 'Gla-01', 'CF323457C', 
							  '07787 323 458', '1/4, 40 London Street, Glasgow, G3 3BB');
INSERT INTO EMPLOYEES VALUES (NULL, 'Julia', 'Nayer', 'others', 'Gla-01', 'CF423458D', 
							  '07787 423 459', '3/2, 33 London Street, Glasgow, G4 4CB');
INSERT INTO EMPLOYEES VALUES (NULL, 'James', 'Landry', 'cook', 'Gla-01', 'CF523459E', 
							  '07787 023 455', '20 Lybster Crescent, Glasgow, G5 5DX');
INSERT INTO EMPLOYEES VALUES (NULL, 'Steven', 'Markle', 'cook', 'Gla-01', 'CF623450F', 
							  '07787 923 454', '41 Edmonton Terrace, Glasgow, G6 6XS');							 
--Gla-02 outlet						 
INSERT INTO EMPLOYEES VALUES (NULL, 'Laura', 'Bisot', 'manager', 'Gla-02', 'XN123456A', 
							  '07786 123 456', '4/1, 50 Main Road, Glasgow, G71 2LF');
INSERT INTO EMPLOYEES VALUES (NULL, 'Mozhe', 'Atkinson', 'manager', 'Gla-02', 'XN223456B', 
							  '07786 223 457', '47 Main Road, Glasgow, G72 3LE');
INSERT INTO EMPLOYEES VALUES (NULL, 'James', 'Marlow', 'others', 'Gla-02', 'XN323457C', 
							  '07786 323 458', '4/1, 52 London Street, Glasgow, G73 4LD');
INSERT INTO EMPLOYEES VALUES (NULL, 'TJ', 'Olson', 'others', 'Gla-02', 'XN423458D', 
							  '07786 423 459', '0/3, 45 London Street, Glasgow, G74 5LC');
INSERT INTO EMPLOYEES VALUES (NULL, 'Jason', 'Malin', 'cook', 'Gla-02', 'XN523459E', 
							  '07786 023 455', '75 Lybster Crescent, Glasgow, G75 6LB');
INSERT INTO EMPLOYEES VALUES (NULL, 'Michael', 'Rogers', 'cook', 'Gla-02', 'XN623450F', 
							  '07786 923 454', '53 Edmonton Terrace, Glasgow, G76 7LA');	
/							 
/*
 * #1.5
 * Create Payments Table
 */

CREATE TABLE PAYMENTS (Payment_ID varchar2(10) CONSTRAINT pay_pay_pk PRIMARY KEY,
					   Payment_Name varchar2(20) NOT NULL CONSTRAINT pay_name_uk UNIQUE);
/	
--insert payment's values
INSERT INTO PAYMENTS VALUES ('cash', 'cash payment');
INSERT INTO PAYMENTS VALUES ('card', 'bank payment');
/
/*
 * #1.6
 * Create Customers Table
 */					
CREATE TABLE CUSTOMERS (Customer_ID NUMBER(8,0) CONSTRAINT cus_id_pk PRIMARY KEY,
						Customer_Name varchar2(20),
						Customer_Surname varchar(20),
						Customer_Phone varchar2(20),
						Customer_Address varchar2(70));
/
--Create Sequence for auto numeration
CREATE SEQUENCE cus_seq START WITH 1;
/
--Create Trigger for auto nummeration
CREATE OR REPLACE TRIGGER cus_bir
	BEFORE INSERT ON Customers
	FOR EACH ROW
BEGIN
	IF :NEW.customer_id IS NULL THEN 
		SELECT	cus_seq.nextval 
		INTO 	:NEW.customer_id
		FROM	dual;
	END IF ;
END;
/
--insert customers' values
INSERT INTO CUSTOMERS VALUES (NULL, 'Theresa', 	'May', 		'07391 123 451', 'Sokho');
INSERT INTO CUSTOMERS VALUES (NULL, 'Boris', 	'Johnson', 	'07392 223 452', '10 Dauning Street');
INSERT INTO CUSTOMERS VALUES (NULL, 'Angela', 	'Merkel', 	'07393 223 453', 'Brandenburgh Gates, Berlin');
INSERT INTO CUSTOMERS VALUES (NULL, 'Jeremi', 	'Korbin', 	'07394 323 454', 'Bristol');
INSERT INTO CUSTOMERS VALUES (NULL, 'Donald', 	'Trump', 	'07395 423 455', 'Washington, D.C.');
INSERT INTO CUSTOMERS VALUES (NULL, 'Barak', 	'Obama', 	'07396 523 456', 'Miami');
INSERT INTO CUSTOMERS VALUES (NULL, 'Bill', 	'Klinton', 	'07397 623 457', 'Houston');
INSERT INTO CUSTOMERS VALUES (NULL, 'Prince', 	'Harry', 	'07398 723 458', 'Buckhingem Palace');
INSERT INTO CUSTOMERS VALUES (NULL, 'Prince', 	'Whilliam', '07399 823 459', 'Toronto');
INSERT INTO CUSTOMERS VALUES (NULL, 'Megan', 	'Markle', 	'07390 923 460', 'Toronto');
INSERT INTO CUSTOMERS VALUES (NULL, 'Prince', 	'Charlse', 	'07382 013 461', 'Buckhingem Palace');
INSERT INTO CUSTOMERS VALUES (NULL, 'Emanuel', 	'Makron', 	'07383 023 462', 'Elises Field, Paris');
INSERT INTO CUSTOMERS VALUES (NULL, 'Guseppe', 	'Conte', 	'07384 033 463', 'Royal Palace, Rome');
INSERT INTO CUSTOMERS VALUES (NULL, 'Tony', 	'Blare', 	'07385 043 464', 'York');
/
/*
 * #1.7
 * Create MenuTypes Table
 */					
					
CREATE TABLE MENUTYPES (Menu_Type_ID varchar2(10) CONSTRAINT menutype_id_pk PRIMARY KEY,
						Menu_Type_Name varchar2(30) NOT NULL);
/	
--insert menustypes' values
INSERT INTO MENUTYPES VALUES ('regular', 'regular menu');
INSERT INTO MENUTYPES VALUES ('savers', 'savers menu');
/
/*
 * #1.8
 * Create Menus Tables
 */
CREATE TABLE MENUS (Menu_ID varchar2(30) CONSTRAINT menu_id_pk PRIMARY KEY, 
					Menu_Name varchar2(50) NOT NULL, 
					Menu_Type_ID varchar2(10) NOT NULL CONSTRAINT menu_typeID_fk REFERENCES MenuTypes (Menu_Type_ID), 
					Start_Date DATE, 
					End_Date DATE, 
					START_Time varchar2(5), 
					END_Time varchar(5), 
					Price NUMBER(6, 2) NOT NULL CHECK (Price > 0));
/
--insert menus' values
INSERT INTO MENUS VALUES ('regular breakfast', 'breakfast section of the regular menu', 'regular', 
						   null, null, '07:00', '10:59', 7.99);
INSERT INTO MENUS VALUES ('regular afternoon', 'the afternoon regular menu', 'regular', 
						   null, null, '11:00', '23:00', 9.99);
INSERT INTO MENUS VALUES ('savers in September', 'the savers menu in September (14-18/09)', 'savers', 
						   to_date('14-Sep-2020 07:00:00', 'dd-Mon-yyyy hh24:mi:ss'),  
						   to_date('18-Sep-2020 23:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 
						   NULL, NULL, 6.99);
INSERT INTO MENUS VALUES ('savers in October', 'the savers menu in October (12-31/10)', 'savers', 
						   to_date('12-Oct-2020 07:00:00', 'dd-Mon-yyyy hh24:mi:ss'),  
						   to_date('31-Oct-2020 23:00:00', 'dd-Mon-yyyy hh24:mi:ss'), 
						   NULL, NULL, 7.49);						  
INSERT INTO MENUS VALUES ('festive savers in December', 'the festive savers menu in December (21-31/12)', 'savers', 
						   to_date('21-Dec-2020 07:00:00', 'dd-Mon-yyyy hh24:mi:ss'),  
						   to_date('31-Dec-2020 23:59:59', 'dd-Mon-yyyy hh24:mi:ss'), 
						   NULL, NULL, 12.99);
/
/*
 * #1.9
 */		
CREATE TABLE ITEMS (Item_ID NUMBER(6,0) CONSTRAINT item_id_pk PRIMARY KEY,
					Item_Name varchar2(40) NOT NULL CONSTRAINT item_name_uk UNIQUE,
					Product_Unit varchar2(10) NOT NULL,
					Drinks NUMBER(1),
					Restock_Value NUMBER(15,3));
/
--Create Sequence for auto numeration
CREATE SEQUENCE item_seq START WITH 1;
/
--Create Trigger for auto nummeration
CREATE OR REPLACE TRIGGER item_bir
	BEFORE INSERT ON Items
	FOR EACH ROW
BEGIN
	IF :NEW.item_id IS NULL THEN 
		SELECT	item_seq.nextval 
		INTO 	:NEW.item_id
		FROM	dual;
	END IF ;
END;
/
--insert items' values
INSERT INTO ITEMS VALUES (NULL, 'Chips', 'Kg', 0, 200);
INSERT INTO ITEMS VALUES (NULL, 'Bun', 'pairs', 0, 500);
INSERT INTO ITEMS VALUES (NULL, 'Beef', 'pcs', 0, 500);
INSERT INTO ITEMS VALUES (NULL, 'Cheese', 'Kg', 0, 20);
INSERT INTO ITEMS VALUES (NULL, 'Onion', 'Kg', 0, 30);
INSERT INTO ITEMS VALUES (NULL, 'Gherkinns', 'Kg', 0, 20);
INSERT INTO ITEMS VALUES (NULL, 'Relish', 'Kg', 0, 20);
INSERT INTO ITEMS VALUES (NULL, 'Potatoes', 'Kg', 0, 20);
INSERT INTO ITEMS VALUES (NULL, 'Cucumbers', 'Kg', 0, 30);
INSERT INTO ITEMS VALUES (NULL, 'Tomatoes', 'Kg', 0, 30);
INSERT INTO ITEMS VALUES (NULL, 'Bow', 'Kg', 0, 30);
INSERT INTO ITEMS VALUES (NULL, 'Lettuce', 'Kg', 0, 30);
INSERT INTO ITEMS VALUES (NULL, 'Sweet pepper', 'Kg', 0, 20);
INSERT INTO ITEMS VALUES (NULL, 'Ketchup', 'Kg', 0, 20);
INSERT INTO ITEMS VALUES (NULL, 'Mustard', 'Kg', 0, 15);
INSERT INTO ITEMS VALUES (NULL, 'Mayonnaise', 'Kg', 0, 30);

--Drinks
INSERT INTO ITEMS VALUES (NULL, 'Cola', 'l', 1, 50);
INSERT INTO ITEMS VALUES (NULL, 'Cola 330 ml Cans', 'cans', 1, 40);
INSERT INTO ITEMS VALUES (NULL, 'Cola 330 ml Glass Bottle', 'bottle', 1, 30);
INSERT INTO ITEMS VALUES (NULL, 'Pepsi', 'l', 1, 50);
INSERT INTO ITEMS VALUES (NULL, 'Pepsi 330 ml Cans', 'cans', 1, 40);
INSERT INTO ITEMS VALUES (NULL, 'Pepsi 330 ml Glass Bottle', 'bottle', 1, 30);
INSERT INTO ITEMS VALUES (NULL, 'Irn-Bru', 'l', 1, 50);
INSERT INTO ITEMS VALUES (NULL, 'Irn-Bru 330 ml Cans', 'cans', 1, 40);
INSERT INTO ITEMS VALUES (NULL, 'Irn-Bru 330 ml Glass Bottle', 'bottle', 1, 30);
INSERT INTO ITEMS VALUES (NULL, 'Instant coffee Cup Sticks', 'pcs', 1, 300);
INSERT INTO ITEMS VALUES (NULL, 'Tea bags', 'bags', 1, 400);
/
/*
 * #1.10
 * Create MenuSpesification Table
 */
CREATE TABLE MENUSPECIFICATION (Menu_ID varchar2(30) NOT NULL CONSTRAINT menuspec_menuID_fk REFERENCES Menus (Menu_ID), 
								Item_ID NUMBER(6, 0) NOT NULL CONSTRAINT menuspec_itemID_fk REFERENCES Items (Item_ID), 
								Quantity NUMBER(7, 3) NOT NULL CHECK (Quantity > 0), 
								CONSTRAINT menuspec_combi_pk PRIMARY KEY (Menu_ID, Item_ID));
/
--insert Menus' Specifications
--each of the menu includes only one of drinks as well 
--but it will be added to Orders
--#1 Regular Breakfast: Breakfast Section of the Regular Menu
--Clasic Burger, chips and 'Lily' salad
--Clasic Burger
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 2, 1);		--Bun
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 3, 1);		--Beef
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 5, 0.02);	--Onion
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 11, 0.01);	--Bow
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 12, 0.03);	--Lettuce
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 14, 0.01);	--Ketchup
--Chips
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 1, 0.1);	
--'Lily' salad
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 6, 0.02);	--Gherlinns
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 7, 0.02);	--Mashrooms
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 10, 0.02);	--Tomatoes
INSERT INTO MENUSPECIFICATION VALUES ('regular breakfast', 16, 0.01);	--Mayonnaise

--#2 Regular Afternoon: the Afternoon Regular Menu
--Cheeseburger, chips and 'Mimosa' salad
--Cheeseburger
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 2, 1);		--Bun
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 3, 1);		--Beef
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 4, 0.03);	--Cheese
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 6, 0.01);	--Gherkinns
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 12, 0.03);	--Lettuce
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 14, 0.01);	--Ketchup
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 15, 0.01);	--Mustard
--Chips
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 1, 0.1);	
--'Mimosa' salad
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 7, 0.02);	--Mashrooms
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 9, 0.02);	--Cucumbers
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 13, 0.02);	--Sweet pepper
INSERT INTO MENUSPECIFICATION VALUES ('regular afternoon', 16, 0.01);	--Mayonnaise

--#3 Savers in September: the Savers Menu in September, 14 - 18 September
--Sizzling Burger, chips and 'Warm Autumn' salad
--Sizzling Burger
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 2, 1);		--Bun
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 3, 1);		--Beef
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 5, 0.02);	--Onion
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 7, 0.02);	--Mashrooms
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 11, 0.02);	--Bow
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 12, 0.02);	--Lettuce
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 13, 0.02);	--Sweet pepper
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 14, 0.01);	--Ketchup
--Chips
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 1, 0.1);	
--'Warm Autumn' salad
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 4, 0.02);	--Cheese
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 6, 0.02);	--Gherkinns
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 9, 0.02);	--Cucumbers
INSERT INTO MENUSPECIFICATION VALUES ('savers in September', 16, 0.01);	--Mayonnaise

--#4 Savers in October: the Savers Menu in October, 12 - 31 October
--Double Burger, chips and 'Caesar' salad
--Double Burger
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 2, 1);		--Bun
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 3, 2);		--Beef
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 5, 0.03);	--Onion
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 7, 0.03);	--Mashrooms
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 11, 0.03);	--Bow
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 12, 0.03);	--Lettuce
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 13, 0.03);	--Sweet pepper
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 14, 0.02);	--Ketchup
--Chips
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 1, 0.1);	
--'Ceasar' salad
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 4, 0.02);	--Cheese
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 6, 0.02);	--Gherkinns
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 10, 0.02);	--Tomatoes
INSERT INTO MENUSPECIFICATION VALUES ('savers in October', 16, 0.01);	--Mayonnaise

--#5 Festive Savers in December: the Festive Savers Menu in December, 21 - 31 December
--De Luxe Burger, double chips and 'Festive' salad
--De Luxe Burger
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 2, 1);		--Bun
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 3, 2);		--Beef
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 5, 0.03);	--Onion
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 9, 0.03);	--Cucumbers
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 11, 0.03);	--Bow
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 12, 0.03);	--Lettuce
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 13, 0.03);	--Sweet pepper
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 14, 0.02);	--Ketchup
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 15, 0.01);	--Mustard
--Chips
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 1, 0.2);	
--'Festive' salad
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 6, 0.02);	--Gherkinns
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 7, 0.02);	--Mashrooms
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 8, 0.02);	--Potatoes
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 10, 0.02);	--Tomatoes
INSERT INTO MENUSPECIFICATION VALUES ('festive savers in December', 16, 0.02);	--Mayonnaise
/
/*
 * #1.11
 * Create Stock Table
 */					
CREATE TABLE STOCKS (Outlet_ID varchar2(10) NOT NULL CONSTRAINT stock_outlet_fk REFERENCES Outlets (Outlet_ID),
					 Item_ID NUMBER(6,0) NOT NULL CONSTRAINT stock_itemID_fk REFERENCES Items (Item_ID),
					 Document_ID varchar2(12) NOT NULL,
					 Date_ID DATE NOT NULL,
					 Quantity NUMBER(15,3) NOT NULL,					 
					 CONSTRAINT stock_combi_pk PRIMARY KEY (Outlet_ID, Item_ID, Document_ID));	
/	
/*
 * #1.12
 * Create PurchaseInvoice Table
 */					
CREATE TABLE PURCHASEINVOICE (Invoice_ID varchar2(12) CONSTRAINT invoice_id_pk PRIMARY KEY,
							  Invoice_Date DATE DEFAULT (sysdate) NOT NULL,
					 		  Outlet_ID varchar2(10) NOT NULL CONSTRAINT invoice_outlet_fk REFERENCES Outlets (Outlet_ID),
							  Manager_ID NUMBER(6,0) NOT NULL CONSTRAINT invoice_empID_fk REFERENCES Employees (Employee_ID));
/					
--Create Sequence for auto numeration 
CREATE SEQUENCE invoice_seq START WITH 1;
/
--Create Trigger for auto nummeration, some checks
--and add the new row to the Stock table
CREATE OR REPLACE TRIGGER invoice_bir
	BEFORE INSERT ON PURCHASEINVOICE
	FOR EACH ROW
DECLARE 
	v_manager_jobsid employees.JOB_ID%TYPE ;
BEGIN
	--check if the Manager field containts staff of managers
	--if not will stop the trigger running
	--dbms_output.put_line(:NEW.Manager_ID);
	SELECT job_id INTO v_manager_jobsid
	FROM EMPLOYEES e2 
	WHERE EMPLOYEE_ID = :NEW.Manager_ID;
	IF v_manager_jobsid <> 'manager' THEN 
		dbms_output.put_line('Insert staff of managers in the Manager field, please');
		raise_application_error(-20010, 'Insert staff of managers in the Manager field, please');
	END IF ;
	--autonumeration with prefix 'Inv-'
	IF :NEW.invoice_id IS NULL THEN 
		SELECT	'Inv-' || trim(to_char(invoice_seq.nextval, '00000099'))
		INTO 	:NEW.invoice_id
		FROM	dual;
	END IF ;
END;
/
--insert Invoices for the each of outlets
--'Edi-01' outlet
INSERT INTO PURCHASEINVOICE VALUES (NULL, to_date('01-Aug-2020'), 'Edi-01', 1);

--'Edi-02' outlet
INSERT INTO PURCHASEINVOICE VALUES (NULL, to_date('02-Aug-2020'), 'Edi-02', 7);

--'Liv-01' outlet
INSERT INTO PURCHASEINVOICE VALUES (NULL, to_date('03-Aug-2020'), 'Liv-01', 13);

--'Gla-01' outlet
INSERT INTO PURCHASEINVOICE VALUES (NULL, to_date('04-Aug-2020'), 'Gla-01', 19);

--'Gla-02' outlet
INSERT INTO PURCHASEINVOICE VALUES (NULL, to_date('05-Aug-2020'), 'Gla-02', 25);
/
/*
 * #1.13
 * Create InvoiceSpecification Table
 */					
CREATE TABLE INVOICESPESIFICATION (Invoice_ID varchar2(12) NOT NULL CONSTRAINT invspec_invid_fk REFERENCES PURCHASEINVOICE (Invoice_ID),
								   Item_ID NUMBER(6,0) NOT NULL CONSTRAINT invspec_itemID_fk REFERENCES Items (Item_ID),
								   Quantity NUMBER(15,3) DEFAULT 1 NOT NULL CHECK (Quantity > 0),
								   CONSTRAINT invspec_combi_pk PRIMARY KEY (Invoice_ID, Item_ID));
/					
--Create Trigger to add the new row to the Stock table
CREATE OR REPLACE TRIGGER invspec_bir
	BEFORE INSERT ON INVOICESPESIFICATION
	FOR EACH ROW
DECLARE 
	v_invoice_outletid PURCHASEINVOICE.outlet_id%TYPE ;
	v_invoice_invdate PURCHASEINVOICE.Invoice_Date%TYPE ;
BEGIN
	SELECT outlet_id, invoice_date 
	INTO v_invoice_outletid, v_invoice_invdate
	FROM PURCHASEINVOICE p2 
	WHERE invoice_id = :NEW.invoice_id;
	--add the new row to the stock table
	INSERT INTO stocks VALUES (v_invoice_outletid, :NEW.item_id, :NEW.invoice_id, v_invoice_invdate, :NEW.Quantity);
END;					
/			
--insert Items for the each of Invoices
--'Edi-01' outlet Invoice # Inv-00000001
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 1, 15200);	--chips
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 2, 15500);	--bun
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 3, 15500);	--beef
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 4, 1520);	--cheese
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 5, 1530);	--onion
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 6, 1520);	--gherkinns
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 7, 1520);	--mashrooms
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 8, 1520);	--potatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 9, 1530);	--cucumbers
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 10, 1530);	--tomatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 11, 1530);	--bow
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 12, 1530);	--lettuce
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 13, 1520);	--sweet pepper
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 14, 1520);	--ketchup
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 15, 1515);	--mustard
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 16, 1530);	--mayonnaise
--Drinks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 17, 1550);	--Cola
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 18, 1540);	--Cola 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 19, 1530);	--Cola 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 20, 1550);	--Pepsi
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 21, 1540);	--Pepsi 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 22, 1530);	--Pepsi 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 23, 1550);	--Irn-Bru 
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 24, 1540);	--Irn-Bru 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 25, 1530);	--Irn-Bru 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 26, 15300);	--Instant coffee cup sticks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000001', 27, 15400);	--Tea bags

--'Edi-02' outlet Invoice # Inv-00000002
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 1, 1200);	--chips
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 2, 1500);	--bun
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 3, 1500);	--beef
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 4, 120);	--cheese
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 5, 130);	--onion
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 6, 120);	--gherkinns
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 7, 120);	--mashrooms
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 8, 120);	--potatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 9, 130);	--cucumbers
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 10, 130);	--tomatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 11, 130);	--bow
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 12, 130);	--lettuce
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 13, 120);	--sweet pepper
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 14, 120);	--ketchup
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 15, 115);	--mustard
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 16, 130);	--mayonnaise
--Drinks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 17, 150);	--Cola
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 18, 140);	--Cola 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 19, 130);	--Cola 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 20, 150);	--Pepsi
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 21, 140);	--Pepsi 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 22, 130);	--Pepsi 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 23, 150);	--Irn-Bru 
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 24, 140);	--Irn-Bru 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 25, 130);	--Irn-Bru 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 26, 1300);	--Instant coffee cup sticks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000002', 27, 1400);	--Tea bags

--'Liv-01' outlet Invoice # Inv-00000003
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 1, 1300);	--chips
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 2, 1600);	--bun
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 3, 1600);	--beef
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 4, 130);	--cheese
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 5, 140);	--onion
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 6, 130);	--gherkinns
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 7, 130);	--mashrooms
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 8, 130);	--potatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 9, 140);	--cucumbers
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 10, 140);	--tomatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 11, 140);	--bow
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 12, 140);	--lettuce
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 13, 130);	--sweet pepper
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 14, 130);	--ketchup
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 15, 125);	--mustard
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 16, 140);	--mayonnaise
--Drinks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 17, 160);	--Cola
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 18, 150);	--Cola 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 19, 140);	--Cola 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 20, 160);	--Pepsi
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 21, 150);	--Pepsi 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 22, 140);	--Pepsi 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 23, 160);	--Irn-Bru 
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 24, 150);	--Irn-Bru 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 25, 140);	--Irn-Bru 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 26, 1400);	--Instant coffee cup sticks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000003', 27, 1500);	--Tea bags

--'Gla-01' outlet Invoice # Inv-00000004
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 1, 1300);	--chips
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 2, 1600);	--bun
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 3, 1600);	--beef
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 4, 130);	--cheese
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 5, 140);	--onion
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 6, 130);	--gherkinns
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 7, 130);	--mashrooms
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 8, 130);	--potatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 9, 140);	--cucumbers
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 10, 140);	--tomatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 11, 140);	--bow
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 12, 140);	--lettuce
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 13, 130);	--sweet pepper
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 14, 130);	--ketchup
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 15, 125);	--mustard
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 16, 140);	--mayonnaise
--Drinks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 17, 160);	--Cola
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 18, 150);	--Cola 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 19, 140);	--Cola 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 20, 160);	--Pepsi
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 21, 150);	--Pepsi 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 22, 140);	--Pepsi 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 23, 160);	--Irn-Bru 
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 24, 150);	--Irn-Bru 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 25, 140);	--Irn-Bru 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 26, 1400);	--Instant coffee cup sticks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000004', 27, 1500);	--Tea bags

--'Gla-02' outlet Invoice # Inv-00000005
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 1, 1300);	--chips
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 2, 1600);	--bun
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 3, 1600);	--beef
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 4, 130);	--cheese
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 5, 140);	--onion
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 6, 130);	--gherkinns
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 7, 130);	--mashrooms
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 8, 130);	--potatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 9, 140);	--cucumbers
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 10, 140);	--tomatoes
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 11, 140);	--bow
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 12, 140);	--lettuce
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 13, 130);	--sweet pepper
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 14, 130);	--ketchup
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 15, 125);	--mustard
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 16, 140);	--mayonnaise
--Drinks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 17, 160);	--Cola
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 18, 150);	--Cola 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 19, 140);	--Cola 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 20, 160);	--Pepsi
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 21, 150);	--Pepsi 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 22, 140);	--Pepsi 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 23, 160);	--Irn-Bru 
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 24, 150);	--Irn-Bru 330 ml cans
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 25, 140);	--Irn-Bru 330 ml glass bottle
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 26, 1400);	--Instant coffee cup sticks
INSERT INTO INVOICESPESIFICATION VALUES ('Inv-00000005', 27, 1500);	--Tea bags
/
/*
 * #1.14
 * Create Order Table
 */					
CREATE TABLE ORDERS (Order_ID varchar2(12) CONSTRAINT order_id_pk PRIMARY KEY,
					 Order_Date DATE DEFAULT (sysdate) NOT NULL,
					 Outlet_ID varchar2(10) NOT NULL CONSTRAINT order_outlet_fk REFERENCES Outlets (Outlet_ID),
					 Menu_ID varchar2(20) NOT NULL CONSTRAINT order_menuID_fk REFERENCES Menus (Menu_ID),
					 Drink_ID NUMBER(6,0) CONSTRAINT order_drinkID_fk REFERENCES Items (Item_ID),
					 Customer_ID NUMBER(8,0) NOT NULL CONSTRAINT order_custID_fk REFERENCES Customers (Customer_ID),
					 Employee_ID NUMBER(6,0) NOT NULL CONSTRAINT order_empID_fk REFERENCES Employees (Employee_ID),
					 Cook NUMBER(6,0) NOT NULL CONSTRAINT order_cook_fk REFERENCES Employees (Employee_ID),
					 Payment_ID varchar2(10) NOT NULL CONSTRAINT order_pay_fk REFERENCES Payments (Payment_ID),
					 Quantity NUMBER(3,0) DEFAULT 1 NOT NULL CHECK (Quantity > 0),
					 Amount NUMBER(15,3) NOT NULL CHECK (Amount > 0));
/					
--Create Sequence for auto numeration
CREATE SEQUENCE order_seq START WITH 1;
/
--Create Trigger for auto nummeration, some checks
--and creation of a new customer if needed
CREATE OR REPLACE TRIGGER order_bir
	BEFORE INSERT OR UPDATE ON Orders
	FOR EACH ROW
DECLARE 
	--define explisit cursor for stock quantity checking
	CURSOR order_items IS 
		SELECT item_id, quantity 
		FROM MENUSPECIFICATION m 
		WHERE MENU_ID = :NEW.menu_id;
	--define variables to check the quantity of items in the stock
	v_item_id items.item_id%TYPE;
	v_item_name items.item_name%TYPE;
	v_stock_quantity stocks.quantity%TYPE;
	v_restock_value items.restock_value%TYPE;
	--define variables to check the quantity of the drink in the stock
	v_drink_name items.item_name%TYPE;
	v_drink_unit items.product_unit%TYPE;
	v_drink_quantity number(8,3) := 1;
	v_drink_stock_quantity stocks.quantity%TYPE := 0;
	v_restock_drink_value items.restock_value%TYPE;
	--define other variables
	v_cook_jobid employees.job_id%TYPE ;
	v_items_drinks items.drinks%TYPE ;
	v_menu_price menus.price%TYPE ;
	o_cust_id Customers.Customer_ID%TYPE;
	v_start_date menus.start_date%TYPE ;
	v_end_date menus.end_date%TYPE ;
	v_start_time menus.start_time%TYPE;
	v_end_time menus.end_time%TYPE;
	v_order_time varchar2(20);
	v_order_date varchar2(20);
BEGIN
	--Check #1. check if the Cook field containts staff of cooks
	--if not will stop the trigger running
	SELECT job_id INTO v_cook_jobid
	FROM EMPLOYEES e 
	WHERE EMPLOYEE_ID = :NEW.cook;
	IF v_cook_jobid <> 'cook' THEN 
		dbms_output.put_line('Insert staff of cooks in the Cook field, please');
		raise_application_error(-20010, 'Insert staff of cooks in the Cook field, please');
	END IF ;
	--End check #1
	--------------------------------------	
	--------------------------------------
	--Checl #2. If the Drink field is choosen 
	--check if the Item has Drink attribut '1'
	IF :NEW.Drink_ID IS NOT NULL THEN
		SELECT drinks 
		INTO v_items_drinks 
		FROM ITEMS i2 
		WHERE ITEM_ID = :NEW.Drink_ID;
		IF v_items_drinks <> 1 THEN 
			dbms_output.put_line('Insert drink item into the Drink field, please');
			raise_application_error(-20010, 'Insert drink item into the Drink field, please');
		END IF ;
	END IF ;
	--End check #2
	--------------------------------------	
	--------------------------------------
	--Check #3. If the selected menu is valid at this time and date
	IF :NEW.menu_id IS NOT NULL THEN 
		SELECT START_DATE, END_DATE, START_TIME, END_TIME 
		INTO v_start_date, v_end_date, v_start_time, v_end_time
		FROM menus WHERE MENU_ID = :NEW.menu_id;
		v_order_date := to_char(:NEW.order_date, 'dd-Mon-yyyy'); --the date beginning
		--menu is restricted by time - regular breakfast and regular afternoon
		IF v_start_time IS NOT NULL AND v_end_time IS NOT NULL THEN 
			v_order_time := to_char(:NEW.order_date, 'hh24:mi');
			IF to_date(v_order_date || v_order_time, 'dd-Mon-yyyy hh24:mi') < 
					to_date(v_order_date || v_start_time, 'dd-Mon-yyyy hh24:mi')
				or 
					to_date(v_order_date || v_order_time, 'dd-Mon-yyyy hh24:mi') > 
						to_date(v_order_date || v_end_time, 'dd-Mon-yyyy hh24:mi') THEN 						
				dbms_output.put_line('Inserted menu is not valid due to time');
				raise_application_error(-20010, 'Inserted menu is not valid due to time
									     Insert the relevant menu, please');						
			END IF;
		END IF;
		--menu is restricted by date - severs in October as example
		IF v_start_date IS NOT NULL AND v_end_date IS NOT NULL THEN 
			IF to_date(v_order_date, 'dd-Mon-yyyy') < to_date(to_char(v_start_date, 'dd-Mon-yyyy'))
				or 
					to_date(v_order_date, 'dd-Mon-yyyy') > to_date(to_char(v_end_date, 'dd-Mon-yyyy')) THEN 						
				dbms_output.put_line('Inserted menu is not valid due to date');
				raise_application_error(-20010, 'Inserted menu is not valid due to date
									  Insert the relevant menu, please');						
			END IF;
		END IF;
	END IF ;	
	--End check #3
	--------------------------------------	
	--------------------------------------
	--Check #4. Delete already ordered quantity of items in the stock
	DELETE FROM STOCKS WHERE OUTLET_ID = :NEW.outlet_id AND DOCUMENT_ID = :NEW.order_id;
	--End check #4
	--------------------------------------	
	--------------------------------------
	--Check #5. If there is enough items in the ctock 
	--and there will be no write-off of items in the negative uantity
	FOR v_pres_item IN order_items
	LOOP
		v_stock_quantity := 0;
		v_item_id := v_pres_item.item_id;
		--determening the item quantity in the stock
		SELECT sum(QUANTITY) INTO v_stock_quantity FROM STOCKS s2 
		WHERE ITEM_ID = v_item_id AND OUTLET_ID = :NEW.outlet_id;
		IF (v_stock_quantity - (:NEW.quantity * v_pres_item.quantity)) < 0 THEN 	
			SELECT item_name INTO v_item_name FROM ITEMS 
			WHERE ITEM_ID = v_item_id;
			dbms_output.put_line('Not enough the item ID: ' || v_item_id || ' for write-off from stock. Restock the item: ' || v_item_name || ', please.');
				raise_application_error(-20010, 'Not enough the item #' || v_item_id || ' for write-off from stock. Restock the item: ' || v_item_name || ', please.');
		END IF;
	END LOOP;
	--End check #5
	--------------------------------------	
	--------------------------------------
	--Check #6. If there is enough drink in the ctock 
	--and there will be no write-off of drink in the negative uantity
	--determening the drink quantity in the stock
	SELECT sum(QUANTITY) INTO v_drink_stock_quantity FROM STOCKS 
	WHERE ITEM_ID = :NEW.drink_id AND OUTLET_ID = :NEW.outlet_id;
	--determine whether the drink is sold by pouring into a cup with a capacity of 0.5 l 
	--or in a certain container, for example, in a can or a bottle 
	SELECT product_unit INTO v_drink_unit FROM items WHERE item_id = :NEW.drink_id;
	IF upper(v_drink_unit) = 'L' THEN
		v_drink_quantity := 0.5;
	END IF;
	IF (v_drink_stock_quantity - (:NEW.quantity * v_drink_quantity)) < 0 THEN 	
		SELECT item_name INTO v_drink_name FROM ITEMS 
		WHERE ITEM_ID = :NEW.drink_id;
		dbms_output.put_line('Not enough the drink ID: ' || :NEW.drink_id || ' for write-off from stock. Restock the drink: ' || v_drink_name || ', please.');
			raise_application_error(-20010, 'Not enough the item #' || :NEW.drink_id || ' for write-off from stock. Restock the item: ' || v_drink_name || ', please.');
	END IF;
	--End check #6
	--------------------------------------	
	--------------------------------------
	--Check #7. If needs to restock some items in the stock
	FOR v_pres_item IN order_items
	LOOP
		v_stock_quantity := 0;
		v_item_id := v_pres_item.item_id;
		--determening the item quantity in the stock
		SELECT sum(QUANTITY) INTO v_stock_quantity FROM STOCKS
		WHERE ITEM_ID = v_item_id AND OUTLET_ID = :NEW.outlet_id;
		--determening restock_value for the current item
		SELECT restock_value INTO v_restock_value FROM ITEMS 
		WHERE ITEM_ID = v_item_id;
		IF (v_stock_quantity - (:NEW.quantity * v_pres_item.quantity)) <= v_restock_value THEN 	
			SELECT item_name INTO v_item_name FROM ITEMS 
			WHERE ITEM_ID = v_item_id;
			dbms_output.put_line('Restock the item ID: ' || v_item_id || ' in the stock, please. The item name: ' || v_item_name);
		END IF;
	END LOOP;
	--End check #7
	--------------------------------------	
	--------------------------------------
	--Check #8. If needs to restock the drink in the stock
	SELECT sum(QUANTITY) INTO v_drink_stock_quantity FROM STOCKS 
	WHERE ITEM_ID = :NEW.drink_id AND OUTLET_ID = :NEW.outlet_id;
	--determine whether the drink is sold by pouring into a cup with a capacity of 0.5 l 
	--or in a certain container, for example, in a can or a bottle 
	SELECT product_unit, restock_value INTO v_drink_unit, v_restock_drink_value
	FROM items WHERE item_id = :NEW.drink_id;
	IF upper(v_drink_unit) = 'L' THEN
		v_drink_quantity := 0.5;
	END IF;
	IF (v_drink_stock_quantity - (:NEW.quantity * v_drink_quantity)) <= v_restock_drink_value THEN 	
		SELECT item_name INTO v_drink_name FROM ITEMS 
		WHERE ITEM_ID = :NEW.drink_id;
			dbms_output.put_line('Restock the drink ID: ' || :NEW.drink_id || ' in the stock, please. The drink name: ' || v_drink_name);
	END IF;
	--End check #8
	--------------------------------------	
	--------------------------------------
	--#9. Determinate the total amount of the order
	IF :NEW.Quantity IS NOT NULL AND 
		:NEW.Menu_ID IS NOT NULL AND 
		:NEW.amount IS NULL THEN 
		SELECT price INTO v_menu_price FROM MENUS m2 WHERE MENU_ID = :NEW.Menu_ID;
		:NEW.amount := :NEW.quantity * v_menu_price;
	END IF;
	--End #9
	--------------------------------------	
	--------------------------------------
	--#10 autonumeration with prefix 'Ord-'
	IF :NEW.order_id IS NULL THEN 
		SELECT	'Ord-' || trim(to_char(order_seq.nextval, '00000099'))
		INTO 	:NEW.Order_ID
		FROM	dual;
	END IF ;
	--End #10
	--------------------------------------	
	--------------------------------------
	--Check #11. If customer is choosen. If not will create a new customer
	IF :NEW.customer_id IS NULL THEN 
		SELECT 	CUS_SEQ.nextval 
		INTO	o_cust_id 
		FROM 	dual;
		INSERT INTO Customers VALUES (o_cust_id, NULL, NULL, NULL, NULL);
		:NEW.CUSTOMER_ID := o_cust_id;
	END IF ;
	--End check #11
END;
/
--Create Trigger to write-off ordered quantity of items in the stock
CREATE OR REPLACE TRIGGER order_write_off
	AFTER INSERT OR UPDATE ON Orders
	FOR EACH ROW
DECLARE 
	--define explisit cursor for stock quantity checking
	CURSOR order_items IS 
		SELECT item_id, quantity 
		FROM MENUSPECIFICATION m 
		WHERE MENU_ID = :NEW.menu_id;
	--define variables to check the quantity of items in the stock
	v_item_id items.item_id%TYPE;
	--define variables to check the quantity of the drink in the stock
	v_drink_unit items.product_unit%TYPE;
	v_drink_quantity number(8,3) := 1;
BEGIN	
	--#1. Items from menuspecification	
	FOR v_pres_item IN order_items
	LOOP
		v_item_id := v_pres_item.item_id;
		--add the new row to the stock table with negative value (write-offs)
		INSERT INTO stocks VALUES (:NEW.outlet_id, v_item_id, :NEW.order_id, :NEW.order_date, -(:NEW.quantity * v_pres_item.quantity));
	END LOOP;
	--#2. The drink
	--determine whether the drink is sold by pouring into a cup with a capacity of 0.5 l 
	--or in a certain container, for example, in a can or a bottle 
	SELECT product_unit INTO v_drink_unit FROM items WHERE item_id = :NEW.drink_id;
	IF upper(v_drink_unit) = 'L' THEN
		v_drink_quantity := 0.5;
	END IF;
	--add the new row to the stock table with negative value (write-offs)
	INSERT INTO stocks VALUES (:NEW.outlet_id, :NEW.drink_id, :NEW.order_id, :NEW.order_date, -(:NEW.quantity * v_drink_quantity));
END;
/
--Create Trigger to delete already ordered quantity of items in the stock
CREATE OR REPLACE TRIGGER order_delete_stock
	BEFORE DELETE ON Orders
	FOR EACH ROW
BEGIN	
	DELETE FROM STOCKS WHERE OUTLET_ID = :OLD.outlet_id AND DOCUMENT_ID = :OLD.order_id;
END;
/
--Insert Orders for the each of outlets
--Outlet #1 Edi-01
--September 2020
--01-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 6, 'card', 7, NULL);

--02-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 5, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 5, 'card', 7, NULL);

--03-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 4, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 4, 6, 'card', 7, NULL);

--04-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 3, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 3, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 3, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 3, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 3, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 3, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 3, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 3, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 3, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 3, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 3, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 3, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 3, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 3, 5, 'card', 7, NULL);

--05-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 2, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 2, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 2, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 4, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 2, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 2, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 2, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 4, 6, 'card', 7, NULL);

--14-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 6, 'card', 7, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 23, 7, 3, 5, 'cash', 5, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 6, 'card', 7, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 19, 14, 2, 6, 'card', 7, NULL);

--15-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 5, 'card', 7, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 19, 14, 2, 5, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 5, 'card', 7, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 23, 7, 1, 5, 'cash', 5, NULL);

--16-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 4, 6, 'card', 7, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 19, 14, 4, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 4, 6, 'card', 7, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in September', 23, 7, 3, 6, 'cash', 5, NULL);

--October 2020
--01-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('01-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 6, 'card', 7, NULL);

--02-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 5, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 5, 'card', 7, NULL);

--03-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('02-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 4, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('03-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 4, 6, 'card', 7, NULL);

--04-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 3, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 3, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 3, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 3, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 3, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 3, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 3, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 3, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 3, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 3, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 3, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 3, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 3, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('04-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 3, 5, 'card', 7, NULL);

--05-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 2, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 2, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 2, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 4, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 2, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 2, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 2, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 2, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 2, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('05-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 4, 6, 'card', 7, NULL);

--12-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 6, 'card', 7, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 23, 7, 3, 5, 'cash', 5, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 6, 'card', 7, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 26, 10, 2, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 27, 11, 3, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 19, 14, 2, 6, 'card', 7, NULL);

--13-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 2, 5, 'card', 7, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 19, 14, 2, 5, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 2, 5, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 1, 5, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 2, 5, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 2, 5, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 1, 5, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 2, 5, 'card', 7, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 17, 1, 1, 5, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 18, 2, 2, 5, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 19, 3, 1, 5, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 20, 4, 2, 5, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 21, 5, 1, 5, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 22, 6, 2, 5, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 23, 7, 1, 5, 'cash', 5, NULL);

--14-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular breakfast', 19, 14, 4, 6, 'card', 7, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 19, 14, 4, 6, 'card', 7, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 23, 7, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 24, 8, 4, 6, 'card', 12, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 25, 9, 3, 6, 'cash', 22, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 26, 10, 4, 6, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 27, 11, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 17, 12, 4, 6, 'card', 10, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 18, 13, 3, 6, 'cash', 6, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'regular afternoon', 19, 14, 4, 6, 'card', 7, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 17, 1, 3, 6, 'cash', 5, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 18, 2, 4, 6, 'card', 9, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 19, 3, 3, 6, 'cash', 8, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 20, 4, 4, 6, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 21, 5, 3, 6, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 22, 6, 4, 6, 'card', 4, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-01', 'savers in October', 23, 7, 3, 6, 'cash', 5, NULL);





--Outlet #2 Edi-02
--September 2020
--14-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 2, 8, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 3, 9, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 22, 6, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 23, 7, 9, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 26, 10, 8, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 27, 11, 9, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 14, 8, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 18, 2, 8, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 19, 3, 9, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 22, 6, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 23, 7, 9, 17, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 2, 8, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 3, 9, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 22, 6, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 23, 7, 9, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 26, 10, 8, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 27, 11, 9, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 14, 8, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 24, 8, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 26, 10, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 27, 11, 9, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 17, 12, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 19, 14, 8, 18, 'card', 1, NULL);

--15-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 2, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 20, 4, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 22, 6, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 24, 8, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 26, 10, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 12, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 14, 8, 17, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 24, 8, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 26, 10, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 27, 11, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 17, 12, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 19, 14, 8, 17, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 2, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 20, 4, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 22, 6, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 24, 8, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 26, 10, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 12, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 14, 8, 17, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 18, 2, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 20, 4, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 22, 6, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 23, 7, 13, 17, 'cash', 1, NULL);

--16-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 1, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 2, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 3, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 21, 5, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 22, 6, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 23, 7, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 25, 9, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 26, 10, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 27, 11, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 13, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 14, 10, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 24, 8, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 25, 9, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 26, 10, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 27, 11, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 17, 12, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 18, 13, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 19, 14, 10, 18, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 1, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 2, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 3, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 21, 5, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 22, 6, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 23, 7, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 25, 9, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 26, 10, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 27, 11, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 13, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 14, 10, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 17, 1, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 18, 2, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 19, 3, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 21, 5, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 22, 6, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in September', 23, 7, 9, 18, 'cash', 1, NULL);

--12-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 2, 8, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 3, 9, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 22, 6, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 23, 7, 9, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 26, 10, 8, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 27, 11, 9, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 14, 8, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 18, 2, 8, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 19, 3, 9, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 22, 6, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 23, 7, 9, 17, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 2, 8, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 3, 9, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 22, 6, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 23, 7, 9, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 26, 10, 8, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 27, 11, 9, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 14, 8, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 24, 8, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 26, 10, 8, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 27, 11, 9, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 17, 12, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 19, 14, 8, 18, 'card', 1, NULL);

--13-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 2, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 20, 4, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 22, 6, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 24, 8, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 26, 10, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 12, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 14, 8, 17, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 24, 8, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 26, 10, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 27, 11, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 17, 12, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 19, 14, 8, 17, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 2, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 20, 4, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 22, 6, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 24, 8, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 26, 10, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 12, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 14, 8, 17, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 18, 2, 8, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 20, 4, 8, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 22, 6, 8, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 23, 7, 13, 17, 'cash', 1, NULL);

--14-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 1, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 2, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 3, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 21, 5, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 22, 6, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 23, 7, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 25, 9, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 26, 10, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 27, 11, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 18, 13, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular breakfast', 19, 14, 10, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 24, 8, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 25, 9, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 26, 10, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 27, 11, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 17, 12, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 18, 13, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 19, 14, 10, 18, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 1, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 2, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 3, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 21, 5, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 22, 6, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 23, 7, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 24, 8, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 25, 9, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 26, 10, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 27, 11, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 17, 12, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 18, 13, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'regular afternoon', 19, 14, 10, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 17, 1, 9, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 18, 2, 10, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 19, 3, 9, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 20, 4, 10, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 21, 5, 9, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 22, 6, 10, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Edi-02', 'savers in October', 23, 7, 9, 18, 'cash', 1, NULL);





--Outlet #3 Liv-01
--September 2020
--14-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 2, 14, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 3, 15, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 22, 6, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 23, 7, 15, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 26, 10, 14, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 27, 11, 15, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 14, 14, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 18, 2, 14, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 19, 3, 15, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 22, 6, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 23, 7, 15, 17, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 2, 14, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 3, 15, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 22, 6, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 23, 7, 15, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 26, 10, 14, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 27, 11, 15, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 14, 14, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 24, 8, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 26, 10, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 27, 11, 15, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 17, 12, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 19, 14, 14, 18, 'card', 1, NULL);

--15-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 2, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 20, 4, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 22, 6, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 24, 8, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 26, 10, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 12, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 14, 14, 17, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 24, 8, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 26, 10, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 27, 11, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 17, 12, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 19, 14, 14, 17, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 2, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 20, 4, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 22, 6, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 24, 8, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 26, 10, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 12, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 14, 14, 17, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 18, 2, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 20, 4, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 22, 6, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 23, 7, 13, 17, 'cash', 1, NULL);

--16-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 1, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 2, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 3, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 21, 5, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 22, 6, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 23, 7, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 25, 9, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 26, 10, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 27, 11, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 13, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 14, 16, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 24, 8, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 25, 9, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 26, 10, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 27, 11, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 17, 12, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 18, 13, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 19, 14, 16, 18, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 1, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 2, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 3, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 21, 5, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 22, 6, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 23, 7, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 25, 9, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 26, 10, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 27, 11, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 13, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 14, 16, 18, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 17, 1, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 18, 2, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 19, 3, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 21, 5, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 22, 6, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in September', 23, 7, 15, 18, 'cash', 1, NULL);

--12-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 2, 14, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 3, 15, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 22, 6, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 23, 7, 15, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 26, 10, 14, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 27, 11, 15, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 14, 14, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 18, 2, 14, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 19, 3, 15, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 22, 6, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 23, 7, 15, 17, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 2, 14, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 3, 15, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 22, 6, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 23, 7, 15, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 26, 10, 14, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 27, 11, 15, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 14, 14, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 24, 8, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 26, 10, 14, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 27, 11, 15, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 17, 12, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 19, 14, 14, 18, 'card', 1, NULL);

--13-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 2, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 20, 4, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 22, 6, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 24, 8, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 26, 10, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 12, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 14, 14, 17, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 24, 8, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 25, 9, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 26, 10, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 27, 11, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 17, 12, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 18, 13, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 19, 14, 14, 17, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 2, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 20, 4, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 22, 6, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 23, 7, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 24, 8, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 25, 9, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 26, 10, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 27, 11, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 12, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 13, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 14, 14, 17, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 17, 1, 13, 17, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 18, 2, 14, 17, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 19, 3, 13, 17, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 20, 4, 14, 17, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 21, 5, 13, 17, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 22, 6, 14, 17, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 23, 7, 13, 17, 'cash', 1, NULL);

--14-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 1, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 2, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 3, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 21, 5, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 22, 6, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 23, 7, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 25, 9, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 26, 10, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 27, 11, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 18, 13, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular breakfast', 19, 14, 16, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 24, 8, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 25, 9, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 26, 10, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 27, 11, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 17, 12, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 18, 13, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 19, 14, 16, 18, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 1, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 2, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 3, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 21, 5, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 22, 6, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 23, 7, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 24, 8, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 25, 9, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 26, 10, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 27, 11, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 17, 12, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 18, 13, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'regular afternoon', 19, 14, 16, 18, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 17, 1, 15, 18, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 18, 2, 16, 18, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 19, 3, 15, 18, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 20, 4, 16, 18, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 21, 5, 15, 18, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 22, 6, 16, 18, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Liv-01', 'savers in October', 23, 7, 15, 18, 'cash', 1, NULL);





--Outlet #4 Gla-01
--September 2020
--14-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 2, 20, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 3, 21, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 22, 6, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 23, 7, 21, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 26, 10, 20, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 27, 11, 21, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 14, 20, 24, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 18, 2, 20, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 19, 3, 21, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 22, 6, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 23, 7, 21, 23, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 2, 20, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 3, 21, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 22, 6, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 23, 7, 21, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 26, 10, 20, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 27, 11, 21, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 14, 20, 24, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 24, 8, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 25, 9, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 26, 10, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 27, 11, 21, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 17, 12, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 18, 13, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 19, 14, 20, 24, 'card', 1, NULL);

--15-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 2, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 3, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 20, 4, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 22, 6, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 23, 7, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 24, 8, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 26, 10, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 27, 11, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 12, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 14, 20, 23, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 24, 8, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 25, 9, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 26, 10, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 27, 11, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 17, 12, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 18, 13, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 19, 14, 20, 23, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 2, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 3, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 20, 4, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 22, 6, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 23, 7, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 24, 8, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 26, 10, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 27, 11, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 12, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 14, 20, 23, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 18, 2, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 19, 3, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 20, 4, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 22, 6, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 23, 7, 19, 23, 'cash', 1, NULL);

--16-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 1, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 2, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 3, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 21, 5, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 22, 6, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 23, 7, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 25, 9, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 26, 10, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 27, 11, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 13, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 14, 22, 24, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 24, 8, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 25, 9, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 26, 10, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 27, 11, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 17, 12, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 18, 13, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 19, 14, 22, 24, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 1, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 2, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 3, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 21, 5, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 22, 6, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 23, 7, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 25, 9, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 26, 10, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 27, 11, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 13, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 14, 22, 24, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 17, 1, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 18, 2, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 19, 3, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 21, 5, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 22, 6, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in September', 23, 7, 21, 24, 'cash', 1, NULL);

--12-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 2, 20, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 3, 21, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 22, 6, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 23, 7, 21, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 26, 10, 20, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 27, 11, 21, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 14, 20, 24, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 18, 2, 20, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 19, 3, 21, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 22, 6, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 23, 7, 21, 23, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 2, 20, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 3, 21, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 22, 6, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 23, 7, 21, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 26, 10, 20, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 27, 11, 21, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 14, 20, 24, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 24, 8, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 25, 9, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 26, 10, 20, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 27, 11, 21, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 17, 12, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 18, 13, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 19, 14, 20, 24, 'card', 1, NULL);

--13-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 2, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 3, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 20, 4, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 22, 6, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 23, 7, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 24, 8, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 26, 10, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 27, 11, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 12, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 14, 20, 23, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 24, 8, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 25, 9, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 26, 10, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 27, 11, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 17, 12, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 18, 13, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 19, 14, 20, 23, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 2, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 3, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 20, 4, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 22, 6, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 23, 7, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 24, 8, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 25, 9, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 26, 10, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 27, 11, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 12, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 13, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 14, 20, 23, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 17, 1, 19, 23, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 18, 2, 20, 23, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 19, 3, 19, 23, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 20, 4, 20, 23, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 21, 5, 19, 23, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 22, 6, 20, 23, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 23, 7, 19, 23, 'cash', 1, NULL);

--14-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 1, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 2, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 3, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 21, 5, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 22, 6, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 23, 7, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 25, 9, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 26, 10, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 27, 11, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 18, 13, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular breakfast', 19, 14, 22, 24, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 24, 8, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 25, 9, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 26, 10, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 27, 11, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 17, 12, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 18, 13, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 19, 14, 22, 24, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 1, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 2, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 3, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 21, 5, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 22, 6, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 23, 7, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 24, 8, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 25, 9, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 26, 10, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 27, 11, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 17, 12, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 18, 13, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'regular afternoon', 19, 14, 22, 24, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 17, 1, 21, 24, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 18, 2, 22, 24, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 19, 3, 21, 24, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 20, 4, 22, 24, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 21, 5, 21, 24, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 22, 6, 22, 24, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-01', 'savers in October', 23, 7, 21, 24, 'cash', 1, NULL);





--Outlet #5 Gla-02		
--September 2020
--14-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 2, 26, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 3, 27, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 22, 6, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 23, 7, 27, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 26, 10, 26, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 27, 11, 27, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 14, 26, 30, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 18, 2, 26, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 19, 3, 27, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 22, 6, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 23, 7, 27, 29, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 2, 26, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 3, 27, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 22, 6, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 23, 7, 27, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 26, 10, 26, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 27, 11, 27, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 14, 26, 30, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 24, 8, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 25, 9, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 26, 10, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 27, 11, 27, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 17, 12, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 18, 13, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-09-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 19, 14, 26, 30, 'card', 1, NULL);

--15-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 2, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 3, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 20, 4, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 22, 6, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 23, 7, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 24, 8, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 26, 10, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 27, 11, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 12, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 14, 26, 29, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 24, 8, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 25, 9, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 26, 10, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 27, 11, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 17, 12, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 18, 13, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 19, 14, 26, 29, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 2, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 3, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 20, 4, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 22, 6, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 23, 7, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 24, 8, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 26, 10, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 27, 11, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 12, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 14, 26, 29, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 18, 2, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 19, 3, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 20, 4, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 22, 6, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 23, 7, 25, 29, 'cash', 1, NULL);

--16-Sep-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 1, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 2, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 3, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 21, 5, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 22, 6, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 23, 7, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 25, 9, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 26, 10, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 27, 11, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 13, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 14, 28, 30, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 24, 8, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 25, 9, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 26, 10, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 27, 11, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 17, 12, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 18, 13, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 19, 14, 28, 30, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 1, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 2, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 3, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 21, 5, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 22, 6, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 23, 7, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 25, 9, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 26, 10, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 27, 11, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 13, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 14, 28, 30, 'card', 2, NULL);

--savers in September
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 17, 1, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 18, 2, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 19, 3, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 21, 5, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 22, 6, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-09-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in September', 23, 7, 27, 30, 'cash', 1, NULL);

--12-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 2, 26, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 3, 27, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 22, 6, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 23, 7, 27, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 26, 10, 26, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 27, 11, 27, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 14, 26, 30, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 18, 2, 26, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 19, 3, 27, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 22, 6, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 23, 7, 27, 29, 'cash', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 2, 26, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 3, 27, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 22, 6, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 23, 7, 27, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 26, 10, 26, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 27, 11, 27, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 14, 26, 30, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 24, 8, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 25, 9, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 13:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 26, 10, 26, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 27, 11, 27, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 17, 12, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 18, 13, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('14-10-2020 14:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 19, 14, 26, 30, 'card', 1, NULL);

--13-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 2, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 3, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 20, 4, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 22, 6, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 23, 7, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 24, 8, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 26, 10, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 27, 11, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 12, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 14, 26, 29, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 24, 8, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 25, 9, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 26, 10, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 27, 11, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 17, 12, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 18, 13, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 10:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 19, 14, 26, 29, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 2, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 3, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 20, 4, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 22, 6, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 23, 7, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 24, 8, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 25, 9, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 26, 10, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 27, 11, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 12, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 13, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 14, 26, 29, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 17, 1, 25, 29, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 18, 2, 26, 29, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 19, 3, 25, 29, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 20, 4, 26, 29, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 21, 5, 25, 29, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 22, 6, 26, 29, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('15-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 23, 7, 25, 29, 'cash', 1, NULL);

--14-Oct-2020
--Breakfast section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 1, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 2, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 3, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 21, 5, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 07:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 22, 6, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 23, 7, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 25, 9, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 26, 10, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 27, 11, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 08:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 18, 13, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular breakfast', 19, 14, 28, 30, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 24, 8, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 25, 9, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 09:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 26, 10, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 27, 11, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 17, 12, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 18, 13, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 10:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 19, 14, 28, 30, 'card', 1, NULL);

--Afternoon section
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:05:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 1, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 2, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 3, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 21, 5, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 11:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 22, 6, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 23, 7, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:15:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 24, 8, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:25:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 25, 9, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:35:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 26, 10, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:45:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 27, 11, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 12:55:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 17, 12, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 18, 13, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'regular afternoon', 19, 14, 28, 30, 'card', 2, NULL);

--savers in October
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 17, 1, 27, 30, 'cash', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:40:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 18, 2, 28, 30, 'card', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 19, 3, 27, 30, 'cash', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 20, 4, 28, 30, 'card', 1, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:10:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 21, 5, 27, 30, 'cash', 2, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:20:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 22, 6, 28, 30, 'card', 3, NULL);
INSERT INTO ORDERS VALUES (null, to_date('16-10-2020 14:30:01', 'dd-mm-yyyy hh24:mi:ss'), 'Gla-02', 'savers in October', 23, 7, 27, 30, 'cash', 1, NULL);
/
/*
 * #1.15
 * Create Views of Employees for the each outlet
 */	
--View of Employees for the Edi-01 outlet
CREATE VIEW emp_view_edi_01 AS
	SELECT employee_id id, employee_name name, employee_surname surname, job_title title, outlet_name outlet
	FROM employees e, jobs j, outlets o
	where e.JOB_ID = j.JOB_ID AND e.OUTLET_ID = o.OUTLET_ID 
	AND e.OUTLET_ID = 'Edi-01'
	ORDER BY employee_id;
/
--View of Employees for the Edi-02 outlet
CREATE VIEW emp_view_edi_02 AS
	SELECT employee_id id, employee_name name, employee_surname surname, job_title title, outlet_name outlet
	FROM employees e, jobs j, outlets o
	where e.JOB_ID = j.JOB_ID AND e.OUTLET_ID = o.OUTLET_ID 
	AND e.OUTLET_ID = 'Edi-02'
	ORDER BY employee_id;
/
--View of Employees for the Liv-01 outlet
CREATE VIEW emp_view_liv_01 AS
	SELECT employee_id id, employee_name name, employee_surname surname, job_title title, outlet_name outlet
	FROM employees e, jobs j, outlets o
	where e.JOB_ID = j.JOB_ID AND e.OUTLET_ID = o.OUTLET_ID 
	AND e.OUTLET_ID = 'Liv-01'
	ORDER BY employee_id;
/
--View of Employees for the Gla-01 outlet
CREATE VIEW emp_view_gla_01 AS
	SELECT employee_id id, employee_name name, employee_surname surname, job_title title, outlet_name outlet
	FROM employees e, jobs j, outlets o
	where e.JOB_ID = j.JOB_ID AND e.OUTLET_ID = o.OUTLET_ID 
	AND e.OUTLET_ID = 'Gla-01'
	ORDER BY employee_id;
/
--View of Employees for the Gla-02 outlet
CREATE VIEW emp_view_gla_02 AS
	SELECT employee_id id, employee_name name, employee_surname surname, job_title title, outlet_name outlet
	FROM employees e, jobs j, outlets o
	where e.JOB_ID = j.JOB_ID AND e.OUTLET_ID = o.OUTLET_ID 
	AND e.OUTLET_ID = 'Gla-02'
	ORDER BY employee_id;
/
/*
 * #1.16
 * Create View of all items
 */	
CREATE VIEW item_view AS
	SELECT item_id id, item_name "Name", product_unit "Unit", 
			(CASE WHEN drinks = 1 THEN 'Yes' ELSE '' END) AS "Drink", 
			restock_value "Restock val."
	FROM ITEMS ORDER BY item_id;
/
/*
 * #1.17
 * Create Views of invoices for each outlet
 */	
--View of invoices for the Edi-01 outlet
CREATE VIEW invoice_view_edi_01 AS
	SELECT invoice_id "Invoice #", to_char(invoice_date, 'dd-Mon-yyyy') "Date", 
			p.outlet_id "Outlet",
			employee_name || ' ' || employee_surname "Manager"
	FROM PURCHASEINVOICE p, EMPLOYEES e 
	WHERE p.MANAGER_ID = e.EMPLOYEE_ID AND 
			p.OUTLET_ID = 'Edi-01';
/
--View of invoices for the Edi-02 outlet
CREATE VIEW invoice_view_edi_02 AS
	SELECT invoice_id "Invoice #", to_char(invoice_date, 'dd-Mon-yyyy') "Date", 
			p.outlet_id "Outlet",
			employee_name || ' ' || employee_surname "Manager"
	FROM PURCHASEINVOICE p, EMPLOYEES e 
	WHERE p.MANAGER_ID = e.EMPLOYEE_ID AND 
			p.OUTLET_ID = 'Edi-02';
/
--View of invoices for the Liv-01 outlet
CREATE VIEW invoice_view_liv_01 AS
	SELECT invoice_id "Invoice #", to_char(invoice_date, 'dd-Mon-yyyy') "Date", 
			p.outlet_id "Outlet",
			employee_name || ' ' || employee_surname "Manager"
	FROM PURCHASEINVOICE p, EMPLOYEES e 
	WHERE p.MANAGER_ID = e.EMPLOYEE_ID AND 
			p.OUTLET_ID = 'Liv-01';
/
--View of invoices for the Gla-01 outlet
CREATE VIEW invoice_view_gla_01 AS
	SELECT invoice_id "Invoice #", to_char(invoice_date, 'dd-Mon-yyyy') "Date", 
			p.outlet_id "Outlet",
			employee_name || ' ' || employee_surname "Manager"
	FROM PURCHASEINVOICE p, EMPLOYEES e 
	WHERE p.MANAGER_ID = e.EMPLOYEE_ID AND 
			p.OUTLET_ID = 'Gla-01';
/
--View of invoices for the Gla-02 outlet
CREATE VIEW invoice_view_gla_02 AS
	SELECT invoice_id "Invoice #", to_char(invoice_date, 'dd-Mon-yyyy') "Date", 
			p.outlet_id "Outlet",
			employee_name || ' ' || employee_surname "Manager"
	FROM PURCHASEINVOICE p, EMPLOYEES e 
	WHERE p.MANAGER_ID = e.EMPLOYEE_ID AND 
			p.OUTLET_ID = 'Gla-02';
/
/*
 * #1.18
 * Create Views of orders for each outlet
 */	
--View of orders for the Edi-01 outlet
CREATE VIEW orders_view_edi_01 AS
	SELECT order_id "Order #", to_char(order_date, 'dd-Mon-yyyy') "Date", 
			o.outlet_id "Outlet",
			e.employee_name || ' ' || e.employee_surname "Staff",
			e2.employee_name || ' ' || e2.employee_surname "Cook",		
			PAYMENT_ID "Pay", quantity "Qty.", to_char(AMOUNT, '999,999.99') "Total"
	FROM ORDERS o , EMPLOYEES e, EMPLOYEES e2 
	WHERE o.EMPLOYEE_ID = e.EMPLOYEE_ID AND 
			o.cook = e2.EMPLOYEE_ID AND 
			o.OUTLET_ID = 'Edi-01'
	UNION ALL
	SELECT 'Paid by card:', to_char(count(o2.order_id)), '', '', '', '', sum(o2.QUANTITY), to_char(sum(o2.AMOUNT),'99,999.99')
	FROM ORDERS o2 
	WHERE o2.OUTLET_ID = 'Edi-01' AND o2.PAYMENT_ID = 'card'
	UNION ALL
	SELECT 'Paid in cash:', to_char(count(o3.order_id)), '', '', '', '', sum(o3.QUANTITY), to_char(sum(o3.AMOUNT),'99,999.99')
	FROM ORDERS o3 
	WHERE o3.OUTLET_ID = 'Edi-01' AND o3.PAYMENT_ID = 'cash'
	UNION ALL
	SELECT 'Total orders:', to_char(count(o4.order_id)), '', '', '', '', sum(o4.QUANTITY), to_char(sum(o4.AMOUNT),'99,999.99')
	FROM ORDERS o4 
	WHERE o4.OUTLET_ID = 'Edi-01'
	GROUP BY 'Order #', 'Date', 'Outlet', 'Staff', 'Cook', 'Pay'
	ORDER BY 1;
/		
--View of orders for the Edi-02 outlet
CREATE VIEW orders_view_edi_02 AS
	SELECT order_id "Order #", to_char(order_date, 'dd-Mon-yyyy') "Date", 
			o.outlet_id "Outlet",
			e.employee_name || ' ' || e.employee_surname "Staff",
			e2.employee_name || ' ' || e2.employee_surname "Cook",		
			PAYMENT_ID "Pay", quantity "Qty.", to_char(AMOUNT, '999,999.99') "Total"
	FROM ORDERS o , EMPLOYEES e, EMPLOYEES e2 
	WHERE o.EMPLOYEE_ID = e.EMPLOYEE_ID AND 
			o.cook = e2.EMPLOYEE_ID AND 
			o.OUTLET_ID = 'Edi-02'
	UNION ALL
	SELECT 'Paid by card:', to_char(count(o2.order_id)), '', '', '', '', sum(o2.QUANTITY), to_char(sum(o2.AMOUNT),'99,999.99')
	FROM ORDERS o2 
	WHERE o2.OUTLET_ID = 'Edi-02' AND o2.PAYMENT_ID = 'card'
	UNION ALL
	SELECT 'Paid in cash:', to_char(count(o3.order_id)), '', '', '', '', sum(o3.QUANTITY), to_char(sum(o3.AMOUNT),'99,999.99')
	FROM ORDERS o3 
	WHERE o3.OUTLET_ID = 'Edi-02' AND o3.PAYMENT_ID = 'cash'
	UNION ALL
	SELECT 'Total orders:', to_char(count(o4.order_id)), '', '', '', '', sum(o4.QUANTITY), to_char(sum(o4.AMOUNT),'99,999.99')
	FROM ORDERS o4 
	WHERE o4.OUTLET_ID = 'Edi-02'
	GROUP BY 'Order #', 'Date', 'Outlet', 'Staff', 'Cook', 'Pay'
	ORDER BY 1;
/
--View of orders for the Liv-01 outlet
CREATE VIEW orders_view_liv_01 AS
	SELECT order_id "Order #", to_char(order_date, 'dd-Mon-yyyy') "Date", 
			o.outlet_id "Outlet",
			e.employee_name || ' ' || e.employee_surname "Staff",
			e2.employee_name || ' ' || e2.employee_surname "Cook",		
			PAYMENT_ID "Pay", quantity "Qty.", to_char(AMOUNT, '999,999.99') "Total"
	FROM ORDERS o , EMPLOYEES e, EMPLOYEES e2 
	WHERE o.EMPLOYEE_ID = e.EMPLOYEE_ID AND 
			o.cook = e2.EMPLOYEE_ID AND 
			o.OUTLET_ID = 'Liv-01'
	UNION ALL
	SELECT 'Paid by card:', to_char(count(o2.order_id)), '', '', '', '', sum(o2.QUANTITY), to_char(sum(o2.AMOUNT),'99,999.99')
	FROM ORDERS o2 
	WHERE o2.OUTLET_ID = 'Liv-01' AND o2.PAYMENT_ID = 'card'
	UNION ALL
	SELECT 'Paid in cash:', to_char(count(o3.order_id)), '', '', '', '', sum(o3.QUANTITY), to_char(sum(o3.AMOUNT),'99,999.99')
	FROM ORDERS o3 
	WHERE o3.OUTLET_ID = 'Liv-01' AND o3.PAYMENT_ID = 'cash'
	UNION ALL
	SELECT 'Total orders:', to_char(count(o4.order_id)), '', '', '', '', sum(o4.QUANTITY), to_char(sum(o4.AMOUNT),'99,999.99')
	FROM ORDERS o4 
	WHERE o4.OUTLET_ID = 'Liv-01'
	GROUP BY 'Order #', 'Date', 'Outlet', 'Staff', 'Cook', 'Pay'
	ORDER BY 1;
/
--View of orders for the Gla-01 outlet
CREATE VIEW orders_view_gla_01 AS
	SELECT order_id "Order #", to_char(order_date, 'dd-Mon-yyyy') "Date", 
			o.outlet_id "Outlet",
			e.employee_name || ' ' || e.employee_surname "Staff",
			e2.employee_name || ' ' || e2.employee_surname "Cook",		
			PAYMENT_ID "Pay", quantity "Qty.", to_char(AMOUNT, '999,999.99') "Total"
	FROM ORDERS o , EMPLOYEES e, EMPLOYEES e2 
	WHERE o.EMPLOYEE_ID = e.EMPLOYEE_ID AND 
			o.cook = e2.EMPLOYEE_ID AND 
			o.OUTLET_ID = 'Gla-01'
	UNION ALL
	SELECT 'Paid by card:', to_char(count(o2.order_id)), '', '', '', '', sum(o2.QUANTITY), to_char(sum(o2.AMOUNT),'99,999.99')
	FROM ORDERS o2 
	WHERE o2.OUTLET_ID = 'Gla-01' AND o2.PAYMENT_ID = 'card'
	UNION ALL
	SELECT 'Paid in cash:', to_char(count(o3.order_id)), '', '', '', '', sum(o3.QUANTITY), to_char(sum(o3.AMOUNT),'99,999.99')
	FROM ORDERS o3 
	WHERE o3.OUTLET_ID = 'Gla-01' AND o3.PAYMENT_ID = 'cash'
	UNION ALL
	SELECT 'Total orders:', to_char(count(o4.order_id)), '', '', '', '', sum(o4.QUANTITY), to_char(sum(o4.AMOUNT),'99,999.99')
	FROM ORDERS o4 
	WHERE o4.OUTLET_ID = 'Gla-01'
	GROUP BY 'Order #', 'Date', 'Outlet', 'Staff', 'Cook', 'Pay'
	ORDER BY 1;
/
--View of orders for the Gla-02 outlet
CREATE VIEW orders_view_gla_02 AS
	SELECT order_id "Order #", to_char(order_date, 'dd-Mon-yyyy') "Date", 
			o.outlet_id "Outlet",
			e.employee_name || ' ' || e.employee_surname "Staff",
			e2.employee_name || ' ' || e2.employee_surname "Cook",		
			PAYMENT_ID "Pay", quantity "Qty.", to_char(AMOUNT, '999,999.99') "Total"
	FROM ORDERS o , EMPLOYEES e, EMPLOYEES e2 
	WHERE o.EMPLOYEE_ID = e.EMPLOYEE_ID AND 
			o.cook = e2.EMPLOYEE_ID AND 
			o.OUTLET_ID = 'Gla-02'
	UNION ALL
	SELECT 'Paid by card:', to_char(count(o2.order_id)), '', '', '', '', sum(o2.QUANTITY), to_char(sum(o2.AMOUNT),'99,999.99')
	FROM ORDERS o2 
	WHERE o2.OUTLET_ID = 'Gla-02' AND o2.PAYMENT_ID = 'card'
	UNION ALL
	SELECT 'Paid in cash:', to_char(count(o3.order_id)), '', '', '', '', sum(o3.QUANTITY), to_char(sum(o3.AMOUNT),'99,999.99')
	FROM ORDERS o3 
	WHERE o3.OUTLET_ID = 'Gla-02' AND o3.PAYMENT_ID = 'cash'
	UNION ALL
	SELECT 'Total orders:', to_char(count(o4.order_id)), '', '', '', '', sum(o4.QUANTITY), to_char(sum(o4.AMOUNT),'99,999.99')
	FROM ORDERS o4 
	WHERE o4.OUTLET_ID = 'Gla-02'
	GROUP BY 'Order #', 'Date', 'Outlet', 'Staff', 'Cook', 'Pay'
	ORDER BY 1;
/
/*
 * #1.19
 * Create Views of all documents (invoices and orders) for each outlet
 */	
--View of all documents (invoices and orders) for the Edi-01 outlet
CREATE VIEW docs_view_edi_01 AS
	SELECT to_char(invoice_date, 'dd-Mon-yyyy') "Date", invoice_id "Doc. #", 'Invoice' "Doc. type", outlet_id "Outlet" 
	FROM PURCHASEINVOICE p 
	WHERE outlet_id = 'Edi-01'
	UNION ALL
	SELECT to_char(order_date, 'dd-Mon-yyyy') "Date", order_id "Doc. #", 'Order' "Doc. type", outlet_id "Outlet" 
	FROM ORDERS o 
	WHERE outlet_id = 'Edi-01'
	ORDER BY 2, 1;
/
--View of all documents (invoices and orders) for the Edi-02 outlet
CREATE VIEW docs_view_edi_02 AS
	SELECT to_char(invoice_date, 'dd-Mon-yyyy') "Date", invoice_id "Doc. #", 'Invoice' "Doc. type", outlet_id "Outlet" 
	FROM PURCHASEINVOICE p 
	WHERE outlet_id = 'Edi-02'
	UNION ALL
	SELECT to_char(order_date, 'dd-Mon-yyyy') "Date", order_id "Doc. #", 'Order' "Doc. type", outlet_id "Outlet" 
	FROM ORDERS o 
	WHERE outlet_id = 'Edi-02'
	ORDER BY 2, 1;
/
--View of all documents (invoices and orders) for the Liv-01 outlet
CREATE VIEW docs_view_liv_01 AS
	SELECT to_char(invoice_date, 'dd-Mon-yyyy') "Date", invoice_id "Doc. #", 'Invoice' "Doc. type", outlet_id "Outlet" 
	FROM PURCHASEINVOICE p 
	WHERE outlet_id = 'Liv-01'
	UNION ALL
	SELECT to_char(order_date, 'dd-Mon-yyyy') "Date", order_id "Doc. #", 'Order' "Doc. type", outlet_id "Outlet" 
	FROM ORDERS o 
	WHERE outlet_id = 'Liv-01'
	ORDER BY 2, 1;
/
--View of all documents (invoices and orders) for the Gla-01 outlet
CREATE VIEW docs_view_gla_01 AS
	SELECT to_char(invoice_date, 'dd-Mon-yyyy') "Date", invoice_id "Doc. #", 'Invoice' "Doc. type", outlet_id "Outlet" 
	FROM PURCHASEINVOICE p 
	WHERE outlet_id = 'Gla-01'
	UNION ALL
	SELECT to_char(order_date, 'dd-Mon-yyyy') "Date", order_id "Doc. #", 'Order' "Doc. type", outlet_id "Outlet" 
	FROM ORDERS o 
	WHERE outlet_id = 'Gla-01'
	ORDER BY 2, 1;
/
--View of all documents (invoices and orders) for the Gla-02 outlet
CREATE VIEW docs_view_gla_02 AS
	SELECT to_char(invoice_date, 'dd-Mon-yyyy') "Date", invoice_id "Doc. #", 'Invoice' "Doc. type", outlet_id "Outlet" 
	FROM PURCHASEINVOICE p 
	WHERE outlet_id = 'Gla-02'
	UNION ALL
	SELECT to_char(order_date, 'dd-Mon-yyyy') "Date", order_id "Doc. #", 'Order' "Doc. type", outlet_id "Outlet" 
	FROM ORDERS o 
	WHERE outlet_id = 'Gla-02'
	ORDER BY 2, 1;
/		
/*
 * #1.20
 * Create Views of stock balance for each outlet
 */	
--View of stock balance for the Edi-01 outlet
CREATE VIEW stock_view_edi_01 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", sum(quantity) "Qty.", outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id
	HAVING OUTLET_ID = 'Edi-01'
	ORDER BY 1;
/
--View of stock balance for the Edi-02 outlet
CREATE VIEW stock_view_edi_02 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", sum(quantity) "Qty.", outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id
	HAVING OUTLET_ID = 'Edi-02'
	ORDER BY 1;
/
--View of stock balance for the Liv-01 outlet
CREATE VIEW stock_view_liv_01 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", sum(quantity) "Qty.", outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id
	HAVING OUTLET_ID = 'Liv-01'
	ORDER BY 1;

--View of stock balance for the Gla-01 outlet
CREATE VIEW stock_view_gla_01 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", sum(quantity) "Qty.", outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id
	HAVING OUTLET_ID = 'Gla-01'
	ORDER BY 1;
/
--View of stock balance for the Gla-02 outlet
CREATE VIEW stock_view_gla_02 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", sum(quantity) "Qty.", outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id
	HAVING OUTLET_ID = 'Gla-02'
	ORDER BY 1;
/
/*
 * #1.21
 * Create Views of restock items for each outlet
 */	
--View of restock items for the Edi-01 outlet
CREATE VIEW restock_view_edi_01 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", 
			sum(quantity) "Qty.", restock_value "Restock val.",
			(restock_value - sum(quantity)) "Dif.",
			outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id, restock_value, 'Dif.'
	HAVING OUTLET_ID = 'Edi-01' AND (restock_value - sum(quantity)) >= 0
	ORDER BY 1;
/
--View of restock items for the Edi-02 outlet
CREATE VIEW restock_view_edi_02 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", 
			sum(quantity) "Qty.", restock_value "Restock val.",
			(restock_value - sum(quantity)) "Dif.",
			outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id, restock_value, 'Dif.'
	HAVING OUTLET_ID = 'Edi-02' AND (restock_value - sum(quantity)) >= 0
	ORDER BY 1;
/
--View of restock items for the Liv-01 outlet
CREATE VIEW restock_view_liv_01 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", 
			sum(quantity) "Qty.", restock_value "Restock val.",
			(restock_value - sum(quantity)) "Dif.",
			outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id, restock_value, 'Dif.'
	HAVING OUTLET_ID = 'Liv-01' AND (restock_value - sum(quantity)) >= 0
	ORDER BY 1;
/
--View of restock items for the Gla-01 outlet
CREATE VIEW restock_view_gla_01 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", 
			sum(quantity) "Qty.", restock_value "Restock val.",
			(restock_value - sum(quantity)) "Dif.",
			outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id, restock_value, 'Dif.'
	HAVING OUTLET_ID = 'Gla-01' AND (restock_value - sum(quantity)) >= 0
	ORDER BY 1;
/
--View of restock items for the Gla-02 outlet
CREATE VIEW restock_view_gla_02 AS
	SELECT s.item_id "Item id", item_name "Item", product_unit "Unit", 
			sum(quantity) "Qty.", restock_value "Restock val.",
			(restock_value - sum(quantity)) "Dif.",
			outlet_id "Outlet"
	FROM stocks s JOIN items i
	ON (s.ITEM_ID = i.ITEM_ID)
	GROUP BY s.item_id, item_name, product_unit, outlet_id, restock_value, 'Dif.'
	HAVING OUTLET_ID = 'Gla-02' AND (restock_value - sum(quantity)) >= 0
	ORDER BY 1;
/
--The Happy End


