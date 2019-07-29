-- Feb 2, 2019

-- Backup
 BACKUP DATABASE RussiaNews
 --TO DISK = N'C:\TrumpDb\RussiaNews_2019_02_04_Empty.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
 TO DISK = N'd:\db\RussiaNews_2019_03_18.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
 GO

RESTORE FILELISTONLY
--FROM DISK = N'C:\TrumpDb\RussiaNews_2019_02_02.bak'
FROM DISK = N'd:\db\RussiaNews_2019_03_18.bak'
GO

----Restore 
RESTORE DATABASE RussiaNews2
FROM DISK = N'C:\TrumpDb\RussiaNews_2019_02_02.bak'
WITH MOVE 'RussiaNews' TO 'C:\TrumpDb\RussiaNews2.mdf',
MOVE 'RussiaNews_log' TO 'C:\TrumpDb\RussiaNews2_ldf.mdf'



-- April 10, 2019
RESTORE FILELISTONLY
--FROM DISK = N'C:\TrumpDb\RussiaNews_2019_02_02.bak'
FROM DISK = N'C:\Congress\RussiaNews.bak'
GO

RESTORE DATABASE Congress
FROM DISK = N'C:\Congress\RussiaNews.bak'
WITH MOVE 'RussiaNews' TO 'C:\Congress\Congress.mdf',
MOVE 'RussiaNews_log' TO 'C:\Congress\congress_ldf.mdf'




-- April 17, 2019
 BACKUP DATABASE Congress
 --TO DISK = N'C:\TrumpDb\RussiaNews_2019_02_04_Empty.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
 TO DISK = N'd:\db\Congress_2019_04_17.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
 GO

RESTORE FILELISTONLY
--FROM DISK = N'C:\TrumpDb\RussiaNews_2019_02_02.bak'
FROM DISK = N'd:\db\Congress_2019_04_17.bak'
GO

RESTORE DATABASE Senate
FROM DISK = N'd:\db\Congress_2019_04_17.bak'
WITH MOVE 'RussiaNews' TO 'd:\Congress\senate.mdf',
MOVE 'RussiaNews_log' TO 'd:\Congress\senate_ldf.mdf'



-- April 25, 2019
BACKUP DATABASE Senate
TO DISK = N'd:\db\Senate_2019_04_25.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\db\Senate_2019_04_25.bak'
GO

RESTORE DATABASE Senate_2019_04_25
FROM DISK = N'd:\db\Senate_2019_04_25.bak'
WITH MOVE 'RussiaNews' TO 'd:\Congress\senate_04_25.mdf',
MOVE 'RussiaNews_log' TO 'd:\Congress\senate_ldf_04_25.mdf'



-- May 14, 2019
BACKUP DATABASE Senate_2019_04_25
TO DISK = N'd:\db\Senate_2019_05_14.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\db\Senate_2019_04_25.bak'
GO

-- Jun 11, 2019
BACKUP DATABASE Fortnite
TO DISK = N'd:\db\FortniteJune11.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\db\FortniteJune11.bak'
GO




-- July 13, 2019
BACKUP DATABASE Fortnite
TO DISK = N'd:\db\FortniteJuly13.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'c:\fortnitedb\FortniteJuly7.bak'
GO

RESTORE DATABASE Fortnite
FROM DISK = N'c:\fortnitedb\FortniteJuly7.bak'
WITH MOVE 'Fortnite' TO 'C:\fortnitedb\FortniteJuly7\Fortnite.mdf',
MOVE 'Fortnite_log' TO 'C:\fortnitedb\FortniteJuly7\Fortnite_log.ldf'



[Fortnite_2019_07_27]
-- Post fortnite duos 
-- July 29 2019
BACKUP DATABASE Fortnite
TO DISK = N'j:\db\FortniteJuly29.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK =  N'j:\db\FortniteJuly29.bak'
GO

RESTORE DATABASE Fortnite2
FROM DISK = N'j:\db\FortniteJuly29.bak'
WITH MOVE 'Fortnite2' TO 'C:\fortnitedb\2019_07_29\Fortnite2.mdf',
MOVE 'Fortnite2_log' TO 'C:\fortnitedb\2019_07_29\Fortnite2_log.ldf'



-- July 29 2019 - after solo
BACKUP DATABASE Fortnite
TO DISK = N'j:\db\FortniteJuly29_2.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO




