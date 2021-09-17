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
    
    --ORNEK3: sat�lan meyve t�r�ne (URUN_AD�) g�re sat�lan (urun_miktari )MIN ve
    --  MAX urun miktarlarini, MAX urun miktarina g�re SIRALAYARAK listeyen sorguyu
    --  yaz�n�z.
    
    --elma  2  5
    --armut 2  3.....
    
    SELECT urun_adi, MIN(urun_miktari), MAX (urun_miktari) from manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi
    ORDER BY MAX (urun_miktari) DESC;

    /********SIRALAMA A�A�IDAK� G�B� OLMALI********
    =>SELECT FROM
    =>WHERE  1)gruplamadan baz� �artlara g�re baz�lar�n� ele
    =>GROUP BY 2)�zelliklerine g�re grupla
    =>HAV�NG (B�RAZDAN ��REN�CEZ)3) grup �zelliklerine g�re �artla ele. ya where ya having yani
    =>ORDER BY  4) bu gruplar� istenilen �zelli�e g�re s�rala*/
    
    /*ORNEK4: kisi ismine ve urun ad�na (select) g�re sat�lan �r�nlerin (sum)toplam�n�
    grupland�ran ve �nce isme g�re ters sonra urun_adi na g�re ters s�rayla (order by) listeyen sorguyu yaz�n�z.
    �nce isme g�re sonra meyvelere=*/
  
    select isim, urun_adi, SUM (urun_miktari) from manav
    group by isim, urun_adi
    order by isim desc, urun_adi desc; --isim ters s�ral�, urun adi ters s�ral� oldu
    
    /* ORNEK5: kisi ISM�NE ve URUN ADINA g�re, sat�lan �r�nlerin toplam�n� bulan ve
    ** SELECT IS�M, URUN_AD�    SUM(URUN_M�KTAR�) GROUP BY IS�M, URUN_M�KTAR�**
    ve bu toplam de�eri 3 ve fazlas� olan kay�tlar� toplam urun miktarlarina g�re
             **HAV�NG SUM(URUN_M�KTAR�)>=3      **  ORDER BY SUM(URUN_M�KTAR�)
    ters siralayarak listeyen sorguyu yaz�n�z.  veli elma 5
       **DESC                                 ali elma 5
                                              ali armut 4... */
    --WHERE SUM (urun_miktari)>=3 mant�ken �al��mal� ama SQL (aggregate) bu �art� GROUP BY dan
    --sonra HAV�NG ile yap�yor
    -- AGGREGATE (toplama sum, count vs)fonksiyonlar� ile ilgili bir ko�ul koymak
    --i�in GROUP BY'dan sonra HAVING c�mleci�i kullan�l�r.
    
    select isim, urun_adi, SUM(urun_miktari) toplam_urun from manav
    group by isim, urun_adi
    HAVING SUM(urun_miktari)>=3
    order by SUM(urun_miktari) desc;
    
    /* ORNEK6: sat�lan urun_adi'na g�re gruplay�p MAX urun say�lar�n�,(yine max �r�n say�s�na g�re)
    s�ralayarak listeyen sorguyu yaz�n�z. NOT: Sorgu, sadece MAKS urun_miktari
    MIN urun_miktar�na e�it olmayan kay�tlar� (where gibi ko�ul var) listelemelidir.
    ------------------------------------------------*/
    
    select urun_adi,MAX(urun_miktari) es�t_olmayan_urunler from manav
    group by urun_adi
    HAVING max(urun_miktari)<> MIN(urun_miktari)
    order by MAX(urun_miktari);
    
    /*============================= DISTINCT =====================================
    DISTINCT c�mleci�i bir SORGU ifadesinde benzer olan sat�rlar� flitrelemek
    i�in kullan�l�r. Dolay�s�yla se�ilen sutun yada sutunlar i�in benzersiz veri
    i�eren sat�rlar olu�turmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_ad�; */
    --  ORNEK1: sat�lan farkl� meyve t�rlerinin say�s�n� listeyen sorguyu yaz�n�z.
    -- (ka� farkl� meyve t�r� var, elma armut �z�m=3)
    SELECT   COUNT (DISTINCT urun_adi) urun_cesit_sayisi from manav;
    -- ORNEK2: sat�lan meyve ad�  ve isimlerin (totalde )farkl� olanlar�n� listeyen sorguyu yaz�n�z.
    SELECT   DISTINCT urun_adi,isim from manav;
    --ORNEK3: sat�lan meyvelerin urun_mikarlarinin benzersiz  olanlar�n�n
    --  toplamlarini listeyen sorguyu yaz�n�z. 2+3+4+5=14
    SELECT SUM ( DISTINCT urun_miktari) benzersiz_urun_sayisi_toplami from manav;