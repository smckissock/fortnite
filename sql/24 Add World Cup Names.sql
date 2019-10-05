USE Fortnite
GO





SELECT *, (SELECT CurrentName FROM Player WHERE ID = PlayerID)  
FROM StatsWithPlayerInfoView 
WHERE Event IN ('Solo Final', 'Duo Final') 