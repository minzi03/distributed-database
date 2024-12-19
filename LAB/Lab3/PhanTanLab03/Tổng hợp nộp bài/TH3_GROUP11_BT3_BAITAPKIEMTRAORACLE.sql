---CN1---
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';
create user cn1 identified by cn1;
grant create session, connect, dba to cn1;
connect cn1/cn1;

CREATE TABLE cn1.PACKSERVICE (
    PackID VARCHAR2(20) PRIMARY KEY,
    Name VARCHAR2(50),
    SpeedDown NUMBER,
    SpeedUp NUMBER,
    PricePerMonth NUMBER,
    hasSSL NUMBER(1),
    maxVolumne NUMBER
);

CREATE TABLE cn1.STATION (
    StationID VARCHAR2(20) PRIMARY KEY,
    City VARCHAR2(50),
    Country VARCHAR2(50)
);

CREATE TABLE cn1.STATIONSERVICE_ADMIN (
    StationID VARCHAR2(20),
    PackId VARCHAR2(20),
    JamRate NUMBER,
    NumberDom NUMBER,
    LastUpdate DATE,
    PRIMARY KEY (StationID, PackId)
);

CREATE TABLE cn1.STATIONSERVICE_STAFF (
    StationID VARCHAR2(20),
    PackId VARCHAR2(20),
    Status VARCHAR2(20),
    PRIMARY KEY (StationID, PackId)
);

CREATE TABLE cn1.PROMOTION (
    PromoID VARCHAR2(20) PRIMARY KEY,
    NameProgram VARCHAR2(50),
    StartDate DATE,
    EndDate DATE,
    Rate NUMBER,
    PackId VARCHAR2(20),
    StationId VARCHAR2(20)
);

--INSERT D? LI?U
INSERT INTO cn1.PACKSERVICE VALUES('Pack1', 'Net 1', 100, 210, 980, 0, 100);
INSERT INTO cn1.PACKSERVICE VALUES('Pack2', 'Net Wide 1', 200, 320, 1190, 0, 1000);
INSERT INTO cn1.PACKSERVICE VALUES('Pack3', 'Net 2', 150, 320, 1080, 1, 120);
INSERT INTO cn1.PACKSERVICE VALUES('Pack4', 'Net Wide 2', 250, 400, 1290, 1, 1200);
INSERT INTO cn1.PACKSERVICE VALUES('Pack5', 'Pre Net', 300, 500, 1560, 1, 2000);

INSERT INTO cn1.STATION (StationID, City, Country) VALUES 
('Station1', 'Jakarta', 'Indonesia');
INSERT INTO cn1.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES 
('Station1', 'Pack1', 0.88, 5685, TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO cn1.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES
('Station1', 'Pack5', 0.21, 752, TO_DATE('15/11/2023', 'DD/MM/YYYY'));
INSERT INTO cn1.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES
('Station1', 'Pack3', 0.66, 1685, TO_DATE('11/11/2023', 'DD/MM/YYYY'));

INSERT INTO cn1.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES 
('Station1', 'Pack1', 'High');
INSERT INTO cn1.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES
('Station1', 'Pack3', 'Medium');
INSERT INTO cn1.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES
('Station1', 'Pack5', 'Low');

INSERT INTO PROMOTION (PromoID, NameProgram, StartDate, EndDate, Rate, PackId, StationId) VALUES 
('Promo01', 'Hallowen', TO_DATE('21/10/2023', 'DD/MM/YYYY'), TO_DATE('1/11/2023', 'DD/MM/YYYY'), 0.2, 'Pack3', 'Station1');
INSERT INTO PROMOTION (PromoID, NameProgram, StartDate, EndDate, Rate, PackId, StationId) VALUES
('Promo03', 'BlackFriday', TO_DATE('16/11/2023', 'DD/MM/YYYY'), TO_DATE('30/12/2023', 'DD/MM/YYYY'), 0.6, 'Pack1', 'Station1');
INSERT INTO PROMOTION (PromoID, NameProgram, StartDate, EndDate, Rate, PackId, StationId) VALUES
('Promo04', 'BlackFriday', TO_DATE('16/11/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY'), 0.4, 'Pack5', 'Station1');

COMMIT;

--Ph?n quy那?n CN1
---TK GeneralAdmin
create user GeneralAdmin identified by ga;
grant create session, connect to GeneralAdmin;
grant select on cn1.PACKSERVICE to GeneralAdmin;
grant select on cn1.STATION to GeneralAdmin;
grant select on cn1.STATIONSERVICE_ADMIN to GeneralAdmin;
grant select on cn1.STATIONSERVICE_STAFF to GeneralAdmin;
grant select on cn1.PROMOTION to GeneralAdmin;

---TK Admin1
create user Admin1 identified by admin1;
grant select on cn1.PACKSERVICE to Admin1;
grant select on cn1.STATION to Admin1;
grant select on cn1.STATIONSERVICE_ADMIN to Admin1;
grant select on cn1.STATIONSERVICE_STAFF to Admin1;
grant select on cn1.PROMOTION to Admin1;

---TK Staff1
create user Staff1 identified by staff1;
grant select on cn1.PACKSERVICE to Staff1;
grant select on cn1.STATIONSERVICE_STAFF to Staff1;

--TK cn2
create user cn2 identified by cn2;
grant connect to cn2;
grant create session to cn2;
grant select on cn1.PACKSERVICE to cn2;
grant select on cn1.STATION to cn2;
grant select on cn1.STATIONSERVICE_ADMIN to cn2;
grant select on cn1.STATIONSERVICE_STAFF to cn2;
grant select on cn1.PROMOTION to cn2;

--CN1 ph?n quy那?n cho ca?c tk cn2
---TK Admin2
create user Admin2 identified by admin2;
grant select on cn1.PACKSERVICE to Admin2;
grant select on cn1.STATIONSERVICE_STAFF to Admin2;
grant select on cn1.PROMOTION to Admin2;

---TK Staff2
create user Staff2 identified by staff2;
grant select on cn1.PACKSERVICE to Staff2;
grant select on cn1.STATIONSERVICE_STAFF to Staff2;


--CREATE DATABASE LINK
create public database link cn2_dblink connect to cn1 identified by cn1 using 'cn2';
create public database link cn2_dblink_ga connect to GeneralAdmin identified by ga using 'cn2';
create public database link cn2_dblink_admin1 connect to Admin1 identified by admin1 using 'cn2';
create public database link cn2_dblink_staff1 connect to Staff1 identified by staff1 using 'cn2';


--Query 1:
SELECT p.PackID, p.Name
FROM cn1.PACKSERVICE p 
WHERE p.PackID NOT IN 
            (SELECT PackID 
            FROM cn1.STATIONSERVICE_STAFF 
            WHERE StationID = 'Station1') 
                AND EXISTS (SELECT 1 
                            FROM cn2.STATIONSERVICE_STAFF@cn2_dblink_staff1 
                            WHERE StationID = 'Station2');

--Query 2: 
SELECT s1.PackId, p1.PromoID, p1.Rate
FROM cn1.STATIONSERVICE_ADMIN s1
    JOIN cn1.PROMOTION p1 ON s1.PackId = p1.PackId 
        AND p1.EndDate > TO_DATE('18/11/2023', 'DD/MM/YYYY')
WHERE (s1.JamRate > 0.5 OR s1.NumberDom > 1000) 
UNION
SELECT s2.PackId, p2.PromoID, p2.Rate
FROM cn2.STATIONSERVICE_ADMIN@cn2_dblink_ga s2
    JOIN cn2.PROMOTION@cn2_dblink_ga p2 ON s2.PackId = p2.PackId 
        AND p2.EndDate > TO_DATE('18/11/2023', 'DD/MM/YYYY')
WHERE (s2.JamRate > 0.5 OR s2.NumberDom > 1000);

--Query 3:
SELECT p1.PackId, COUNT(p1.PromoID) AS PromoCount1
FROM cn1.PROMOTION p1 
WHERE EXTRACT(MONTH FROM p1.StartDate) = 11 
    AND EXTRACT(MONTH FROM p1.EndDate) = 11
GROUP BY p1.PackId
UNION 
SELECT p2.PackId, COUNT(p2.PromoID) AS PromoCount2
FROM cn2.PROMOTION@cn2_dblink_admin1 p2
WHERE EXTRACT(MONTH FROM p2.StartDate) = 11 
    AND EXTRACT(MONTH FROM p2.EndDate) = 11
GROUP BY p2.PackId;

--Query 4:
SELECT s1.PackId, SUM(p1.PricePerMonth * s1.NumberDom * (1 - 0.1)) AS TotalRevenue
FROM cn1.STATIONSERVICE_ADMIN s1
    JOIN cn1.PACKSERVICE p1 ON s1.PackId = p1.PackID
    JOIN cn1.STATION st1 ON s1.StationID = st1.StationID
GROUP BY s1.PackId
UNION
SELECT s2.PackId, SUM(p2.PricePerMonth * s2.NumberDom * (1 - 0.125)) AS TotalRevenue
FROM cn2.STATIONSERVICE_ADMIN@cn2_dblink_ga s2
    JOIN PACKSERVICE@cn2_dblink_ga p2 ON s2.PackId = p2.PackID
    JOIN STATION st2@cn2_dblink_ga ON s2.StationID = st2.StationID
GROUP BY s2.PackId;

--Query 5: 
SELECT st1.StationID
FROM cn1.STATION st1
WHERE st1.StationID IN (
    SELECT StationID
    FROM (
        SELECT s1.StationID
        FROM cn1.STATIONSERVICE_ADMIN s1
        WHERE s1.PackId IN (
            SELECT PackID 
            FROM cn1.PACKSERVICE p1 
            WHERE p1.SpeedDown > 200
        )
        GROUP BY s1.StationID
        ORDER BY COUNT(s1.PackId) DESC
    )
    WHERE ROWNUM <= 1
)
    AND st1.StationID NOT IN (
        SELECT StationID
        FROM cn1.PROMOTION p1
        WHERE p1.Rate < 0.5 
        AND p1.EndDate > TO_DATE('18/11/2023', 'DD/MM/YYYY')
)
UNION
SELECT st2.StationID
FROM cn2.STATION@cn2_dblink_ga st2
WHERE st2.StationID IN (
    SELECT StationID
    FROM (
        SELECT s2.StationID
        FROM cn2.STATIONSERVICE_ADMIN@cn2_dblink_ga s2
        WHERE s2.PackId IN (
            SELECT p2.PackID 
            FROM cn2.PACKSERVICE@cn2_dblink_ga p2 
            WHERE p2.SpeedDown > 200
        )
        GROUP BY s2.StationID
        ORDER BY COUNT(s2.PackId) DESC
    )
    WHERE ROWNUM <= 1
)
    AND st2.StationID NOT IN (
        SELECT StationID
        FROM cn2.PROMOTION@cn2_dblink_ga p2
        WHERE p2.Rate < 0.5 
        AND p2.EndDate > TO_DATE('18/11/2023', 'DD/MM/YYYY')
);







---CN2---
ALTER SESSION SET "_ORACLE_SCRIPT"=true;  
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YY HH24:MI:SS';
create user cn2 identified by cn2;
grant create, connect, dba to cn2;
connect cn2/cn2;

CREATE TABLE cn2.PACKSERVICE (
    PackID VARCHAR2(20) PRIMARY KEY,
    Name VARCHAR2(50),
    SpeedDown NUMBER,
    SpeedUp NUMBER,
    PricePerMonth NUMBER,
    hasSSL NUMBER(1),
    maxVolumne NUMBER
);

CREATE TABLE cn2.STATION (
    StationID VARCHAR2(20) PRIMARY KEY,
    City VARCHAR2(50),
    Country VARCHAR2(50)
);


CREATE TABLE cn2.STATIONSERVICE_ADMIN (
    StationID VARCHAR2(20),
    PackId VARCHAR2(20),
    JamRate NUMBER,
    NumberDom NUMBER,
    LastUpdate DATE,
    PRIMARY KEY (StationID, PackId)
);

CREATE TABLE cn2.STATIONSERVICE_STAFF (
    StationID VARCHAR2(20),
    PackId VARCHAR2(20),
    Status VARCHAR2(20),
    PRIMARY KEY (StationID, PackId)
);

CREATE TABLE cn2.PROMOTION (
    PromoID VARCHAR2(20) PRIMARY KEY,
    NameProgram VARCHAR2(50),
    StartDate DATE,
    EndDate DATE,
    Rate NUMBER,
    PackId VARCHAR2(20),
    StationId VARCHAR2(20)
);

INSERT INTO cn2.PACKSERVICE VALUES('Pack1', 'Net 1', 100, 210, 980, 0, 100);
INSERT INTO cn2.PACKSERVICE VALUES('Pack2', 'Net Wide 1', 200, 320, 1190, 0, 1000);
INSERT INTO cn2.PACKSERVICE VALUES('Pack3', 'Net 2', 150, 320, 1080, 1, 120);
INSERT INTO cn2.PACKSERVICE VALUES('Pack4', 'Net Wide 2', 250, 400, 1290, 1, 1200);
INSERT INTO cn2.PACKSERVICE VALUES('Pack5', 'Pre Net', 300, 500, 1560, 1, 2000);

INSERT INTO cn2.STATION (StationID, City, Country) VALUES ('Station2', 'Hue', 'Viet Nam');


INSERT INTO cn2.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES ('Station2', 'Pack1', 0.75, 2211, TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO cn2.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES ('Station2', 'Pack5', 0.12, 678, TO_DATE('18/11/2023', 'DD/MM/YYYY'));
INSERT INTO cn2.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES ('Station2', 'Pack4', 0.45, 2155, TO_DATE('11/11/2023', 'DD/MM/YYYY'));
INSERT INTO cn2.STATIONSERVICE_ADMIN (StationID, PackId, JamRate, NumberDom, LastUpdate) VALUES ('Station2', 'Pack2', 0.86, 2058, TO_DATE('17/11/2023', 'DD/MM/YYYY'));

INSERT INTO cn2.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES ('Station2', 'Pack2', 'High');
INSERT INTO cn2.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES ('Station2', 'Pack1', 'High');
INSERT INTO cn2.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES ('Station2', 'Pack5', 'Low');
INSERT INTO cn2.STATIONSERVICE_STAFF (StationID, PackId, Status) VALUES ('Station2', 'Pack4', 'Medium');

INSERT INTO cn2.PROMOTION (PromoID, NameProgram, StartDate, EndDate, Rate, PackId, StationId) VALUES ('Promo02', 'Hallowen', TO_DATE('20/10/2023', 'DD/MM/YYYY'), TO_DATE('1/11/2023','DD/MM/YYYY'), 0.2, 'Pack3', 'Station2');
INSERT INTO cn2.PROMOTION (PromoID, NameProgram, StartDate, EndDate, Rate, PackId, StationId) VALUES ('Promo05', 'BlackFriday', TO_DATE('16/11/2021', 'DD/MM/YYYY'), TO_DATE('20/11/2023', 'DD/MM/YYYY'), 0.6, 'Pack5', 'Station2');
INSERT INTO cn2.PROMOTION (PromoID, NameProgram, StartDate, EndDate, Rate, PackId, StationId) VALUES ('Promo06', 'BlackFriday', TO_DATE('16/11/2021', 'DD/MM/YYYY'), TO_DATE('24/11/2023', 'DD/MM/YYYY'), 0.5, 'Pack2', 'Station2');

COMMIT;

--Ph?n quy那?n CN2
---TK Admin2
create user Admin2 identified by admin2;
grant select on cn2.PACKSERVICE to Admin2;
grant select on cn2.STATION to Admin2;
grant select on cn2.STATIONSERVICE_ADMIN to Admin2;
grant select on cn2.STATIONSERVICE_STAFF to Admin2;
grant select on cn2.PROMOTION to Admin2;

---TK Staff2
create user Staff2 identified by staff2;
grant select on cn2.PACKSERVICE to Staff2;
grant select on cn2.STATIONSERVICE_STAFF to Staff2;

--TK cn1
create user cn1 identified by cn1;
grant connect to cn1;
grant create session to cn1;
grant select on cn2.PACKSERVICE to cn1;
grant select on cn2.STATION to cn1;
grant select on cn2.STATIONSERVICE_ADMIN to cn1;
grant select on cn2.STATIONSERVICE_STAFF to cn1;
grant select on cn2.PROMOTION to cn1;

--TK cn2 ph?n quy那?n cho ca?c tk ?? CN1
---TK GeneralAdmin
create user GeneralAdmin identified by ga;
grant create session, connect to GeneralAdmin;
grant select on cn2.PACKSERVICE to GeneralAdmin;
grant select on cn2.STATION to GeneralAdmin;
grant select on cn2.STATIONSERVICE_ADMIN to GeneralAdmin;
grant select on cn2.STATIONSERVICE_STAFF to GeneralAdmin;
grant select on cn2.PROMOTION to GeneralAdmin;

---TK Admin1
create user Admin1 identified by admin1;
grant select on cn2.PACKSERVICE to Admin1;
grant select on cn2.STATIONSERVICE_STAFF to Admin1;
grant select on cn2.PROMOTION to Admin1;

---TK Staff1
create user Staff1 identified by staff1;
grant select on cn2.PACKSERVICE to Staff1;
grant select on cn2.STATIONSERVICE_STAFF to Staff1;


--DATABASE_LINK
create public database link cn1_dblink connect to cn21 identified by cn2 using 'cn1';
create public database link cn1_dblink_ga connect to GeneralAdmin identified by ga using 'cn1';
create public database link cn1_dblink_admin2 connect to Admin2 identified by admin2 using 'cn1';
create public database link cn1_dblink_staff2 connect to Staff2 identified by staff2 using 'cn1';

--Query  6:
SELECT DISTINCT P.PackId, AVG(A.Rate) AS AvgRate, MIN(A.EndDate - A.StartDate) AS MinDuration
FROM (
    SELECT * 
    FROM cn1.PROMOTION@cn1_dblink_admin2
    UNION ALL
    SELECT * 
    FROM cn2.PROMOTION
) A
JOIN cn2.PACKSERVICE P ON A.PackId = P.PackId
WHERE P.maxVolumne > 300
GROUP BY P.PackId;