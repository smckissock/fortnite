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