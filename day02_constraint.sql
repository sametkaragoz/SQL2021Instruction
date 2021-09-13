/*======================= CONSTRAINTS - KISITLAMALAR ======================================
               
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder. 

    UNIQUE - Bir sütundaki tüm deðerlerin BENZERSÝZ olmasýný garanti eder.  

    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSÝZ olmasýný garanti eder.(NOT NULL ve UNIQUE birleþimi gibi)

    FOREIGN KEY - Baþka bir tablodaki Primary Key’i referans göstermek için kullanýlýr. 
                  Böylelikle, tablolar arasýnda iliþki kurulmuþ olur. 

    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir þartý saðlamasýný garanti eder. 
    soldan tablo silerken tablonun kapalý olmasý lazým*/

   --ORNEK1-- NUT NULL
   --ogrenciler tablosu olusturalim ve id field'ini bos birakilmaz yapalim
   
   CREATE TABLE ogrenciler (
   id char (4) NOT NULL,
   isim varchar (50),
   not_ort number (4,2),
   kayit_tarihi date
   );
   
   INSERT INTO ogrenciler VALUES('1234','hasan',75.25,'18.Feb.21');
   INSERT INTO ogrenciler VALUES('1234','ayse',null,null);
   INSERT INTO ogrenciler (id,isim) VALUES ('3456','fatma');
   INSERT INTO ogrenciler VALUES(null,'osman',45.25,'5-Jan-20'); -- ORA-01400: cannot insert NULL into ("KARAGOZSAMET"."OGRENCILER"."ID")
   
   SELECT * FROM ogrenciler;
   
   
   --ORNEK2 UNIQUE
   --tedarikciler olusturalim, id=>unique olsun
   
   CREATE TABLE tedarikciler (
   id CHAR (4) UNIQUE,
   isim VARCHAR (50),
   adres VARCHAR (100),
   tarih DATE
   );
   
   INSERT INTO tedarikciler VALUES('1234','ayse','mehmet mahallesi izmir','18.Feb.21');
   INSERT INTO tedarikciler VALUES('1234','fatma','veli mahallesi istanbul','25.Feb.21'); -- ORA-00001: unique constraint (KARAGOZSAMET.SYS_C0010973) violated
   INSERT INTO tedarikciler VALUES(null,'cem','suvari mahallesi denizli','18.January.18');
   INSERT INTO tedarikciler VALUES(null,'can','zeki mahallesi mus','6.Jun.99');
   
   -- unique constraint tekrara izin vermez ancak istediginiz kadar null girebilirsiniz.
   
   SELECT * FROM tedarikciler;
   
   --ORNEK3 PRIMARY KEY--
   
   CREATE TABLE personel (
   id CHAR(5) PRIMARY KEY,
   isim VARCHAR(50) UNIQUE,
   maas NUMBER (5) NOT NULL,
   ise_baslama DATE
   );
   
    INSERT INTO personel VALUES('10001', 'Ahmet Aslan',7000, '13-APRIL-2018');
    INSERT INTO personel VALUES( '10001', 'Mehmet Yýlmaz' ,12000, '14-APRIL-18');-- HATA ALIR
    INSERT INTO personel VALUES('10003', '', 5000, '14-APRIL-18');
    INSERT INTO personel VALUES('10004', 'Veli Han', 5000, '14-APRIL-18');
    INSERT INTO personel VALUES('10005', 'Ahmet Aslan', 5000, '14-APRIL-18');-- HATA ALIR
    INSERT INTO personel VALUES(NULL, 'Canan Yaþ', NULL, '12-APRIL-19');-- null olmaz
   
   
   SELECT * FROM personel;
   
   --------- ogrenciler3 tablosu olusturalim ve ogrenci_id 'yi PRIMARY KEY yapalim

    CREATE TABLE ogrenciler3 ( 
    ogrenci_id char(4) PRIMARY KEY, 
    Isim_soyisim varchar2(50), 
    not_ort number(5,2), --100,00
    kayit_tarihi date -- 14-01-2021
    );

    SELECT * FROM ogrenciler3;

    INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman',75.70,'14-jan-2020');
    INSERT INTO ogrenciler3 VALUES (null, 'veli yaman',85.70,'14-jan-2020'); -- id null olamaz
    INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can',55.70,'14-june-2020'); -- id benzersiz olmalý, daha önceverilen id kullanýlamaz
    INSERT INTO ogrenciler3 (isim_soyisim) VALUES ( 'Veli Cem'); -- id vermeden baþka þeyler vermeye geçemezsin, default null atar, buda primary ye uymaz
    INSERT INTO ogrenciler3 (ogrenci_id) VALUES ( '5687');
    
    
    -- primary key alternatif yontem
    -- bu yontemde kisitlamaya istedigimiz ismi atayabiliriz.
    
    CREATE TABLE calisanlar (
    id CHAR(5),
    isim VARCHAR (50) UNIQUE,
    maas NUMBER (5) NOT NULL,
    CONSTRAINT id_primary PRIMARY KEY (id)
    );
   
    INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan',7000);
    INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yýlmaz' ,12000);
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000);
    
    SELECT * FROM calisanlar;
    
    -- bir tabloya data eklerken constraint'lere (kisitlamalara) dikkat edilmelidir.
    
    CREATE TABLE adresler (
    adres_id CHAR (5),
    sokak VARCHAR (30),
    cadde VARCHAR (30),
    sehir VARCHAR (15),
    
    CONSTRAINT id_foreign FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
    );
   
    INSERT INTO adresler VALUES('10001','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('10001','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('10002','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Aða Sok', '30.Cad.','Antep');
    
    -- foreign key'e null degeri atilabilir
    
    INSERT INTO adresler VALUES('10004','Gel Sok', '60.Cad.','Van'); -- parent'ta olmayan id'li veri giremeyiz.
    
    SELECT * FROM calisanlar; -- parent
    SELECT * FROM adresler; -- child

   DROP TABLE calisanlar; -- child silinmeden parent silinmez.
   DROP TABLE adresler;
   
   -- ogrenciler5 tablosu olusturun ve id, isim hanelerinin birlesimini primary key yapin.
   CREATE TABLE ogrenciler5 (
   id CHAR (4),
   isim VARCHAR (20),
   not_ort NUMBER (5,2),
   kayit_tarihi DATE,
   CONSTRAINT ogrenciler5_primary PRIMARY KEY (id,isim) -- 10, Ayse  +
   );                                                   -- 10, Ayse  -
                                                        -- 10, Fatma +
   
    INSERT INTO ogrenciler5 VALUES (null,'Veli Cem',90.6,'15-MAY-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
    INSERT INTO ogrenciler5 VALUES (1234,null,90.6,'15-MAY-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
    INSERT INTO ogrenciler5 VALUES (1234,'Ali Can',90.6,'15-MAY-2019'); -- PK= 1234Ali Can
    INSERT INTO ogrenciler5 VALUES (1234,'Veli Cem',90.6,'15-MAY-2019'); -- PK=1234Veli Cem
    INSERT INTO ogrenciler5 VALUES (1234,'Oli Can',90.6,'15-MAY-2019');  -- PK= 1234Oli Can
   
   SELECT * FROM ogrenciler5;
   
    --“tedarikciler4” isimli bir Tablo olusturun. Icinde “tedarikci_id”, “tedarikci_isim”, “iletisim_isim” field’lari olsun.
    --“tedarikci_id” ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
    --“urunler2” isminde baska bir tablo olusturun.Icinde “tedarikci_id” ve “urun_id” fieldlari olsun.
    --“tedarikci_id” ve “urun_id” fieldlarini birlestirerek Foreign Key olusturun
   
   CREATE TABLE tedarikciler4 (
   tedarikci_id char (4),
   tedarikci_isim VARCHAR (20),
   iletisim_isim VARCHAR (20),
   CONSTRAINT tedarikciler4_pk PRIMARY KEY (tedarikci_id,tedarikci_isim) -- char+varchar                 ---------\    
   );                                                                                                    --        \                                                                                                 
                                                                                                         --         \                                                                                
   CREATE TABLE urunler2 (                                                                               --          ========>>>   data type'lari ayni olmali                                                       
   tedarikci_id char (4),                                                                                --         /                                                                  
   urunler_isim VARCHAR (20),                                                                            --        /                                                                           
   CONSTRAINT urunler2_fk FOREIGN KEY (tedarikci_id,urunler_isim) REFERENCES tedarikciler4 -- char+varchar        /                                                                                    
   );
   
   CREATE TABLE sehirler2 (
   alan_kodu CHAR (3),
   isim VARCHAR (50),
   nufus NUMBER (8,0) CHECK (nufus>1000)
   );
   
   INSERT INTO sehirler2 VALUES ('312','Ankara',5750000);
   INSERT INTO sehirler2 VALUES ('232','Izmir',375); -- ORA-02290: check constraint (SAMET.SYS_C0011099) violated
   INSERT INTO sehirler2 VALUES ('232','Izmir',3750000);
   INSERT INTO sehirler2 VALUES ('436','Maras',null);
   