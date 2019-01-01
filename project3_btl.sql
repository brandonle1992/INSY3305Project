spool "C:\project2\Project3_btl.txt"
set echo ON

--Brandon Le
--Project 3

COLUMN RoomType FORMAT A10
COLUMN AgentType FORMAT A10
COLUMN CustType FORMAT A10
COLUMN RateType FORMAT A10
COLUMN CheckinDate FORMAT A15
COLUMN CheckoutDate FORMAT A15
COLUMN RmType FORMAT A10
COLUMN TotalCharge FORMAT A11

SET LINESIZE 100

--1
UPDATE ResDetail_btl
	SET RoomNum = 321,
		RateType = 'C',
		RateAmt = 110
	WHERE ResID = 1010;

--2
UPDATE Customer_btl
	SET CustType = 'C'
	WHERE CustID = 120;

--3
INSERT INTO Room_btl VALUES(301, 'D');
INSERT INTO Room_btl VALUES(303, 'D');
INSERT INTO Room_btl VALUES(304, 'KS');

--4
INSERT INTO ResDetail_btl VALUES(1005, 303, 'W', 119);
INSERT INTO ResDetail_btl VALUES(1005, 304, 'S', 149);

--5
INSERT INTO Customer_btl VALUES((SELECT MAX(CustID)
	FROM Customer_btl) + 1, 'Susan', 'White', 2145552020, 'C', NULL);

COMMIT;

--6
SELECT CustID AS "CustID",CustFName AS "CustFName",CustLName AS "CustLName" FROM Customer_btl
	WHERE CustPhone is NULL
	ORDER BY CustID;

--7 AvgRate as the column heading
SELECT TO_CHAR(AVG(RateAmt), '$999.99') AS "AvgRate" FROM ResDetail_btl;

--8 RoomResCount as the column heading.
SELECT COUNT(DISTINCT RoomNum) AS "RoomResCount"
	FROM ResDetail_btl;

--9 column headings:  RoomType, RoomCount
SELECT RoomType AS "RoomType", COUNT(RoomType) AS "RoomCount"
	FROM Room_btl
	GROUP BY RoomType;

--10 column headings:  ResNum, CheckIn, CheckOut, RoomCount
SELECT Res.ResID AS "ResNum", CheckinDate AS "CheckIn", CheckoutDate AS "CheckOut", COUNT(RoomNum) AS "RoomCount"
	FROM Reservation_btl Res
	LEFT JOIN ResDetail_btl ResD ON Res.ResID = ResD.ResID
	GROUP BY Res.ResID, CheckinDate, CheckoutDate;

--11a column headings:  CustomerID, CustomerName, ResCount
SELECT C.CustID AS "CustomerID", CustFName || ' ' || CustLName AS "CustomerName", COUNT(ResID) AS "ResCount"
	FROM Customer_btl C
	LEFT JOIN Reservation_btl R ON C.CustID = R.CustID
	GROUP BY C.CUSTID, CustFName, CustLName
	ORDER BY "ResCount" DESC, C.CustID;

--11b column headings:  ResNum, RmNum, RateType, RateAmt
SELECT ResID AS "ResNum", RoomNum AS "RmNum", RateType AS "RateType", RateAmt AS "RateAmt"
	FROM ResDetail_btl
	ORDER BY ResID, RoomNum;

--12 column headings:  RateType, Description, ResCount
SELECT RT.RateType AS "RateType", RateTypeDesc AS "Description", COUNT(R.RateType) AS "ResCount"
	FROM RateType_btl RT, ResDetail_btl R
	WHERE R.RateType = RT.RateType
	GROUP BY RT.RateType, RateTypeDesc
	ORDER BY "ResCount" DESC;

--13 column headings:  Customer_ID, First_Name, Last_Name, Phone
SELECT CustID AS "Customer_ID", CustFName AS "First_Name", CustLName AS "Last_Name", '(' || SUBSTR(CustPhone, 1,3) || ')-' || SUBSTR(CustPhone, 4,3) || '-' || SUBSTR(CustPhone,7,4) AS "Phone"
	FROM Customer_btl
	ORDER BY CustID;

--14 column headings:  ResNum, RmNum, RmType, RmDesc, RateType, RateDesc, RateAmt
SELECT RD.ResID AS "ResNum", RD.RoomNum AS "RmNum", R.RoomType AS "RmType", RoomTypeDesc AS "RmDesc", RD.RateType AS "RateType", RateTypeDesc AS "RateDesc", TO_CHAR(RateAmt, '$999.99') AS "RateAmt"
	FROM ResDetail_btl RD, Room_btl R, RoomType_btl RT, RateType_btl RTY
	WHERE RD.RateType = RTY.RateType AND
		  RD.RoomNum = R.RoomNum AND
		  R.RoomType = RT.RoomType AND
		  (ResID, RateAmt) IN
			(SELECT ResID, MIN(RateAmt)
			FROM ResDetail_btl
			GROUP BY ResID )
	ORDER BY "RateAmt" DESC;


--15
SELECT R.RoomNum, RT.RoomType, RoomTypeDesc, RateType, RateAmt
	FROM ResDetail_btl RD, Room_btl R, RoomType_btl RT
	WHERE RD.RoomNum = R.RoomNum AND
			R.RoomType = RT.RoomType
	ORDER BY RoomNum,RateAmt;

--16 column headings:  CustType, Description, Count
SELECT C.CustType AS "CustType", CustDesc AS "Description", COUNT(C.CustType) AS "Count"
	FROM Customer_btl C, CustType_btl CT
	WHERE C.CustType = CT.CustType
	GROUP BY C.CustType, CustDesc
	ORDER BY "Count" DESC;

--17
SELECT ResID AS "ResNum", R.RoomNum, R.RoomType, RoomTypeDesc, TO_CHAR(RateAmt, '$999.99') AS "RateAmt"
	FROM ResDetail_btl RD, Room_btl R, RoomType_btl RT
	WHERE RD.RoomNum = R.RoomNum AND
		  R.RoomType = RT.RoomType AND
		  RateAmt <= 119
	ORDER BY "RateAmt" DESC, RoomNum;

--18
SELECT R.ResID AS "ResNum", TO_CHAR(CheckinDate, 'mm-dd-yyyy') AS CheckinDate, TO_CHAR(CheckoutDate, 'mm-dd-yyyy') AS CheckoutDate, C.CustID, C.CustFName, C.CustLName, COUNT(RD.RoomNum) AS "Count"
	FROM Reservation_btl R, Customer_btl C, ResDetail_btl RD
	WHERE RD.ResID = R.ResID AND
		  C.CustID = R.CustID
	GROUP BY R.ResID, CheckinDate, CheckoutDate, C.CustID, C.CustFName, C.CustLName
	ORDER BY R.ResID;

--19.
SELECT ResID AS "ResNum", R.RoomNum AS "RmNum", RoomTypeDesc AS "RoomType",  RateTypeDesc AS "RateType", TO_CHAR(RateAmt, '$999.99') AS "Rate"
	FROM ResDetail_btl RD, Room_btl R, RoomType_btl RT, RateType_btl RA
	WHERE RT.RoomType = R.RoomType AND
	  	  R.RoomNum = RD.RoomNum AND
	      RD.RateType = RA.RateType AND
	  	  ResID = 1005 AND
	  		RateAmt in
	  			(SELECT MAX(RateAmt) FROM ResDetail_btl);
--19 column headings:  ResNum, RmNum, RoomType, RateType, Rate
SELECT ResID AS "ResNum", R.RoomNum AS "RmNum", RoomType AS "RoomType", RateType AS "RateType", TO_CHAR(RateAmt, '$999.99') AS "Rate"
	FROM ResDetail_btl RD, Room_btl R
	WHERE R.RoomNum = RD.RoomNum AND
		  	ResID = 1005 AND
		  	RateAmt in
		  		(SELECT MAX(RateAmt) FROM ResDetail_btl);


--20 column headings:  AgentType, Desc, Count
SELECT A.AgentType AS "AgentType", AgentDesc AS "Desc", Count(A.AgentType) AS "Count"
	FROM Agent_btl A, AgentType_btl ATT
	WHERE A.AgentType = ATT.AgentType
	GROUP BY A.AgentType, AgentDesc
	ORDER BY "Count";


--21
SELECT ResID AS "ResNum", RD.RoomNum, RoomTypeDesc, RateTypeDesc, RateAmt
	FROM ResDetail_btl RD, Room_btl R, RateType_btl RT, RoomType_btl RR
	WHERE RD.RoomNum = R.RoomNum AND
		  R.RoomType = RR.RoomType AND
		  RD.RateType = RT.RateType AND
		  RateAmt > (SELECT AVG(RateAmt) FROM ResDetail_btl)
	ORDER BY RoomNum;

--22 column headings:  RmNum, RmType, RateType, RateAmt
SELECT DISTINCT(RD.RoomNum) AS "RmNum", R.RoomType AS "RmType", RD.RateType AS "RateType", RateAmt AS "RateAmt"
	FROM Room_btl R, ResDetail_btl RD, RoomType_btl RT, RateType_btl RA
	WHERE RD.RoomNum = R.RoomNum AND
		  R.RoomType = RT.RoomType AND
		  RD.RateType = RA.RateType AND
		  RateAmt > 115
	ORDER BY RateAmt DESC;

--23
SELECT R.RoomNum, RoomType AS "RoomType", COUNT(RD.RoomNum) AS "Count"
	FROM Room_btl R
	LEFT JOIN ResDetail_btl RD ON R.RoomNum = RD.RoomNum
	GROUP BY R.RoomNum, RoomType
	ORDER BY "Count";

--24 column headings:  CustID, FirstName, LastName, Phone.
SELECT CustID AS "CustID", CustFName "FirstName", CustLName AS "LastName", '(' || SUBSTR(CustPhone, 1,3) || ')-' || SUBSTR(CustPhone, 4,3) || '-' || SUBSTR(CustPhone,7,4) AS "Phone"
	FROM Customer_btl
	WHERE LoyaltyID IS NOT NULL;

--25 column headings:  Room, RoomType, RateType, Amt
SELECT ResID, R.RoomNum AS "Room", R.RoomType AS "RoomType", RD.RateType AS "RateType", TO_CHAR(RateAmt, '$999.99') AS "Amt"
	FROM ResDetail_btl RD, Room_btl R, RoomType_btl RT, RateType_btl RA
	WHERE RT.RoomType = R.RoomType AND
		  R.RoomNum = RD.RoomNum AND
		  RA.RateType = RD.RateType AND
		  ResID = 1005 AND
		  RateAmt in
		  (SELECT MAX(RateAmt) FROM ResDetail_btl);

--26
SELECT ResID AS "ResNum", CheckinDate, CheckoutDate, R.CustID, CustLName, R.AgentID, AgentLName
	FROM Reservation_btl R, Customer_btl C, Agent_btl A
	WHERE R.CustID = C.CustID AND
		  R.AgentID = A.AgentID AND
		  CheckinDate <= '28-FEB-2018'
	ORDER BY CheckinDate, ResID;

--27
SELECT R.RoomNum, R.RoomType, RoomTypeDesc, RateAmt
	FROM Room_btl R, RateType_btl RT, RoomType_btl RR, ResDetail_btl RD
	WHERE RD.RoomNum = R.RoomNum AND
		  R.RoomType = RR.RoomType AND
		  RD.RateType = RT.RateType AND
		  RateAmt > (SELECT AVG(RateAmt) FROM ResDetail_btl)
	ORDER BY RateAmt DESC, R.RoomNum;

--28 LoyaltyCount as the column heading
SELECT COUNT(LoyaltyID) AS "LoyaltyCount" FROM Customer_btl;

--29 column headings:  AgentID, Agent, ResCount
SELECT A.AgentID AS "AgentID", AgentFName || ' ' || AgentLName AS "Agent", COUNT(R.AgentID) AS "ResCount"
	FROM Agent_btl A
	RIGHT JOIN Reservation_btl R ON R.AgentID = A.AgentID
	GROUP BY A.AgentID, AgentFName, AgentLName
	ORDER BY "ResCount" DESC;

--30 column headings:  AgentID, FirstName, LastName, ResCount
SELECT A.AgentID AS "AgentID", AgentFName AS "FirstName", AgentLName AS "LastName", COUNT(R.AgentID) AS "ResCount"
	FROM Agent_btl A
	RIGHT JOIN Reservation_btl R ON R.AgentID = A.AgentID
	HAVING COUNT(R.AgentID) > 1
	GROUP BY A.AgentID, AgentFName, AgentLName
	ORDER BY "ResCount" DESC, A.AgentID;

--31 column headings:  Customer_ID, First_Name, Last_Name
SELECT CustID AS "Customer_ID", CustFName AS "First_Name", CustLName AS "Last_Name"
	FROM Customer_btl
	WHERE CustLName LIKE 'W%' OR CustFName LIKE 'W%'
	ORDER BY CustLName;

--32 column headings:  CustID, FirstName, LastName
SELECT CustID AS "CustID", CustFName AS "FirstName", CustLName AS "LastName"
	FROM Customer_btl
	WHERE CustID NOT IN (SELECT CustID FROM Reservation_btl);

--33 column headings:  ResNum, RoomNum, TotalCharge
SELECT R.ResID AS "ResNum", RoomNum AS "RoomNum", TO_CHAR((CheckoutDate - CheckinDate) * RateAmt, '$999.99') AS "TotalCharge"
	FROM Reservation_btl R, ResDetail_btl RD
	WHERE R.ResID = RD.ResID AND
		  R.ResID = 1005;

set echo OFF
spool off
