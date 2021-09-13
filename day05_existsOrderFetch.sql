CREATE TABLE mart_satislar
    (
        urun_id number(10),
        musteri_isim varchar2(50), 
        urun_isim varchar2(50)
    );
    
    CREATE TABLE nisan_satislar 
    (
        urun_id number(10),
        musteri_isim varchar2(50), 
        urun_isim varchar2(50)
    );
    
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (20, 'John', 'Toyota');
    INSERT INTO mart_satislar VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart_satislar VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart_satislar VALUES (10, 'Adem', 'Honda');
    INSERT INTO mart_satislar VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart_satislar VALUES (20, 'Eddie', 'Toyota');
    
    
    INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');
    
    
    
    select * from mart_sat�slar;
    select * from nisan_satislar;
    
    
    --   ORNEK1: MART VE N�SAN aylar�nda ayn� URUN_ID ile sat�lan �r�nlerin
    -- URUN_ID�lerini listeleyen ve ayn� zamanda bu �r�nleri MART ay�nda alan
    -- MUSTERI_ISIM 'lerini listeleyen bir sorgu yaz�n�z. 
   
    SELECT urun_id, musteri_isim from mart_sat�slar
    WHERE EXISTS(SELECT urun_id from nisan_satislar
                    where mart_satislar.urun_id=nisan_satislar.urun_id);
 
    -- select urun_id, musteri_isim from mart_sat�slar
    -- WHERE urun_id IN(SELECT urun_id from nisan_satislar
    --                    where mart_satislar.urun_id=nisan_satislar.urun_id);
 
 
 
 
    -- ORNEK2: Her iki ayda da sat�lan �r�nlerin URUN_ISIM'lerini ve bu �r�nleri
    -- N�SAN ay�nda sat�n alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaz�n�z. 
 
    SELECT urun_isim, musteri_isim FROM nisan_satislar n
    WHERE EXISTS(SELECT urun_isim from mart_satislar m
               where m.urun_isim=n.urun_isim);
 
 
 -- ORNEK3: Her iki ayda da ortak olarak sat�lmayan �r�nlerin URUN_ISIM'lerini 
 -- ve bu �r�nleri N�SAN ay�nda sat�n alan MUSTERI_ISIM'lerini listeleyiniz. 
 
 
 SELECT urun_isim, musteri_isim FROM nisan_satislar n
 
 WHERE NOT EXISTS (SELECT urun_isim FROM mart_sat�slar m
                WHERE m.urun_isim=n.urun_isim);
                
 /* ===================== IS NULL, IS NOT NULL, COALESCE(kulesk=birle�mek) ========================
    
    IS NULL, ve IS NOT NULL BOOLEAN operat�rleridir. Bir ifadenin NULL olup 
    olmad���n� kontrol ederler.  
    
      * COALESCE (birle�mek) ise bir fonksiyondur ve i�erisindeki parameterelerden NULL olmayan
    ilk ifadeyi d�nd�r�r. E�er ald��� t�m ifadeler NULL ise NULL d�nd�r�r�r.
   *** select COALESCE (s�tun1,s�tun2,...) from tabloAd�;
    
    Birden fazla null ko�uluna g�re de�er atamak istiyorsak COALESCE deyimini kullanabiliriz.
    COALESCE asl�nda case mant���nda �al���r ve birden fazla kolon aras�nda kontrol sa�layabilirsiniz.
    Bir ko�ul ger�ekle�mez ise di�erine bakar, oda ger�ekle�mez ise bir sonraki.
    Deyim bitene kadar
   -- CASE  
   WHEN (expression1 IS NOT NULL) THEN expression1  
   WHEN (expression2 IS NOT NULL) THEN expression2  
   ...  
   ELSE expressionN  
   END  --gibi*/   
   
   
   
   
   
   
   
--==============================================================================*/

    CREATE TABLE insanlar 
    (
        ssn CHAR(9),
        isim VARCHAR2(50), 
        adres VARCHAR2(50) 
    );

    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (ssn) VALUES('999111222');
         select * from insanlar; 
         
         
         
 --  ORNEK1: isim 'i NULL olanlar� sorgulay�n�z.  
 
 SELECT * FROM insanlar
 WHERE isim IS NULL;
 
 
-- ORNEK2: isim 'i NULL olmayanlar� sorgulay�n�z.

select * from insanlar
where isim IS NOT NULL;

--ORNEK3: isim 'i NULL olan ki�ilerin isim'ine NO NAME yaz�s� atay�n�z. 

UPDATE insanlar
SET isim='NO NAME'
WHERE isim IS NULL; 


SELECT COALESCE (isim,ssn, adres) from insanlar; --Ali can
                                                 --veli cem
                                                 --mine bulut
                                                 --456....
                                                 --567...
                                                 --sakarya
                                                 --999....
                                                 
  --ornek4  tablodaki butun null verileri g�zel birer c�mlecikle de�i�tirin
  
  UPDATE insanlar
  SET isim=COALESCE (isim,'henuz isim girilmedi'),
    adres=COALESCE(adres, 'henuz adres girilmedi'),
    ssn= COALESCE (ssn, 'No SSN');
    
    select * from insanlar;
    
    
 /*   ================================ ORDER BY  ===================================
   ORDER BY c�mleci�i bir SORGU deyimi i�erisinde belli bir SUTUN�a g�re 
   SIRALAMA yapmak i�in kullan�l�r.
   
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
=====================================================*/
    
       CREATE TABLE kisiler 
    (
        ssn CHAR(9) PRIMARY KEY,
        isim VARCHAR2(50), 
        soyisim VARCHAR2(50), 
        maas NUMBER,
        adres VARCHAR2(50) 
    );
    
    INSERT INTO kisiler VALUES(123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kisiler VALUES(256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kisiler VALUES (344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (345458901, 'Veli','Yilmaz',7000,'Istanbul');
    SELECT * FROM kisiler;
/* ----------------------------------------------------------------------------
  ORNEK1: kisiler tablosunu adres'e g�re s�ralayarak sorgulay�n�z.
 -----------------------------------------------------------------------------*/ 
 
 SELECT * FROM kisiler
 ORDER BY adres;
 
 --ORNEK2: kisiler tablosunu maas'a g�re ters (azalan) s�ralayarak sorgulay�n�z.
 ------------------------------------------------------------------------
    
 SELECT * from kisiler
 ORDER BY maas DESC;
 
 --ORNEK3: ismi Mine olanlar�, SSN'e g�re AZALAN(DESC) s�rada sorgulay�n�z.
 
 SELECT * FROM kisiler
 WHERE isim='Mine'
 ORDER BY ssn DESC;
 
 --ORNEK5: soyismi 'i Bulut olanlar� isim s�ral� olarak sorgulay�n�z.
-----------------------------------------------------------------------------*

SELECT * FROM kisiler
WHERE soyisim='Bulut'
ORDER BY 2; -- isim yerine ismin s�tun s�ras� olan 2 yi kullanabiliriz
 
/* ====================== FETCH NEXT, OFFSET (12C VE �ST� oracle larda �al���r, daha altsan�z �al��maz) ======================
   FETCH c�mleci�i ile listelenecek kay�tlar� s�n�rland�rabiliriz. �stersek 
   sat�r say�s�na g�re istersek de toplam sat�r say�s�n�n belli bir y�zdesine 
   g�re s�n�rland�rma koymak m�mk�nd�r. (�u kadar sat�r� getir)
   
   Syntax
   ---------
   FETCH NEXT satir_sayisi ROWS ONLY;
   FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
   
   
   OFFSET C�mleci�i ile de listenecek olan sat�rlardan s�ras�yla istedi�imiz 
   kadar�n� atlayabiliriz.  
   
   Syntax
   ----------
   OFFSET sat�r_sayisi ROWS;  offset atla, fetch getir
  
==============================================================================*/ 
/* ----------------------------------------------------------------------------
  ORNEK1: MAA�'� en y�ksek 3 ki�inin bilgilerini listeleyen sorguyu yaz�n�z.*/
  
  SELECT * FROM kisiler
  ORDER BY maas DESC
  FETCH NEXT 3 ROWS ONLY;  --bu yeni s�r�mlerde �al���r
  
   SELECT * FROM (SELECT * FROM kisiler
    ORDER BY maas DESC)--(1) ki�ilerde maasa g�re ters s�rala
    WHERE ROWNUM < 4;--1.2 ve 3. sat�r� getir  (bu eski s�r�mlerde �al���r)
  
 -- ORNEK2: MAA�'� en D���K 2 ki�inin bilgilerini listeleyen sorguyu yaz�n�z.
 
/* select * from kisiler
 order by maas
 fetch next 2 rows only;*/
 
 SELECT * FROM (SELECT * FROM kisiler
    ORDER BY maas )
    WHERE ROWNUM < 3;
 
-- ORNEK3: MAA�'a g�re (azalan )s�ralamada 4. 5. ve 6. ki�ilerin bilgilerini listeleyen 
 -- sorguyu yaz�n�z.
 
 select * from kisiler
 order by maas desc
 OFFSET 3 ROWS
 FETCH NEXT 3 ROWS ONLY;
 
 
 
 SELECT * FROM   
   (SELECT * FROM 
   (SELECT *
                FROM   kisiler
                ORDER BY maas DESC)
        WHERE ROWNUM <=6)
WHERE  ROWNUM <=3;