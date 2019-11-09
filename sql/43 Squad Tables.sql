USE Fortnite
GO

EXEC DropTable 'SquadPlayer'
GO
EXEC DropTable 'SquadPlacement'
GO
EXEC DropTable 'Squad'
GO

CREATE TABLE Squad (
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	RegionID INT NOT NULL REFERENCES Region(ID)
	-- ...
)
CREATE UNIQUE NONCLUSTERED INDEX [UniqueSquadRegion] ON [dbo].[Squad]
(
	[ID] ASC,
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
GO

CREATE TABLE SquadPlayer (
	ID INT IDENTITY(1,1) NOT NULL,
	SquadID INT NOT NULL REFERENCES Squad(ID),
	PlayerID INT NOT NULL REFERENCES Player(ID)
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [UniqueSquadPlayer] ON [dbo].[SquadPlayer]
(
	[SquadID] ASC,
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE TABLE SquadPlacement (
	ID INT IDENTITY(1,1) NOT NULL,
	SquadID INT NOT NULL REFERENCES Squad(ID),
	PLacementID INT NOT NULL REFERENCES Placement(ID)
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [UniqueSquadPlacement] ON [dbo].[SquadPlacement]
(
	[SquadID] ASC,
	[PlacementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

