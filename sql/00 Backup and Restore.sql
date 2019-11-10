USE Fortnite2
GO




-- July 20, 2019
BACKUP DATABASE Fortnite2
TO DISK = N'c:\Fortnitedb\July20.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'c:\Fortnitedb\July20.bak'
GO


-- Didn't test this
RESTORE DATABASE Fortnite2
FROM DISK = N'c:\Fortnitedb\July20.bak'
WITH MOVE 'Fortnite2' TO 'C:\fortnitedb\FortniteJuly7\Fortnite.mdf',
MOVE 'Fortnite2_log' TO 'C:\fortnitedb\FortniteJuly7\Fortnite_log.ldf'




-- From Backup
-- July 24, 2019
BACKUP DATABASE Fortnite2
TO DISK = N'd:\Fortnitedb\July20.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\db\FortniteJuly24.bak'
GO
[Fortnite_bad_cs_final]

-- Didn't test this
RESTORE DATABASE Fortnite2
FROM DISK = N'd:\db\FortniteJuly24.bak'
WITH MOVE 'Fortnite2' TO 'C:\fortnitedb\FortniteJuly7\Fortnite.mdf',
MOVE 'Fortnite2_log' TO 'C:\fortnitedb\FortniteJuly7\Fortnite_log.ldf'


RESTORE DATABASE Fortnite2
FROM DISK = N'd:\db\FortniteJuly24.bak'
WITH MOVE 'Fortnite2' TO 'd:\db\Fortnite2.mdf',
MOVE 'Fortnite2_log' TO 'd:\db\Fortnite2_log.ldf'


-- August 14, 2019 - NEW MACHINE
RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\aug14.bak'
GO


RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\aug14.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\Fortnite.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\Fortnite_log.ldf'



-- August 19, 2019  Before importing Trios week 1
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\August 19.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\August 19.bak'
GO

-- August 24, 2019  Before importing Trios week 1
RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\August 19.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\Fortnite_.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\Fortnite_log_.ldf'



-- August 26, 2019  Before importing Trios week 2
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\August 26.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\August 26.bak'
GO


RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\August 26.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\Fortnite__.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\Fortnite_log__.ldf'



-- August 26, 2019  After importing Trios week 2
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\August 26b.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\August 26b.bak'
GO




-- August 29, 2019  After Adding payouts to WC placements
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\August 29.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\August 29.bak'
GO

RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\August 29.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\Fortnite8_26.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\Fortnite_log8_26__.ldf'






-- September 1, 2019 after WC fixes, before more WC fixes
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 1.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 1.bak'
GO



-- September 2, 2019 after CS Week 3
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 2.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 2.bak'
GO


-- September 10, 2019 before importing CS Week 4
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 10.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 10.bak'
GO





-- September 16, 2019 before importing CS Week 5
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 16.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 16.bak'
GO


-- September 21, 2019 before importing M-F
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 21.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 21.bak'
GO



-- September 22, 2019 before importing M-F, after changeing weeks to wevent
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 22.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 22.bak'
GO




-- September 23, 2019 after importing M-F -- Asia, OCE qnd ME are wrong
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\September 23.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO

RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 23.bak'
GO


RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\September 22b.bak'
GO

RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\September 22b.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\September22b.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\FSeptember22b.ldf'


-- October 1  Before db changes to remove WeekEvent
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\October 1.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO


RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\October 1.bak'
GO


-- October 3  Event Week isn't used. PLayer name moved to player placement 
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\October 3.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO


RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\October 3.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\October3.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\October3.ldf'


-- October 5  Before updateing WC Names 
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\October 5.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO



-- October 11  Before adding post CS events 
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\October 11.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO



-- October 15  After initial Power Rankings 
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\October 15.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO



-- October 19  Before removing cash cups from Power Rankings 
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\October 19.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO




-- November 1 Before Adding Squad events 
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\November 1.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO



-- November 4 Before importing squad week1  
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\November 4.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO



RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\November 4.bak'
GO

RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\November 4.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\November 4.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\November 4.ldf'


-- November 5 After importing squad week1, before updating names  
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\November 5.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO



RESTORE FILELISTONLY
FROM DISK = N'd:\fortnite\fortnitedb\November 5.bak'
GO

RESTORE DATABASE Fortnite
FROM DISK = N'd:\fortnite\fortnitedb\November 5.bak'
WITH MOVE 'Fortnite2' TO 'd:\fortnite\fortnitedb\November 5.mdf',
MOVE 'Fortnite2_log' TO 'd:\fortnite\fortnitedb\November 5.ldf'



-- November 11 Before adding power points to player
BACKUP DATABASE Fortnite
TO DISK = N'd:\Fortnite\Fortnitedb\November 11.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO
BACKUP DATABASE Fortnite
TO DISK = N'g:\db\November 11.bak' WITH NOFORMAT, NOINIT, NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO




















