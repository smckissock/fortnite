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







