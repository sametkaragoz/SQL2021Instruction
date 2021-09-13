/*============================ GROUP BY =====================================
    
    GROUP BY c�mleci�i bir SELECT ifadesinde sat�rlar�, sutunlar�n de�erlerine 
    g�re �zet olarak gruplamak i�in kullan�l�r. 
   
    GROUP BY c�mlece�i her grup ba��na bir sat�r d�nd�r�r. 
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate 
    fonksiyonlar� ile birlikte kullan�l�r.*/
    


    CREATE TABLE manav 
    (
        isim varchar2(50), 
        urun_adi varchar2(50), 
        urun_miktari number(9) 
    );
    
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);
    
    SELECT * from manav;
    
    --   ORNEK1: kisi ismine g�re sat�lan toplam meyve miktarlar�n� g�steren sorguyu 
    -- yaz�n�z. ali=>5+2+2+2 sum= meyve say�lar�n� toplucak
 
    SELECT isim , SUM(urun_miktari) toplam_urun from manav
    GROUP BY isim; --isim isim grupla, her ismi bir kere yaz, o isimdeki meyve 
    --say�lar�n� topla ilgili ismin sat�r�nda g�ster
 
 
    -- ORNEK2: sat�lan meyve t�r�ne (urun_adi) g�re urun alan ki�i say�s�n� g�steren
    --  sorguyu yaz�n�z. NULL olarak girilen meyveyi listelemesin.count= elma alan ki�ileri sayacak
    -----------------------------
    SELECT urun_adi, COUNT(isim) from manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi;