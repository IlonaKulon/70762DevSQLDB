	USE [AdventureworksDW2016CTP3]
	GO

	IF OBJECT_ID('dbo.FactFinance_Indeksy') IS NOT NULL DROP TABLE [dbo].[FactFinance_Indeksy]
	
	SELECT
			[OrganizationKey]
		,	[DepartmentGroupKey]
		,	[ScenarioKey]
		,	[AccountKey]
		,	[Amount]
		,	[Date]
	INTO [dbo].[FactFinance_Indeksy]
	FROM [dbo].[FactFinance]

	DECLARE @i INT = 0
	WHILE @i < 500
	BEGIN

	INSERT INTO [dbo].[FactFinance_Indeksy]
	(
			[OrganizationKey]
		,	[DepartmentGroupKey]
		,	[ScenarioKey]
		,	[AccountKey]
		,	[Amount]
		,	[Date]
	)
	SELECT [OrganizationKey]
        ,  [DepartmentGroupKey]
        ,  [ScenarioKey]
        ,  [AccountKey]
        ,  [Amount]	* RAND()	AS [Amount]
        ,  DATEADD(d,@i,[Date]) AS [Date]
	FROM [dbo].[FactFinance]

	SET @i = @i+1
	END

	SELECT COUNT(*)
	FROM [dbo].[FactFinance_Indeksy]