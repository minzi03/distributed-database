**CN2
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


Phân quyền CN2

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

TK cn2 phân quyền cho các tk ở CN1
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

Query  6:
SELECT DISTINCT P.PackId, AVG(A.Rate) AS AvgRate, MIN(A.EndDate - A.StartDate) AS MinDuration
FROM (
    SELECT * FROM cn1.PROMOTION@cn1_dblink_admin2
    UNION ALL
    SELECT * FROM cn2.PROMOTION
) A
JOIN cn2.PACKSERVICE P ON A.PackId = P.PackId
WHERE P.maxVolumne > 300
GROUP BY P.PackId;