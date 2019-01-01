spool C:\project2\project2_btl.txt;
SET echo on

--Brandon Le
--Project 2

--Drop table if they exists
DROP TABLE ResDetail_btl;
DROP TABLE Reservation_btl;
DROP TABLE Agent_btl;
DROP TABLE Customer_btl;
DROP TABLE Room_btl;
DROP TABLE CustType_btl;
DROP TABLE AgentType_btl;
DROP TABLE RateType_btl;
DROP TABLE RoomType_btl;

--PART 1 Creating tables
CREATE TABLE CustType_btl(
	CustType 		VARCHAR(1) not null, 
	CustDesc 	VARCHAR(20) not null,
	PRIMARY KEY(CustType)
	);
	
CREATE TABLE AgentType_btl(
	AgentType	VARCHAR(2) not null,
	AgentDesc	VARCHAR(20) not null,
	PRIMARY KEY(AgentType)
	);
	
CREATE TABLE RateType_btl(
	RateType	VARCHAR(1) not null,
	RateTypeDesc VARCHAR(25) not null,
	PRIMARY KEY(RateType)
	);
	
CREATE TABLE RoomType_btl(
	RoomType		VARCHAR(2) not null,
	RoomTypeDesc	VARCHAR(25) not null,
	PRIMARY KEY(RoomType)
	);


CREATE TABLE Room_btl(
	RoomNum		NUMBER(3) not null,
	RoomType	VARCHAR(2) not null,
	PRIMARY KEY(RoomNum),
	FOREIGN KEY(RoomType)
		REFERENCES RoomType_btl(RoomType)
	);
	
CREATE TABLE Agent_btl(
	AgentID		NUMBER(3) not null,
	AgentFName	VARCHAR(10) not null,
	AgentLName	VARCHAR(15) not null,
	AgentType	VARCHAR(2) not null,
	PRIMARY KEY(AgentID),
	FOREIGN KEY (AgentType)
		REFERENCES AgentType_btl(AgentType)
	);

CREATE TABLE Customer_btl(
	CustID 		NUMBER(3) not null, 
	CustFName 	VARCHAR(10) not null, 
	CustLName 	VARCHAR(15) not null, 
	CustPhone 	CHAR(10), 
	CustType 	VARCHAR(1) not null, 
	LoyaltyID 	NUMBER(3),
	PRIMARY KEY(CustID),
	FOREIGN KEY (CustType) 
		REFERENCES CustType_btl(CustType)
	);

CREATE TABLE Reservation_btl(
	ResID			NUMBER(4) not null,
	CheckinDate		DATE,
	CheckoutDate	DATE,
	CustID			NUMBER(3) not null,
	AgentID			NUMBER(3) not null,
	PRIMARY KEY (ResID),
	FOREIGN KEY (CustID)
		References Customer_btl(CustID),
	FOREIGN KEY (AgentID)
		References Agent_btl(AgentID)
	);
	
CREATE TABLE ResDetail_btl(
	ResID			NUMBER(4) not null,
	RoomNum			NUMBER(3) not null,
	RateType		VARCHAR(1) not null,
	RateAmt			NUMBER(5,2),
	CONSTRAINT ResDetailPK 
		PRIMARY KEY (ResID,RoomNum),
	FOREIGN KEY (RoomNum) 
		References Room_btl(RoomNum),
	FOREIGN KEY (ResID)
		REFERENCES Reservation_btl(ResID),
	FOREIGN KEY (RateType)
		REFERENCES RateType_btl(RateType)
	);
COMMIT;

--PART 1 Describing Table
DESCRIBE CustType_btl;
DESCRIBE Customer_btl;
DESCRIBE Agent_btl;
DESCRIBE AgentType_btl;
DESCRIBE RateType_btl;
DESCRIBE Room_btl;
DESCRIBE RoomType_btl;
DESCRIBE Reservation_btl;
DESCRIBE ResDetail_btl;

COMMIT;


--PART 2 Inserting data
INSERT INTO CustType_btl VALUES ('C','Corporate');
INSERT INTO CustType_btl VALUES ('I','Individual');


INSERT INTO AgentType_btl VALUES ('FD','Front Desk');
INSERT INTO AgentType_btl VALUES ('RC','Res Center');
INSERT INTO AgentType_btl VALUES ('T','Telephone');

INSERT INTO RoomType_btl VALUES ('K','King Bed');
INSERT INTO RoomType_btl VALUES ('D','2 Double Beds');
INSERT INTO RoomType_btl VALUES ('KS','King Suite');

INSERT INTO RateType_btl Values ('C','Corporate');
INSERT INTO RateType_btl Values ('S','Standard');
INSERT INTO RateType_btl Values ('W','Weekend');

INSERT INTO Customer_btl Values (85, 'Wesley', 'Tanner', '8175551193', 'C', 323);
INSERT INTO Customer_btl Values (100, 'Breanna', 'Rhodes', '2145559191', 'I', 129);
INSERT INTO Customer_btl Values (15, 'Jeff', 'Miner', Null,'I', Null);
INSERT INTO Customer_btl Values (77, 'Kim', 'Jackson', '8175554911', 'C', 210);
INSERT INTO Customer_btl Values (119, 'Mary', 'Vaughn', '8175552334', 'I', 118);
INSERT INTO Customer_btl Values (97, 'Chris', 'Mancha', '4695553440', 'I', 153);
INSERT INTO Customer_btl Values (28, 'Renee', 'Walker', '2145551193', 'I', 135);
INSERT INTO Customer_btl Values (23, 'ShelBY', 'Day',Null,'I', Null);

INSERT INTO Agent_btl Values (20,'Megan','Smith','FD');
INSERT INTO Agent_btl Values (5,'Janice','May','T');
INSERT INTO Agent_btl Values (14,'John','King','RC');
INSERT INTO Agent_btl Values (28,'Ray','Schultz','T');

INSERT INTO Room_btl Values (224, 'K');
INSERT INTO Room_btl Values (225, 'D');
INSERT INTO Room_btl Values (305, 'D');
INSERT INTO Room_btl Values (409, 'D');
INSERT INTO Room_btl Values (320, 'D');
INSERT INTO Room_btl Values (302, 'K');
INSERT INTO Room_btl Values (501, 'KS');
INSERT INTO Room_btl Values (502, 'KS');
INSERT INTO Room_btl Values (321, 'K');

INSERT INTO Reservation_btl Values(1001, '5-FEB-2018', '7-FEB-2018',85,20);
INSERT INTO Reservation_btl Values(1002, '1-FEB-2018', '3-FEB-2018',100,5);
INSERT INTO Reservation_btl Values(1003, '9-FEB-2018', '11-FEB-2018',15,14);
INSERT INTO Reservation_btl Values(1004, '22-FEB-2018', '23-FEB-2018',77,28);
INSERT INTO Reservation_btl Values(1005, '15-FEB-2018', '18-FEB-2018',119,20);
INSERT INTO Reservation_btl Values(1006, '24-FEB-2018', '26-FEB-2018',97,14);
INSERT INTO Reservation_btl Values(1007, '20-FEB-2018', '25-FEB-2018',100,20);
INSERT INTO Reservation_btl Values(1008, '23-MAR-2018', '25-MAR-2018',85,5);
INSERT INTO Reservation_btl Values(1009, '1-MAR-2018', '4-MAR-2018',28,14);
INSERT INTO Reservation_btl Values(1010, '1-MAR-2018', '3-MAR-2018',23,28);

INSERT INTO ResDetail_btl Values(1001, 224, 'C', 120.00);
INSERT INTO ResDetail_btl Values(1001, 225, 'C', 125.00);
INSERT INTO ResDetail_btl Values(1002, 305, 'S', 149.00);
INSERT INTO ResDetail_btl Values(1003, 409, 'W', 99.00);
INSERT INTO ResDetail_btl Values(1004, 320, 'C', 110.00);
INSERT INTO ResDetail_btl Values(1005, 302, 'S', 139.00);
INSERT INTO ResDetail_btl Values(1006, 501, 'W', 119.00);
INSERT INTO ResDetail_btl Values(1006, 502, 'W', 119.00);
INSERT INTO ResDetail_btl Values(1007, 302, 'S', 139.00);
INSERT INTO ResDetail_btl Values(1008, 320, 'W', 89.00);
INSERT INTO ResDetail_btl Values(1008, 321, 'W', 99.00);
INSERT INTO ResDetail_btl Values(1009, 502, 'W', 129.00);
INSERT INTO ResDetail_btl Values(1010, 225, 'W', 129.00);

COMMIT;

--PART 2 Displaying using select
SELECT * FROM CustType_btl;
SELECT * FROM AgentType_btl;
SELECT * FROM RoomType_btl;
SELECT * FROM RateType_btl;
SELECT * FROM Customer_btl
ORDER BY CustID;
SELECT * FROM Agent_btl
ORDER BY AgentID;
SELECT * FROM Reservation_btl
ORDER BY ResID;
SELECT * FROM ResDetail_btl
ORDER BY ResID;

COMMIT;

--PART 3 Updating/Inserting new information to table
UPDATE Customer_btl
SET CustPhone = 2145551234
WHERE CustID = 85;

INSERT INTO Customer_btl Values ( 120,'Amanda','Green',Null, 'I', Null);

UPDATE Reservation_btl
SET CheckoutDate = '8-FEB-2018'
WHERE ResID = 1001;

INSERT INTO Reservation_btl Values(1011, '1-MAR-2018', '4-MAR-2018', 120, 14);

UPDATE ResDetail_btl
SET RateAmt = 89,
	RateType = 'C'
WHERE ResID = 1003;

INSERT INTO ResDetail_btl Values(1011,224,'W',119);
INSERT INTO ResDetail_btl Values(1011,225,'W',129);

--PART 4 Displaying data
SELECT * FROM CustType_btl;
SELECT * FROM AgentType_btl;
SELECT * FROM RoomType_btl;
SELECT * FROM RateType_btl;
SELECT * FROM Customer_btl
ORDER BY CustID;
SELECT * FROM Agent_btl
ORDER BY AgentID;
SELECT * FROM Reservation_btl
ORDER BY ResID;
SELECT * FROM ResDetail_btl
ORDER BY ResID;

COMMIT;

SET echo off
spool off;