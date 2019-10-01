USE Fortnite
GO

EXEC DropTable 'Qualification'
GO
CREATE TABLE Qualification (
	ID [int] IDENTITY(1,1) NOT NULL,
	Player nvarchar(500) NOT NULL,
	Week nvarchar(10) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

 -- Add unique index on player and week


EXEC DropView 'QualificationView'
GO

CREATE VIEW QualificationView 
AS 
SELECT 
	q.Player,
	q.Week,
	p.SoloOrDuo,
	p.RegionCode,
	p.Rank,
	p.Payout,
	p.Points
FROM Qualification q 
JOIN Placement p ON p.Player = q.player AND p.WeekNumber = q.week 


INSERT INTO Qualification VALUES ((SELECT Player FROM Placement WHERE ID = 15001), 'Week1') 


SELECT * FROM Placement WHERE WeekNumber = 'Week1' AND RegionCode = 'OCE'

SELECT * FROM Placement WHERE Player LIKE '%slаyа%'


SELECT * FROM Placement

DELETE FROM Stat -- 74842
DELETE FROM Placement --6000


ALTER TABLE Placement ADD SoloWeek int NOT NULL DEFAULT 0
ALTER TABLE Placement ADD DuoWeek int NOT NULL DEFAULT 0


slаyа
TOP_FaxFox iwnl
E11 Stompy
TQ Prisi0n3r0
NRG benjуfishу
hREDS BELAEU
Gambit.letw1k3
nqyte
S2V DiegoGB
ÐRG
LOUD leleo
SEN Bughа
FaZe Dubs.
Ghost Bizzle
TSM_Comadon
Mjólnir
100T Ceice
snоw xd
Liquid Riversan
3

---
WEEK 3
Cat 夢
TOP_Banny iwnl
TAKAMURAMM iwnl
luKi tjk
COOLER LeftEye
Fledermoys
Tchub_
TTVCoreGamingg
use code wakie
lolb0om
Secret_Domentos
Lasers s2 Igo
kurтz
Tfue
MSF Clix
KNG Unknown
FaZe Funk
Nittle GG
CLG psalm
KNG EpikWhale
kаrhu
5
WEEK 5
Linkㅤㅤㅤ
Meta Peterpan
Atlantis Lеtshe
AGO JarkoS
N47 Klusia
NRG MrSavageM
Ghost Issa
Snayzy
Fnatic smeef
DualMedia BlastR
NRG Zayt
RogueShark_
kolorful ツ
FaZe Megga.
BuckeFPS
100T Klass
CODE DRAKONZ
WBG Rhux
USE CODE PZUHS
7
WEEK 7
twins iwnl
Meta Hood.J
T1 Arius iwnl
aqua.ㅤ
G mārteeṉeu
Erouce
TrainH Robabz
Parabellum bro
Solary Kinstaar
Atlantis K1nzell
Gambit.fwexY
clarityG
Reverse2k
CODE-ASTONISH
Thiccboy Luneze
Chenkinz.tv
NIX Fatch
CODE NICKSSS
k1ng iwnl-
WBG Pika
4DRStormOG

CoverH
Code Twizz
CR.bell iwnl
CODE CR-Scarlet
NRG benjуfishу
NRG MrSavageM
Secret_Mongraal
Atlantis Mitr0
E11 Tschiiinken
E11 Stompy
Lootboy Mexe
Lootboy Skram
woofgang crimz
OT Spαdes
MSF Clix
MSF Sceptic
Envy LeNain
LG Tyler15
W7M pfzin
CODE NICKSSS
Arkhram1x
Bloom Falconer
4
WEEK 4
Gambit.fwexY
Gambit.letw1k3
COOLER Nyhrox
aqua.ㅤ
VHV Crue
VHV Chapix
GO Deаdrа
GO M11Z
NRG Zayt
Ghost Saf
Tempo Brush
Tempo CizLucky
Nate Hill
FaZe Funk
KNG Leno
KNG Barl
6
WEEK 6
Code Volx
Code Parpy
NewbeeXXM
Newbee_xMende
Solary Airwaks
Solary Nîkof
Solary Hunter
Solary Kinstaar
Lnuef
Quіnten
VP 7ssk7
VP JAMSIDE
100T Ceice
100T Elevate
coL Lanjok
coL Punisher
FaZe Megga.
FaZe Dubs.
wisheydp
GusTavox8
S2 little
S2 jay

SELECT * FROM Placement