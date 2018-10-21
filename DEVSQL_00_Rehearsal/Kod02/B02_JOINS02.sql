USE [AdventureWorks2016CTP3]
GO

	--	Dla wszystkich klient�w z tabeli [Sales].[Customer]	wyci�gn�� informacj� na temat 
	--	[CountryRegionCode] oraz [Group] znajduj�c� si� w [Sales].[SalesTerritory] (��czenie po [TerritoryID])
	--	
	----------------------------------------------------------------
		
		SELECT 
				[c].[CustomerID]		,
				[t].[CountryRegionCode] ,
				[t].[Group]
		FROM 
					[Sales].[Customer]			AS [c]
		INNER JOIN	[Sales].[SalesTerritory]	AS [t] ON [t].[TerritoryID] = [c].[TerritoryID]

	--	Do nag��wk�w zam�wie� ([Sales].[SalesOrderHeader]) do��czy� szecz�y ([Sales].[SalesOrderDetail]) ��cz�c po kolumnie [SalesOrderID]
	--	w [SalesOrderHeader] znajduj� si� ID adresu dostawy ([ShipToAddressID]) - u�y� do po��czenia z tabel� [Person].[Address]
	--	w [SalesOrderDetail] znajduje si� ID produktu z konkretnej linii zam�wienia ([ProductID]) - u�y� do po��czenia z tabel� [Production].[Product]
	--	
	--	po��czy� ze sob� tabele, wybra� nast�puj�ce kolumny:

		--	[a].[City]
		--	[a].[PostalCode]
		--	[soh].[SalesOrderID]
		--	[sod].[SalesOrderDetailID]
		--	[sod].[OrderQty]
		--	[p].[ProductID]
		--	[p].[Name]

		-- gdzie:
		--	[soh]	: tabela [Sales].[SalesOrderHeader]
		--	[sod]	: tabela [Sales].[SalesOrderDetail]
		--	[p]		: tabela [Production].[Product]	
		--	[a]		: tabela [Person].[Address]		

		--	posortowa� wed�ug: [a].[City] , [a].[PostalCode]

	----------------------------------------------------------------

		SELECT
			[a].[City] ,
			[a].[PostalCode] ,
			[soh].[SalesOrderID] ,
			[sod].[SalesOrderDetailID] ,
			[sod].[OrderQty] ,
			[p].[ProductID] ,
			[p].[Name]
		FROM
					[Sales].[SalesOrderHeader]	AS [soh]
		INNER JOIN	[Sales].[SalesOrderDetail]	AS [sod]	ON [sod].[SalesOrderID] = [soh].[SalesOrderID]
		INNER JOIN	[Production].[Product]		AS [p]		ON [p].[ProductID] = [sod].[ProductID]
		INNER JOIN	[Person].[Address]			AS [a]		ON [a].[AddressID] = [soh].[ShipToAddressID]
		ORDER BY
			[a].[City] ,
			[a].[PostalCode]


	--	Do nag��wk�w zam�wie� ([Sales].[SalesOrderHeader]) do��czy� szecz�y ([Sales].[SalesOrderDetail]) ��cz�c po kolumnie [SalesOrderID]
	--	w [SalesOrderHeader] znajduj� si� ID Terytorium ([TerritoryID]) - u�y� do po��czenia z tabel� [Sales].[SalesTerritory]
	--
	--	zafiltrowa� daty [OrderDate] z drugiej po�owy roku 2011 (mi�dzy: '20110701' a '20111231')
	--	w SELECT wybra� dwie kolumny:
	--	[Name]			->	nazwa terytorium
	--	[OrderPrice]	->	suma mno�enia [OrderQty] * [UnitPrice]
	--	pogrupowa� wg [Name], posortowa� wg [Name]
	--	otrzymamy raport prezentuj�cy sum� warto�ci zam�wie� H2_2011 w podziale na terytorium sprzeda�owe
	----------------------------------------------------------------
		
		SELECT
			[st].[Name] ,
			SUM([sod].[OrderQty] * [sod].[UnitPrice]) AS [OrderPrice]
		FROM
					[Sales].[SalesOrderHeader]	AS [soh]
		INNER JOIN	[Sales].[SalesOrderDetail]	AS [sod] ON [sod].[SalesOrderID] = [soh].[SalesOrderID]
		INNER JOIN	[Sales].[SalesTerritory]	AS [st] ON [st].[TerritoryID] = [soh].[TerritoryID]
		WHERE
			[soh].[OrderDate] BETWEEN '20110701'
								AND		'20111231'
		GROUP BY
			[st].[Name]
		ORDER BY
			[st].[Name];