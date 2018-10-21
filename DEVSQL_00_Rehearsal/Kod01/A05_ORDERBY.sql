	----------------------------------------------------------------
	--	Database Fundamentals																							
	--	z01s03
	----------------------------------------------------------------
	
	--	SELECT			(5)
	--	FROM			(1)
	--	WHERE			(2)
	--	GROUP BY		(3)
	--	HAVING			(4)
	--	ORDER BY		(6)
	----------------------------------------------------------------

		USE [ContosoRetailDW]				
		GO


	--	logiczna kolejno�� zapytania
	-------------------------------------------
				
		--	http://www.sqlpedia.pl/logiczne-przetwarzanie-zapytan-sql/
		--	http://blog.sqlauthority.com/2009/04/06/sql-server-logical-query-processing-phases-order-of-statement-execution/

		--	UWAGA!! - kolejno�� logiczna zapytania SELECT to bardzo cz�sty temat pyta� na rozmowach rekrutacyjnych

		/*
			W konstrukcji zapyta� mo�emy wyszczeg�lni� 6 g��wnych blok�w logicznych.

				(Step 5)   SELECT   -- okre�lanie kszta�tu wyniku, selekcja pionowa (kolumn)
				(Step 1)   FROM     -- okre�lenie �r�d�a (�r�de�) i relacji mi�dzy nimi
				(Step 2)   WHERE    -- filtracja rekord�w
				(Step 3)   GROUP BY -- grupowanie rekord�w
				(Step 4)   HAVING   -- filtrowanie grup
				(Step 6)   ORDER BY -- sortowanie wyniku
		*/

		--	[dla zainteresowanych]
		--	https://en.wikipedia.org/wiki/Declarative_programming

	--	ORDER BY
	-------------------------------------------
		
		SELECT [AccountKey]
            ,  [AccountName]
            ,  [AccountType]
		FROM [dbo].[DimAccount]

		--

		SELECT [AccountKey]
            ,  [AccountName]
            ,  [AccountType]
		FROM [dbo].[DimAccount]
		ORDER BY [AccountName]

		--

		SELECT [AccountKey]
            ,  [AccountName]
            ,  [AccountType]
		FROM [dbo].[DimAccount]
		ORDER BY [AccountType]

		--

		SELECT
			[Manufacturer]		AS [Manufacturer],
			COUNT(*)			AS [count],
			SUM([UnitCost])		AS [sum],
			MIN([UnitCost])		AS [min],
			MAX([UnitCost])		AS [max]
		FROM
			[dbo].[DimProduct]
		GROUP BY
			[Manufacturer]
		HAVING
			SUM([UnitCost]) > 5000
		ORDER BY
			[max] DESC
		
		--

		SELECT [BrandName], [Manufacturer], [ClassName], COUNT(*)
		FROM
			[dbo].[DimProduct]
		GROUP BY
			[BrandName], [Manufacturer], [ClassName]
		ORDER BY
			[BrandName], 
			[ClassName]