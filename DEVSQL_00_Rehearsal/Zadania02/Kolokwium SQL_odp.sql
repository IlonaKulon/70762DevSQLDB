
--	Indeks:...........................................................
--	Imi� i Nazwisko...................................................

--	(1)
----------------------------------------------------------------------------------------------------------------
--	utworzy� baz� danych o nazwie [Kolokwium_XXXXXX]
--	w miejsce XXXXXX wpisa� swoj numer indeksu
--	prze��czy� kontekst na t� baz� (polecenie USE ...)

	USE [master]
	GO	

	DROP DATABASE IF EXISTS [Kolokwium_123456]
	GO

	CREATE DATABASE [Kolokwium_123456]
	GO

	USE [Kolokwium_123456]
	GO

--	(2)
----------------------------------------------------------------------------------------------------------------
--	utworzy� dwie tabele:
--		(a) zawieraj�ca informacje o pracownikach
--		(b) zawieraj�ca informacje o kosztach poniesionych przez przedsi�biorstwo

--	na podstawie danych z za��czonego pliku zaproponowa�
--		nazwy tabel
--		nazwy kolumn
--		typy danych
----------------------------------------------------------------------------------------------------------------

	DROP TABLE IF EXISTS [dbo].[Employee]
	DROP TABLE IF EXISTS [dbo].[Cost]
	GO

	CREATE TABLE [dbo].[Employee]
	(
		[EmployeeId]	INT				NOT NULL	PRIMARY KEY
	,	[Name]			VARCHAR(100)	NOT NULL
	,	[ManagerId]		INT 
	)
	GO

	CREATE TABLE [dbo].[Cost]
	(
		[Date]			DATE			NOT NULL
	,	[EmployeeId]	INT				NOT NULL
	,	[Description]	VARCHAR(200)	NOT NULL
	,	[Cost]			INT				NOT NULL
	)
	GO

--	(3)
----------------------------------------------------------------------------------------------------------------
--	w tabeli z danymi pracowniczymi na kolumnie z numerycznym ID, utworzy� PRIMARY KEY
--	mo�na to zrobi� ju� w punkcie drugim lub osobno tutaj (jak Pa�stwu wygodniej)
----------------------------------------------------------------------------------------------------------------

	--	zrobione w (2)


--	(4)
----------------------------------------------------------------------------------------------------------------
--	napisa� kod, kt�ry za�aduje dane do tabel utworzonych w punkcie (2)
--	u�y� kodu przygotowanego w pliku z danymi
--
--	np. ... INSERT INTO/VALUES
----------------------------------------------------------------------------------------------------------------
	
	INSERT INTO [dbo].[Employee]
	(
		[EmployeeId]	
	,	[Name]			
	,	[ManagerId]		
	)
	VALUES 
	(	1,	'Dyrektor'					,	NULL	)	,
	(	2,	'Kierownik Zespo�u A'		,	1		)	,
	(	3,	'Kierownik Zespo�u B'		,	1		)	,
	(	4,	'Koordynator Sekcji A1'		,	2		)	,
	(	5,	'Koordynator Sekcji A2'		,	2		)	,
	(	6,	'Koordynator Sekcji B1'		,	3		)	,
	(	7,	'Pracownik Szeregowy A1_01'	,	4		)	,
	(	8,	'Pracownik Szeregowy A1_02'	,	4		)	,
	(	9,	'Pracownik Szeregowy A1_03'	,	4		)	,
	(	10,	'Pracownik Szeregowy A1_04'	,	4		)	,
	(	11,	'Pracownik Szeregowy A1_05'	,	4		)	,
	(	12,	'Pracownik Szeregowy A2_01'	,	5		)	,
	(	13,	'Pracownik Szeregowy A2_02'	,	5		)	,
	(	14,	'Pracownik Szeregowy A2_03'	,	5		)	,
	(	15,	'Pracownik Szeregowy A2_04'	,	5		)	,
	(	16,	'Pracownik Szeregowy A2_05'	,	5		)	,
	(	17,	'Pracownik Szeregowy B1_01'	,	6		)	,
	(	18,	'Pracownik Szeregowy B1_02'	,	6		)	,
	(	19,	'Pracownik Szeregowy B1_03'	,	6		)
	GO

	INSERT INTO [dbo].[Cost]
	(
		[Date]			
	,	[EmployeeId]	
	,	[Description]	
	,	[Cost]		
	)
	VALUES	
	(	'20170101', 1	,	'Wynagrodzenie Podstawowe,Stycze�2017, Dyrektor'					,	13000	)	,
	(	'20170101', 2	,	'Wynagrodzenie Podstawowe,Stycze�2017, Kierownik Zespo�u A'			,	8500	)	,
	(	'20170101', 3	,	'Wynagrodzenie Podstawowe,Stycze�2017, Kierownik Zespo�u B'			,	8500	)	,
	(	'20170101', 4	,	'Wynagrodzenie Podstawowe,Stycze�2017, Koordynator A1'				,	5900	)	,
	(	'20170101', 5	,	'Wynagrodzenie Podstawowe,Stycze�2017, Koordynator A2'				,	6500	)	,
	(	'20170101', 6	,	'Wynagrodzenie Podstawowe,Stycze�2017, Koordynator B1'				,	6000	)	,
	(	'20170101', 7	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A1_01'	,	4000	)	,
	(	'20170101', 8	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A1_02'	,	4200	)	,
	(	'20170101', 9	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A1_03'	,	4200	)	,
	(	'20170101', 10	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A1_04'	,	4200	)	,
	(	'20170101', 11	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A1_05'	,	4200	)	,
	(	'20170101', 12	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A2_01'	,	4000	)	,
	(	'20170101', 13	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A2_02'	,	4300	)	,
	(	'20170101', 14	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A2_03'	,	4300	)	,
	(	'20170101', 15	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A2_04'	,	4300	)	,
	(	'20170101', 16	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy A2_05'	,	4000	)	,
	(	'20170101', 17	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy B1_01'	,	4000	)	,
	(	'20170101', 18	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy B1_02'	,	4500	)	,
	(	'20170101', 19	,	'Wynagrodzenie Podstawowe,Stycze�2017, Pracownik Szeregowy B1_03'	,	4500	)	,
	(	'20170101', 1	,	'Bonus,Stycze�2017, Dyrektor'										,	2000	)	,
	(	'20170101', 2	,	'Bonus,Stycze�2017, Kierownik Zespo�u A'							,	1000	)	,
	(	'20170101', 3	,	'Bonus,Stycze�2017, Kierownik Zespo�u B'							,	1000	)	,
	(	'20170101', 4	,	'Bonus,Stycze�2017, Koordynator A1'									,	750		)	,
	(	'20170101', 5	,	'Bonus,Stycze�2017, Koordynator A2'									,	750		)	,
	(	'20170101', 6	,	'Bonus,Stycze�2017, Koordynator B1'									,	750		)	,
	(	'20170101', 7	,	'Bonus,Stycze�2017, Pracownik Szeregowy A1_01'						,	350		)	,
	(	'20170101', 8	,	'Bonus,Stycze�2017, Pracownik Szeregowy A1_02'						,	350		)	,
	(	'20170101', 9	,	'Bonus,Stycze�2017, Pracownik Szeregowy A1_03'						,	350		)	,
	(	'20170101', 10	,	'Bonus,Stycze�2017, Pracownik Szeregowy A1_04'						,	350		)	,
	(	'20170101', 11	,	'Bonus,Stycze�2017, Pracownik Szeregowy A1_05'						,	350		)	,
	(	'20170101', 12	,	'Bonus,Stycze�2017, Pracownik Szeregowy A2_01'						,	350		)	,
	(	'20170101', 13	,	'Bonus,Stycze�2017, Pracownik Szeregowy A2_02'						,	350		)	,
	(	'20170101', 14	,	'Bonus,Stycze�2017, Pracownik Szeregowy A2_03'						,	350		)	,
	(	'20170101', 15	,	'Bonus,Stycze�2017, Pracownik Szeregowy A2_04'						,	350		)	,
	(	'20170101', 16	,	'Bonus,Stycze�2017, Pracownik Szeregowy A2_05'						,	350		)	,
	(	'20170101', 17	,	'Bonus,Stycze�2017, Pracownik Szeregowy B1_01'						,	350		)	,
	(	'20170101', 18	,	'Bonus,Stycze�2017, Pracownik Szeregowy B1_02'						,	350		)	,
	(	'20170101', 19	,	'Bonus,Stycze�2017, Pracownik Szeregowy B1_03'						,	350		)	
	GO

--	(5)
----------------------------------------------------------------------------------------------------------------
--	utworzy� widok, 
--	kt�ry zwr�ci pracownik�w maj�cych w nazwie ci�g "Pracownik Szeregowy A"
----------------------------------------------------------------------------------------------------------------
	
	DROP VIEW IF EXISTS [dbo].[View_Exc05]
	GO

	CREATE VIEW [dbo].[View_Exc05]
	AS
	SELECT
		[e].[EmployeeId]
	,	[e].[Name]
	,	[e].[ManagerId]
	FROM
		[dbo].[Employee] AS [e]
	WHERE
		[e].[Name] LIKE '%Pracownik Szeregowy A%';
	GO

	SELECT
		[v].[EmployeeId]
	,	[v].[Name]
	,	[v].[ManagerId]
	FROM
		[dbo].[View_Exc05] AS [v];
	GO


--	(6)
----------------------------------------------------------------------------------------------------------------
--	napisa� zapytanie, kt�re zwr�ci list� pracownik�w (Id oraz nazwa)
--	oraz sumaryczne koszty przypisane do nich

--	... np. JOIN/GROUP BY/SUM()
----------------------------------------------------------------------------------------------------------------

	SELECT
		[e].[EmployeeId]
	,	[e].[Name]
	,	[Cost] = SUM([c].[Cost])
	FROM
		[dbo].[Employee]	AS [e]
	INNER JOIN [dbo].[Cost] AS [c] ON [c].[EmployeeId] = [e].[EmployeeId]
	GROUP BY 
		[e].[EmployeeId]
	,	[e].[Name]
	GO

--	(7)
----------------------------------------------------------------------------------------------------------------
--	napisa� zapytanie, kt�re zwr�ci list� dziesi�ciu najwi�kszych poniesionych koszt�w
--	do zapytania doda� kolumn� kt�re numeruje je od najwi�kszego do najmniejszego

--	... np. TOP/ORDER BY/ROW_NUMBER
----------------------------------------------------------------------------------------------------------------
	
	SELECT	TOP 10
			[c].[Date]
	,		[c].[EmployeeId]
	,		[c].[Description]
	,		[c].[Cost]
	,		ROW_NUMBER() OVER ( ORDER BY [c].[Cost] DESC ) AS [row_num]
	FROM
		[dbo].[Cost] AS [c]
	ORDER BY
		[c].[Cost] DESC;
	GO
	 
--	(8)
----------------------------------------------------------------------------------------------------------------
--	skasowa� z tabeli z pracownikami wszytkich pracownik�w o nazwie zaczynaj�cej si� na "Pracownik Szeregowy"
--
--	... DELETE/WHERE/LIKE
----------------------------------------------------------------------------------------------------------------
	
	DELETE FROM
	[dbo].[Employee]
	WHERE
		[Name]	LIKE 'Pracownik Szeregowy%';
	GO

--	(9)
----------------------------------------------------------------------------------------------------------------
--	zrobi� UPDATE na tabeli z kosztami

--	po skasowaniu pracownik�w w punkcie 8 w tabeli pozostan� wpisy z ID pracownik�w, kt�rzy ju� nie istniej� w bazie
--	bo zostali skasowani, we wszystkich takich przypadkach prosz� nadpisa� w tabeli koszt�w ID pracownika na (-1)
--
--	UPDATE/JOIN/IS NULL
----------------------------------------------------------------------------------------------------------------
	
	UPDATE	[c]
	SET		[c].[EmployeeId] = -1
	FROM
		[dbo].[Cost]			AS [c]
	LEFT JOIN [dbo].[Employee]	AS [e] ON [e].[EmployeeId] = [c].[EmployeeId]
	WHERE
		[e].[EmployeeId] IS NULL
	GO

	SELECT
		[c].[Date]
	,	[c].[EmployeeId]
	,	[c].[Description]
	,	[c].[Cost]
	FROM
		[dbo].[Cost] AS [c]
	WHERE
		[c].[EmployeeId] = -1;
	GO


--	(10*) - nieobowi�zkowe, dodatkowe punkty do oceny ko�cowej z przedmiotu
-------------------------------------------------------------
--	napisa� zapytanie kt�re zwraca koszty wygenerowane przez 
--	wszystkich pracownik�w podlegaj�cych pod "Kierownik Zespo�u A"
--	u�y� rekurencyjnego CTE do wygenerowania listy pracownik�w

--	zapytanie zapisa� w postaci funkcji tabelarycznej
--	a nazw� pracownika "Kierownik Zespo�u A" sparametryzowa�
-------------------------------------------------------------
	
	WITH cte
	AS
	(
		SELECT 
			[e].[EmployeeId]
		,	[e].[Name]
		,	[e].[ManagerId]
		FROM [dbo].[Employee] AS [e]
		WHERE [e].[Name] = 'Kierownik Zespo�u A'

		UNION ALL

		SELECT 
			[e].[EmployeeId]
		,	[e].[Name]
		,	[e].[ManagerId]
		FROM cte AS c
		INNER JOIN [dbo].[Employee] AS [e] ON [e].[ManagerId] = [c].[EmployeeId]
	)
	SELECT *
	FROM [cte]
	GO

	DROP FUNCTION IF EXISTS [dbo].[EmployeeCTE]
	GO

	CREATE FUNCTION [dbo].[EmployeeCTE](@empName VARCHAR(100))
	RETURNS TABLE
	AS
	RETURN
	WITH cte
	AS
	(
		SELECT 
			[e].[EmployeeId]
		,	[e].[Name]
		,	[e].[ManagerId]
		,	[Lvl] = 1
		FROM [dbo].[Employee] AS [e]
		WHERE [e].[Name] = @empName

		UNION ALL

		SELECT 
			[e].[EmployeeId]
		,	[e].[Name]
		,	[e].[ManagerId]
		,	[Lvl] = c.[Lvl] + 1
		FROM cte AS c
		INNER JOIN [dbo].[Employee] AS [e] ON [e].[ManagerId] = [c].[EmployeeId]
	)
	SELECT *
	FROM [cte]
	GO

	SELECT *
	FROM [dbo].[EmployeeCTE]('Kierownik Zespo�u A')
	ORDER BY [Lvl]
	GO

	SELECT *
	FROM [dbo].[EmployeeCTE]('Dyrektor')
	ORDER BY [Lvl]
	GO

