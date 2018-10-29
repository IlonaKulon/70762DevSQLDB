	/*
		
		w systemach bazowych w tabelach s�ownikowych (lista us�ug, produkt�w, pracownik�w itp...)
		cz�sto implementowany taki komplet kolumn:
			-	klucz techniczny, niewidoczny dla u�ytkownika z poziomu GUI, nie nios�cy �adnej informacji biznesowej
				IDENTITY, SEQUENCE...
			-	klucz biznesowy, nadawany przez pracownika, unikalny w ramach tabeli, nios�cy informacj�
				np. HIP01, HIP02 jako kolejne typy kredyt�w hipotecznych
			-	pe�na nazwa "Kredyt Hipoteczny typu XXX edycja YYY"

		wszystkie mechanizmy wewn�trz bazy - FK, logika procedur itp. - powinna by� zawsze pisana przy wykorzystaniu ��cze�
		na kluczach technicznych i powinny by� one niezmienne. nie nios� �adnej warto�ci informacyjnej wi�c u�ytkownika nie powinno 
		interesowa� czy dana pozycja dostanie numer 7,8 czy 199...

		[wa�ne]: pisz�c o mechanizmach wewn�tz bazy nie mam na my�li hardkodowania kluczy a ��czenia, czyli
			robimy: JOIN ... ON z.Key = y.Key
			nie robimy: WHERE z.Key = 1 

		klucze biznesowe mog� by� zmieniane - np. gdy kto� si� r�bnie i wpisze taki klucz niezgodnie z kowencja np.
		w kredycie hipotecznym zrobi id GOT01 jak dla got�wkowych

		w Przypadku hurtownii temat optymalizacji pr�dko�ci wchodzi mocniej w gr�, dlatego w systemach raportowych
		dodanie takich kluczy to dobra praktyka stosowana prawie zawsze

		cd. pod kodem

	*/

	IF DB_ID('TestSalon') IS NULL CREATE DATABASE TestSalon	
	GO

	USE TestSalon
	GO

	DROP TABLE IF EXISTS Brand
	DROP TABLE IF EXISTS Models
	GO

	CREATE TABLE Brand
	(
		Bra_Id		SMALLINT		NOT NULL	IDENTITY(1,1) PRIMARY KEY	--	techniczny
	,	Bra_Code	VARCHAR(10)		NOT NULL	UNIQUE						--	biznesowy
	,	Bra_Name	VARCHAR(100)	NOT NULL
	)

	CREATE TABLE Models
	(
		Mod_Id		SMALLINT		NOT NULL	IDENTITY(1,1) PRIMARY KEY	--	techniczny
	,	Mod_Code	VARCHAR(10)		NOT NULL	UNIQUE						--	biznesowy
	,	Mod_Name	VARCHAR(100)	NOT NULL
	,	Bra_Id		SMALLINT		NOT NULL								--	FK na techniczny

	,	CONSTRAINT	FK_Bra_Id
		FOREIGN KEY (Bra_Id)
		REFERENCES	Brand(Bra_Id)
	)

	/*
		wstawianie danych - Marki
	*/

	INSERT INTO Brand
	VALUES
		('JEEP',	'JEEP, Fiat Chrysler Automobiles (FCA) US LLC'),
		('FORD',	'Ford Motor Company')

	SELECT *
	FROM Brand

	/*
		wstawianie danych - Modele
		do tabeli modeli chcemy wpisa� konkretne pozycje w raz z FK do (Bra_Id), gdyby�my to robili raz, to mo�na:
			- sprawdzi� odpowienie Bra_Id i sobie spisa�
			- wstawi� wiersz u�ywaj�c tego Id.

		cd. pod kodem
	*/

	INSERT INTO Models
	VALUES
		('GRCH',	'GRAND CHEROKEE', 1)

	/*
		w aplikacji GUI, kt�rej u�yje pracownik dzia�a� mo�e to tak, 
		�e drop-down modeli zbudowany jest na li�cie klucz-warto��: pracownik wybiera "JEEP" a pod spodem wstawiane jest "1"
	
		zadanie w projekcie polega na tym, �eby w �adnym miejscu kodu nie u�ywa� wbitych na sztywno warto�ci kluczy
		kod ma by� odporny na zmiany -> gdybym przed insertem JEEP'a w linijce 61 wstawi� jeden wiersz
		to on dosta�by IDENTITY = 1 i ca�y kod przestaje dzia�a�.

		mo�na to zrobi� np. tak:
	*/

		INSERT INTO Models(Mod_Code, Mod_Name, Bra_Id)
		SELECT
			M.Mod_Code
		,	M.Mod_Name
		,	B.Bra_Id
		FROM 
		(
			SELECT 'COMP',	'COMPASS'	, 'JEEP' UNION ALL
			SELECT 'CHER',	'CHEROKEE'	, 'JEEP' UNION ALL
			SELECT 'RENE',	'RENEGADE'	, 'JEEP' UNION ALL
			SELECT 'WRAN',	'WRANGLER'	, 'JEEP'
		) AS M(Mod_Code, Mod_Name, Bra_Code)
		INNER JOIN Brand AS B  ON M.Bra_Code = B.Bra_Code

		SELECT *
		FROM Models

	/*
		albo
	*/

		INSERT INTO Models(Mod_Code, Mod_Name, Bra_Id)
		SELECT
			M.Mod_Code
		,	M.Mod_Name
		,	B.Bra_Id
		FROM 
		(
			VALUES
				('FIES',	'FIESTA'			, 'FORD')
			,	('TOUR',	'TOURNEO COURIER'	, 'FORD')
			,	('ECOS',	'ECOSPORT'			, 'FORD')
			,	('MUST',	'MUSTANG'			, 'FORD')
		) AS M(Mod_Code, Mod_Name, Bra_Code)
		INNER JOIN Brand AS B  ON M.Bra_Code = B.Bra_Code
