--DE 2--
ALTER USER BAITHI quota 100M ON USERS;

--1. T?o user t��n BAITHI g?m c�� 4 table USER, CHANNEL, VIDEO, SHARE. T?o kh��a ch��nh, 
--kh��a ngo?i cho c��c table ?��.
CREATE TABLE BAITHI.USER1 (
    USERID CHAR(3),
    USERNAME VARCHAR2(50),
    PASS VARCHAR2(50),
    REGDAY DATE,
    NATIONALITY VARCHAR2(50),
    PRIMARY KEY (USERID)
);

CREATE TABLE BAITHI.VIECHANNEL (
    CHANNELID CHAR(4),
    CNAME VARCHAR2(50),
    SUBSCRIBES NUMBER(5),
    OWNER CHAR(3),
    CREATED DATE,
    PRIMARY KEY (CHANNELID),
    CONSTRAINT FK_CHANNEL_USER FOREIGN KEY (OWNER) REFERENCES BAITHI.USER1(USERID)
);

CREATE TABLE BAITHI.VIDEO (
    VIDEOID CHAR(7),
    TITLE VARCHAR2(50),
    DURATION NUMBER(5),
    AGE NUMBER(4),
    PRIMARY KEY (VIDEOID)
);

CREATE TABLE BAITHI.SHARE1 (
    VIDEOID CHAR(7),
    CHANNELID CHAR(4),
    PRIMARY KEY (VIDEOID, CHANNELID),
    CONSTRAINT FK_SHARE1_VIDEO FOREIGN KEY (VIDEOID) REFERENCES BAITHI.VIDEO(VIDEOID),
    CONSTRAINT FK_SHARE1_CHANNEL FOREIGN KEY (CHANNELID) REFERENCES BAITHI.VIECHANNEL(CHANNELID)
);

--2. Nh?p d? li?u cho 4 table nh? ?? b��i.
INSERT INTO BAITHI.USER1 VALUES('001', 'faptv', '123456abc', TO_DATE('01/01/2014','dd/MM/yyyy'), 'Vietnam');
INSERT INTO BAITHI.USER1 VALUES('002', 'kemxoitv', '@147869iii', TO_DATE('05/06/2015','dd/MM/yyyy'), 'Campuchia');
INSERT INTO BAITHI.USER1 VALUES('003', 'openshare', 'qwertyuiop', TO_DATE('12/05/2009','dd/MM/yyyy'), 'Vietnam');

INSERT INTO BAITHI.VIECHANNEL VALUES('C120', 'FAP TV', 2343, '001', TO_DATE('02/01/2014','dd/MM/yyyy'));
INSERT INTO BAITHI.VIECHANNEL VALUES('C905', 'Kem xoi TV', 1032, '002', TO_DATE('09/07/2015','dd/MM/yyyy'));
INSERT INTO BAITHI.VIECHANNEL VALUES('C357', 'OpenShare Cafe', 5064, '003', TO_DATE('10/12/2010','dd/MM/yyyy'));

INSERT INTO BAITHI.VIDEO VALUES('V100229', 'FAPtv Com Nguoi Tap 41 - Doi Nhap', 469, 18);
INSERT INTO BAITHI.VIDEO VALUES('V211002', 'Kem xoi: Tap 31 - May Kool tinh yeu cua anh', 312, 16);
INSERT INTO BAITHI.VIDEO VALUES('V400002', 'Noi tinh yeu ket thuc - Hoang Tuan', 378, 0);

INSERT INTO BAITHI.SHARE1 VALUES('V100229', 'C905');
INSERT INTO BAITHI.SHARE1 VALUES('V211002', 'C120');
INSERT INTO BAITHI.SHARE1 VALUES('V400002', 'C357');

--3. Hi?n th?c r��ng bu?c to��n v?n sau: Ng��y ??ng k? ???cm?c ??nh l�� ng��y hi?n t?i.
ALTER TABLE BAITHI.USER1 MODIFY REGDAY DEFAULT SYSDATE;

--4. Hi?n th?c r��ng bu?c to��n v?n sau: Ng��y t?o k��nh lu?n l?n h?n ho?c b?ng ng��y ??ng k? c?a 
--ng??i d��ng s? h?u k��nh ?��.

--5. T��m t?t c? c��c video c�� gi?i h?n ?? tu?i t? 16tr? l��n.
SELECT *
FROM BAITHI.VIDEO
WHERE AGE >= 16;

--6. T��m k��nh c�� s? ng??i theo d?i nhi?u nh?t.
SELECT CHANNELID
FROM BAITHI.VIECHANNEL
WHERE SUBSCRIBES = (
                SELECT MAX(SUBSCRIBES)
                FROM BAITHI.VIECHANNEL
        );

--7. V?i m?i video c�� gi?i h?n ?? tu?i l�� 18, th?ng k�� s? k��nh ?? chia s?.
SELECT V.VIDEOID, COUNT (CHANNELID) AS "So kenh"
FROM BAITHI.VIDEO V, BAITHI.SHARE1 S
WHERE V.VIDEOID = S.VIDEOID 
    AND AGE = 18
GROUP BY V.VIDEOID;

--8. T��m video ???c t?t c? c��c k��nh chia s?.
SELECT V.VIDEOID
FROM BAITHI.VIDEO V
WHERE
    NOT EXISTS ( 
        SELECT *
        FROM BAITHI.VIECHANNEL C
        WHERE
            NOT EXISTS (
                SELECT *
                FROM BAITHI.SHARE1 S
                WHERE C.CHANNELID = S.CHANNELID
                    AND S.VIDEOID = V.VIDEOID
            )
    );
    
    