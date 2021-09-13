---------------------- SELECT - WHERE ----------------------

    CREATE TABLE ogrenciler2 (
    id NUMBER (9),
    isim VARCHAR (50),
    adres VARCHAR (100),
    sinav_notu NUMBER (3)
    );
    
    INSERT INTO ogrenciler2 VALUES (123, 'Ali Can', 'Ankara', 75);
    INSERT INTO ogrenciler2 VALUES (124, 'Merve Gul', 'Ankara', 85);
    INSERT INTO ogrenciler2 VALUES (125, 'Kemal Yasa', 'Istanbul', 85);
    
    SELECT * FROM ogrenciler2;
    
    /* ============================================================================
   Verileri SELECT komutu ile veritaban�ndan �ekerken filtreleme yapmak i�in 
   
   Syntax
   --------
    SELECT ile birlikte WHERE komutu kullan�labilir. 
   
    SELECT sut�n1, sut�n2
        ...
    FROM  tablo_ad� WHERE ko�ul;
==============================================================================*/
    
    -- ornek1 : sinav notu 80'den buyuk olan tum ogrencinin bilgilerini listele
    
        SELECT * FROM ogrenciler2
        WHERE sinav_notu>80;
        
    -- ornek2 : adresi Ankara olan ogrencilerin isim ve adres bilgilerini listele
    
        SELECT isim, adres FROM ogrenciler2
        WHERE adres= 'Ankara';
        
    -- ornek3: id'si 124 olan ogrencilerin tum bilgilerini sil
        
        DELETE FROM ogrenciler2
        WHERE id=124;
        
    -------------------- SELECT - BETWEEN ---------------------------
    
    CREATE TABLE personel2
    (
        id CHAR(5),
        isim VARCHAR2(50),
        maas NUMBER(5)
    );
    
    INSERT INTO personel2 VALUES('10001', 'Ahmet Aslan', 7000);
    INSERT INTO personel2 VALUES( '10002', 'Mehmet Y�lmaz' ,12000);
    INSERT INTO personel2 VALUES('10003', 'Meryem ', 7215);
    INSERT INTO personel2 VALUES('10004', 'Veli Han', 5000);
    INSERT INTO personel2 VALUES('10005', 'Mustafa Ali', 5500);
    INSERT INTO personel2 VALUES('10005', 'Ay�e Can', 4000);
    SELECT * FROM personel2;
    
    -- ornek4: id'si 10002 ile 10005 arasinda olan personelin bilgilerini listele
    
    -- 1. yontem ;
    
    SELECT
        * FROM personel2
        WHERE id BETWEEN '10002' AND '10005'; -- between komutunda ilk ve son deger dahildir
        
    -- 2. yontem ;
    
    SELECT
        * FROM personel2
        WHERE id >= '10002' AND id <= '10005';
        
    --ornek5 :  ismi Mehmet Yilmaz ile Veli Han arasindaki personel bilgilerini listele
  
    SELECT * FROM personel
    WHERE isim  BETWEEN 'Mehmet Yilmaz' AND 'Veli Han'  ;
    
    --ornek6: id si 10002-10004 aras�nda olmayan personelin maas�n�  listele
    
    SELECT id,maas from personel
    WHERE id NOT BETWEEN '10002' AND '10004';   
    
    /* ======================= SELECT - IN ======================================
    IN birden fazla mant�ksal ifade ile tan�mlayabilece�imiz durumlar� 
    tek komutla yazabilme imk�n� verir
    SYNTAX:
    -------
    SELECT sutun1,sutun2, ...
    FROM tablo_ad�
    WHERE sutun_ad� IN (deger1, deger2, ...);
    /* ========================================================================== */

    -- ornek7 : maasi 4000, 5000, 7000 olan personelin bilgilerini listele
    
    SELECT
        * FROM personel2
        WHERE maas IN (4000, 5000, 7000);
    
    
    
    
    
    
    
    
    
    
    
    
    
    