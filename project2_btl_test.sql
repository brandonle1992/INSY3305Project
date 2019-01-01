set echo OFF

--Brandon Le
--Project 2

drop table ResDetail_btl;
drop table Reservation_btl;
drop table Agent_btl;
drop table Room_btl;
drop table Customer_btl;
drop table CustType_btl;
drop table AgentType_btl;
drop table RateType_btl;
drop table RoomType_btl;


create table CustType_btl(
	CustType 		varchar(1) not null, 
	CustDesc 	varchar(20) not null,
	PRIMARY KEY(CustType)
	);
	
create table AgentType_btl(
	AgentType	varchar(2) not null,
	AgentDesc	varchar(20) not null,
	PRIMARY KEY(AgentType)
	);
	
create table RateType_btl(
	RateType	varchar(1) not null,
	RateTypeDesc varchar(25) not null,
	PRIMARY KEY(RateType)
	);
	
create table RoomType_btl(
	RoomType		varchar(2) not null,
	RoomTypeDesc	varchar(25) not null,
	PRIMARY KEY(RoomType)
	);


create table Room_btl(
	RoomNum		number(3) not null,
	RoomType	varchar(2) not null,
	PRIMARY KEY(RoomNum),
	FOREIGN KEY(RoomType)
		REFERENCES RoomType_btl(RoomType)
	);
	
create table Agent_btl(
	AgentID		number(3) not null,
	AgentFName	varchar(10) not null,
	AgentLName	varchar(15) not null,
	AgentType	varchar(2) not null,
	PRIMARY KEY(AgentID),
	FOREIGN KEY (AgentType)
		REFERENCES AgentType_btl(AgentType)
	);

create table Customer_btl(
	CustID 		number(3) not null, 
	CustFName 	varchar(10) not null, 
	CustLName 	varchar(15) not null, 
	CustPhone 	char(10), 
	CustType 	varchar(1) not null, 
	LoyaltyID 	number(3),
	PRIMARY KEY(CustID),
	FOREIGN KEY (CustType) 
		REFERENCES CustType_btl(CustType)
	);

create table Reservation_btl(
	ResID			number(4) not null,
	CheckinDate		DATE,
	CheckoutDate	DATE,
	CustID			number(3) not null,
	AgentID			number(3) not null,
	PRIMARY KEY (ResID),
	FOREIGN KEY (CustID)
		References Customer_btl(CustID),
	FOREIGN KEY (AgentID)
		References Agent_btl(AgentID)
	);
	
create table ResDetail_btl(
	ResID			number(4) not null,
	RoomNum			number(3) not null,
	RateType		varchar(1) not null,
	RateAmt			number(5,2),
	constraint ResDetailPK 
		PRIMARY KEY (ResID,RoomNum),
	FOREIGN KEY (RoomNum) 
		References Room_btl(RoomNum),
	FOREIGN KEY (ResID)
		REFERENCES Reservation_btl(ResID),
	FOREIGN KEY (RateType)
		REFERENCES RateType_btl(RateType)
	);
	

describe CustType_btl;
describe Customer_btl;
describe Agent_btl;
describe AgentType_btl;
describe RateType_btl;
describe Room_btl;
describe RoomType_btl;
describe Reservation_btl;
describe ResDetail_btl;


INSERT ALL
into CustType_btl VALUES ('C','Corporate')
into CustType_btl VALUES ('I','Individual')
select * from dual;

INSERT ALL
into AgentType_btl VALUES ('FD','Front Desk')
into AgentType_btl VALUES ('RC','Res Center')
into AgentType_btl VALUES ('T','Telephone')
select * from dual;

Insert ALL
into RoomType_btl VALUES ('K','King Bed')
into RoomType_btl VALUES ('D','2 Double Beds')
into RoomType_btl VALUES ('KS','King Suite')
select * from dual;

Insert ALL
into RateType_btl Values ('C','Corporate')
into RateType_btl Values ('S','Standard')
into RateType_btl Values ('W','Weekend')
select * from dual;

INSERT ALL
into Customer_btl Values (85, 'Wesley', 'Tanner', 8175551193, 'C', 323)
into Customer_btl Values (100, 'Breanna', 'Rhodes', 2145559191, 'I', 129)
into Customer_btl(CustID,CustFName,CustLName,CustType) Values (15, 'Jeff', 'Miner', 'I')
into Customer_btl Values (77, 'Kim', 'Jackson', 8175554911, 'C', 210)
into Customer_btl Values (119, 'Mary', 'Vaughn', 8175552334, 'I', 118)
into Customer_btl Values (97, 'Chris', 'Mancha', 4695553440, 'I', 153)
into Customer_btl Values (28, 'Renee', 'Walker', 2145551193, 'I', 135)
into Customer_btl(CustID,CustFName, CustLName, CustType) Values (23, 'Shelby', 'Day','I')
select * from dual;

INSERT ALL
into Agent_btl Values (20,'Megan','Smith','FD')
into Agent_btl Values (5,'Janice','May','T')
into Agent_btl Values (14,'John','King','RC')
into Agent_btl Values (28,'Ray','Schultz','T')
select * from dual;

INSERT ALL
into Room_btl Values (224, 'K')
into Room_btl Values (225, 'D')
into Room_btl Values (305, 'D')
into Room_btl Values (409, 'D')
into Room_btl Values (320, 'D')
into Room_btl Values (302, 'K')
into Room_btl Values (501, 'KS')
into Room_btl Values (502, 'KS')
into Room_btl Values (321, 'K')
select * from dual;

INSERT ALL
into Reservation_btl Values(1001, '5-FEB-2018', '7-FEB-2018',85,20)
into Reservation_btl Values(1002, '1-FEB-2018', '3-FEB-2018',100,5)
into Reservation_btl Values(1003, '9-FEB-2018', '11-FEB-2018',15,14)
into Reservation_btl Values(1004, '22-FEB-2018', '23-FEB-2018',77,28)
into Reservation_btl Values(1005, '15-FEB-2018', '18-FEB-2018',119,20)
into Reservation_btl Values(1006, '24-FEB-2018', '26-FEB-2018',97,14)
into Reservation_btl Values(1007, '20-FEB-2018', '25-FEB-2018',100,20)
into Reservation_btl Values(1008, '23-MAR-2018', '25-MAR-2018',85,5)
into Reservation_btl Values(1009, '1-MAR-2018', '4-MAR-2018',28,14)
into Reservation_btl Values(1010, '1-MAR-2018', '3-MAR-2018',23,28)
select * from dual;

INSERT ALL
into ResDetail_btl Values(1001, 224, 'C', 120.00)
into ResDetail_btl Values(1001, 225, 'C', 125.00)
into ResDetail_btl Values(1002, 305, 'S', 149.00)
into ResDetail_btl Values(1003, 409, 'W', 99.00)
into ResDetail_btl Values(1004, 320, 'C', 110.00)
into ResDetail_btl Values(1005, 302, 'S', 139.00)
into ResDetail_btl Values(1006, 501, 'W', 119.00)
into ResDetail_btl Values(1006, 502, 'W', 119.00)
into ResDetail_btl Values(1007, 302, 'S', 139.00)
into ResDetail_btl Values(1008, 320, 'W', 89.00)
into ResDetail_btl Values(1008, 321, 'W', 99.00)
into ResDetail_btl Values(1009, 502, 'W', 129.00)
into ResDetail_btl Values(1010, 225, 'W', 129.00)
select * from dual;

SELECT * FROM CustType_btl;
SELECT * FROM AgentType_btl;
SELECT * FROM RoomType_btl;
SELECT * FROM RateType_btl;
SELECT * FROM Customer_btl
Order by CustID;
SELECT * FROM Agent_btl
Order by AgentID;
SELECT * FROM Reservation_btl
Order by ResID;
SELECT * FROM ResDetail_btl
Order by ResID;


Update Customer_btl
Set CustPhone = 2145551234
Where CustID = 85;

Insert into Customer_btl(CustID,CustFName,CustLName,CustType) Values ( 120,'Amanda','Green', 'I');

Update Reservation_btl
Set CheckoutDate = '8-FEB-2018'
Where ResID = 1001;

Insert into Reservation_btl Values(1011, '1-MAR-2018', '4-MAR-2018', 120, 14);

Update ResDetail_btl
Set RateAmt = 89,
	RateType = 'C'
Where ResID = 1003;

Insert into ResDetail_btl Values(1011,224,'W',119);
Insert into ResDetail_btl Values(1011,225,'W',129);

SELECT * FROM CustType_btl;
SELECT * FROM AgentType_btl;
SELECT * FROM RoomType_btl;
SELECT * FROM RateType_btl;
SELECT * FROM Customer_btl
Order by CustID;
SELECT * FROM Agent_btl
Order by AgentID;
SELECT * FROM Reservation_btl
Order by ResID;
SELECT * FROM ResDetail_btl
Order by ResID;