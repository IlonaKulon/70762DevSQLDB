
-----------------------------------------------
--	polecenia wstępne
-----------------------------------------------	

	--	używając skryptu wystawionego na moodle odtworzyć bazę	[Chinook] (nie załączać kodu z moodle do skryptu egzaminacyjnego)
	
	--	przestawić kontekst skryptu na bazę [Chinook]
	--	w bazie danych utworzyć schemat o nazwie [egz]

	USE [Chinook]
	GO

	CREATE SCHEMA [egz]
	GO

-----------------------------------------------
--	CREATE TABLE + Constraints
-----------------------------------------------	
	
	--	w schemacie [egz] utworzyć dwie tabele (A i B), samedzielnie dobrać odpowiednie typy danych:

		--	A/ Studenci
			--	identyfikator studenta (PRIMARY KEY)
			--	Imię
			--	Nazwisko
			--	data urodzenia

		--	B/ Oceny
			--	identyfikator oceny (PRIMARY KEY, IDENTITY)
			--	identyfikator studenta (FOREIGN KEY)
			--	przedmiot
			--	ocena (CHECK - ocena z zakresu 1-6)
			--	data wstawienia oceny

			--	UNIQUE na kolumnach identyfikator studenta oraz przedmiot (każdy student ma tylko jedną ocenę z przedmiotu)

	--	wstawić po kilka wierszy do każdej z tabel	(min.3 na tabelę) 
			

-----------------------------------------------
--	WHERE
-----------------------------------------------	
	
	--	01 zwrócić listę klientów, których imię zaczyna się na literę A, B lub C (tabela: [dbo].[Customer])
	----------------------------------------------------------------------------------------

		SELECT *
		FROM [dbo].[Customer]
		WHERE FirstName LIKE '[ABC]%'

	--	02 zwrócić listę faktur, wystawionych pomiędzy datami 2011-05-01 oraz 2011-06-30 (tabela: [dbo].[Invoice])
	----------------------------------------------------------------------------------------

		SELECT *
		FROM [dbo].[Invoice]
		WHERE InvoiceDate BETWEEN '20110501' AND '20110630'

-----------------------------------------------
--	JOIN
-----------------------------------------------	

	--	03 zwrócić listę wszystkich Albumów nagranych przez zespoły: AC/DC', Led Zeppelin oraz Metallica
	--	(tab:	[dbo].[Artist],	[dbo].[Album])
	----------------------------------------------------------------------------------------

		SELECT	
			ar.[Name]
		,	al.[AlbumId]
		,	al.[Title]
		,	al.[ArtistId]
		FROM 
					[dbo].[Artist]	AS ar
		INNER JOIN	[dbo].[Album]	As al ON ar.ArtistId = al.ArtistId
		WHERE 
			ar.[Name] IN ('AC/DC','Led Zeppelin','Metallica')

-----------------------------------------------
--	GROUP BY
-----------------------------------------------	

	--	04 tabela [dbo].[InvoiceLine] zawiera wszystkie faktury wystawione przez przedsiębiorstwo
	--	zwrócić sumaryczną kwotę sprzedaży ( tzn. ilość sprzedana razy cena jednostkowa, il.Quantity * il.UnitPrice)
	--	w podziale na Artystę
	--	pogrupować wg kwoty malejąco
	--	(tab:	[dbo].[Artist], [dbo].[Album],	[dbo].[Track],	[dbo].[InvoiceLine])

		SELECT
			ar.ArtistId
		,	ar.Name
		,	SUM(il.Quantity * il.UnitPrice) AS [total_price]
		FROM 
					[dbo].[Artist]			AS ar
		INNER JOIN	[dbo].[Album]			AS al	ON ar.ArtistId	= al.ArtistId
		INNER JOIN	[dbo].[Track]			AS tr	ON tr.AlbumId	= al.AlbumId
		INNER JOIN	[dbo].[InvoiceLine]		AS il	ON tr.TrackId	= il.TrackId
		GROUP BY
			ar.ArtistId,
			ar.Name
		ORDER BY 
			[total_price] DESC

-----------------------------------------------
--	GROUPING SETS, GROUPING_ID(), CASE
-----------------------------------------------

	--	05
	--	przygotować raport, który zwraca sumaryczne kwoty faktur (kolumna [Total] w [dbo].[Invoice])
	--	pogrupowane po:
		--	mieście:	[BillingCity]
		--	państwie:	[BillingCountry]
	--	 raport ma zawierać również kwotę całkowitą
	--	posortować tak, aby najpierw wyświetlany był wiersz zbiorczy z kwotą całkowitą, następnie podsumowania po krajach a na końcu po miastach

	--	(tab:	[dbo].[Invoice])
	--	[uwaga]: zastosować jedną z klauzuli: GROUPING SETS/ ROLLUP/ CUBE. Zapytanie utworzone poprzez złączenie 3 podzapytań przez UNION ALL nie będą zaliczane

		SELECT
			CASE	GROUPING_ID(BillingCountry, BillingCity)
			WHEN 3	THEN 'Total'
			WHEN 1	THEN 'Country'
			WHEN 0	THEN 'City'
			END 
		,	BillingCountry
		,	BillingCity
		,	COUNT(*)		AS	[LiczbaFaktur]
		,	SUM(Total)		AS	[Total] 
		FROM [dbo].[Invoice] AS iv
		GROUP BY ROLLUP(BillingCountry, BillingCity)
		ORDER BY 
			GROUPING_ID(BillingCountry, BillingCity) DESC

-----------------------------------------------
--	INDEX
-----------------------------------------------

	--	06
	--	utworzyć indeks nieklastrowany na tabeli [dbo].[Invoice] na kolumnie [TrackId]
	--	do indeksu dołączyć kolumnę [InvoiceId] (nie pownna być częścią klucza indeksu)

		CREATE NONCLUSTERED INDEX NIX_InvoiceLine
		ON [dbo].[InvoiceLine]([TrackId])
		INCLUDE([InvoiceId])
		GO

-----------------------------------------------
--	CTE/Subquery lub OUTER-APPLY
-----------------------------------------------
	
	--	07
	--	przygotować zapytanie, któe dla każdego klienta zwraca jego trzy ostatnie faktury
	--	(ostatnie, czyli z najstarszą datą [InvoiceDate])

	--	(tab:	[dbo].[Invoice],	[dbo].[Customer])

		WITH cte_rn
		AS
		(
			SELECT 
				[rn]	=	ROW_NUMBER() OVER (	PARTITION BY	iv.CustomerId
												ORDER BY		iv.InvoiceDate DESC
												)
			,	cu.FirstName
			,	cu.LastName
			,	iv.*
			FROM 
						[dbo].[Invoice]		AS iv
			INNER JOIN	[dbo].[Customer]	AS cu ON iv.CustomerId = cu.CustomerId
		)
		SELECT *
		FROM cte_rn
		WHERE [rn] <=3
		ORDER BY CustomerId
		GO

-----------------------------------------------
--	View
-----------------------------------------------	

	--	08	
	--	utworzyć widok, który zwraca wszystkie piosenki ([dbo].[Track])
	--	wraz z nazwą nośnika: ([dbo].[MediaType].[Name])
	--	oraz nazwą gatunku muzycznego:	([dbo].[Genre].[Name])
	--	widok ma być powiązany z obiektami, które zostały w nim użyte: tzn, ma blokować jakiekolwiek zmiany na tabelach, z których pobiera dane

	--	(tab:	[dbo].[Track], [dbo].[MediaType], [dbo].[Genre] )

		CREATE VIEW [egz].[vwTrack]
		WITH SCHEMABINDING
		AS
		SELECT
			tr.TrackId	AS [TrackId]
		,	tr.[Name]	AS [TrackName]
		,	mt.[Name]	AS [mediaTypeName]
		,	gn.[Name]	AS [GenreName]
		FROM
					[dbo].[Track]		AS tr
		INNER JOIN	[dbo].[MediaType]	AS mt	ON tr.MediaTypeId	= mt.MediaTypeId
		INNER JOIN	[dbo].[Genre]		AS gn	ON tr.GenreId		= gn.GenreId	
		GO	

		SELECT *
		FROM [egz].[vwTrack]
		GO

-----------------------------------------------
--	Procedura
-----------------------------------------------	

	--	09
	--	poniższy kod tworzy kopię tabeli [Invoice] w schemacie [egz], proszę wywołać i utworzyć tabelę
	
	--	utworzyć procedurę, która:
		--	przyjmuje dwa parametry, oba typu DATETIME, nazwy parametrów dowolne
			--	parametr#1: data początkowa, wartość domyślna 19000101
			--	parametr#2: data końcowa, wartość domyślna 20990101
		
		--	procedura w pierwszym kroku czyści tabelę [egz].[Invoice] (usuwa wszystkie rekordy)
		
		--	procedura w drugim kroku przeładowuje z tabeli [dbo].[Invoice] 
		--	wszystkie wiersze z datą księgowania (InvoiceDate) pomiędzy parametrem#1 oraz parametrem#2


		CREATE TABLE [egz].[Invoice]
		(
			[InvoiceId]			[int] NOT NULL,
			[CustomerId]		[int] NOT NULL,
			[InvoiceDate]		[datetime] NOT NULL,
			[BillingAddress]	[nvarchar](70) NULL,
			[BillingCity]		[nvarchar](40) NULL,
			[BillingState]		[nvarchar](40) NULL,
			[BillingCountry]	[nvarchar](40) NULL,
			[BillingPostalCode] [nvarchar](10) NULL,
			[Total]				[numeric](10, 2) NOT NULL,
		)
		GO

		CREATE PROC	[egz].[usp_ReloadInvoice]
			@DateStart	DATETIME = '19000101'
		,	@DateStop	DATETIME = '20990101'
		AS
		BEGIN
		
			TRUNCATE TABLE [egz].[Invoice]
			;

			INSERT INTO [egz].[Invoice]
			SELECT *
			FROM [dbo].[Invoice]
			WHERE InvoiceDate BETWEEN @DateStart AND @DateStop
			;

		END

-----------------------------------------------
--	XML
-----------------------------------------------	
	
	--	10
	--	Do poniższego zapytania SELECT dopisać klauzulę FOR XML tak,
	--	aby zwracała wynik jak w zakomentowanym tekście
	--------------------------------------------------------------

		SELECT 
			e.EmployeeId
		,	e.LastName
		,	e.FirstName
		,	e.Title
		FROM [dbo].[Employee] AS e
		FOR XML RAW, ROOT('Employees')

	/*
		<Employees>
		  <row EmployeeId="1" LastName="Adams" FirstName="Andrew" Title="General Manager" />
		  <row EmployeeId="2" LastName="Edwards" FirstName="Nancy" Title="Sales Manager" />
		  <row EmployeeId="3" LastName="Peacock" FirstName="Jane" Title="Sales Support Agent" />
		  <row EmployeeId="4" LastName="Park" FirstName="Margaret" Title="Sales Support Agent" />
		  <row EmployeeId="5" LastName="Johnson" FirstName="Steve" Title="Sales Support Agent" />
		  <row EmployeeId="6" LastName="Mitchell" FirstName="Michael" Title="IT Manager" />
		  <row EmployeeId="7" LastName="King" FirstName="Robert" Title="IT Staff" />
		  <row EmployeeId="8" LastName="Callahan" FirstName="Laura" Title="IT Staff" />
		</Employees>
	*/