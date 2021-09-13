--UPDATE - SET----          

    /*A�a��daki gibi tedarikciler ad�nda bir tablo olu�turunuz ve vergi_no
    sutununu primary key yap�n�z. Ayr�ca a�a��daki verileri tabloya giriniz.
    
    vergi_no NUMBER(3),
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50),
        
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huawei', '�in Li');
	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
        
    Sonras�nda a�a��daki gibi urunler ad�nda bir ba�ka tablo olu�turunuz ve bu
    tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
    ili�kilendiriniz. Verileri giriniz.
?
    ted_vergino NUMBER(3), 
    urun_id NUMBER(11), 
    urun_isim VARCHAR2(50), 
    musteri_isim VARCHAR2(50),
    
    INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ay�e Can');
    INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan �z');
    INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Y�lmaz');*/
    
    
    CREATE TABLE tedarikciler1 (
    vergi_no NUMBER(3) PRIMARY KEY,
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50)
    );
    
    INSERT INTO tedarikciler1 VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler1 VALUES (102, 'Huawei', '�in Li');
	INSERT INTO tedarikciler1 VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler1 VALUES (104, 'Apple', 'Adam Eve');
    
    create TABLE urunler1(
     ted_vergino NUMBER(3), 
    urun_id NUMBER(11), 
    urun_isim VARCHAR2(50), 
    musteri_isim VARCHAR2(50),
    CONSTRAINT urunler_fk FOREIGN KEY ( ted_vergino) REFERENCES tedarikciler1 (vergi_no)
    );
    
    INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ay�e Can');
    INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan �z');
    INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Y�lmaz');
    
    SELECT * FROM urunler1;
    SELECT * FROM tedarikciler1;
    
    -- SYNTAX
    ----------
    -- UPDATE tablo_ad�
    -- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
    -- WHERE ko�ul;
    
     --ornek1: vergi_no su 101 olan tedarikcinin firma ismini 'LG' olarak guncelleyin
   
    UPDATE tedarikciler1
    SET firma_ismi='Apple'
    WHERE vergi_no=104;
    SELECT * FROM tedarikciler1;
    
    --  ornek2: tedarikciler tablosundaki t�m firma isimlerini Samsung olarak guncelle
    UPDATE tedarikciler1
    SET firma_ismi='Samsung';
    
       
    -- ornek3:  ORNEK3: vergi_no�su 102 olan tedarikcinin ismini 'LENOVO' ve irtibat_ismi�ni 'Ali Veli' olarak g�ncelleyeniz. 
 
    UPDATE tedarikciler1
    SET firma_ismi='LENOVO', irtibat_ismi='Ali Veli'
    WHERE vergi_no=102;
 
    --ornek4:   firma ismi Samsung olan tedarikcinin irtibat_ismini
    --Ayse Yilmaz olarak guncelleyiniz
    
    UPDATE tedarikciler1
    SET irtibat_ismi='Ayse Yilmaz'
    WHERE firma_ismi='Samsung';
        
    --ornek5:   urunler tablosundaki urun_id de�eri 1004'ten b�y�k olanlar�n urun_id
    -- de�erlerini bir artt�r�n�z
 
    UPDATE urunler1
    SET urun_id=urun_id+1
    WHERE urun_id>1004;
    SELECT * FROM urunler1;
 
 
    --ornek6: urunler tablosundaki t�m �r�nlerin urun_id de�erini ted_vergino 
    -- sutun de�eri ile toplayarak g�ncelleyiniz.
 
    UPDATE urunler1
    SET urun_id=urun_id + ted_verg�no;
 
 
    --ornek7: urunler tablosundan Ali Bak�in  aldigi urunun ismini, TEDAR�KC� 
    -- TABLOSUNDA �RT�BAT_�SM� 'Adam Eve' OLAN F�RMANIN �SM� (F�RMA_�SM�) ile 
    --degistiriniz.
 
    UPDATE urunler1
    SET urun_isim =( SELECT firma_ismi FROM tedarikciler1
                      WHERE irtibat_ismi='Adam Eve'
    )
    WHERE musteri_isim='Ali Bak';
 
 
    -- ORNEK8: Laptop satin alan musterilerin ismini, Apple�in irtibat_isim'i ile 
    --degistirin
    
    UPDATE urunler1
    SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler1
                        WHERE firma_ismi = 'Apple')
    WHERE urun_isim = 'Laptop';
    
    
    
    
    
    
    
    
    
    
    