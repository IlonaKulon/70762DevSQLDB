
--	Indeks:...........................................................
--	Imi� i Nazwisko...................................................

--	(1)
----------------------------------------------------------------------------------------------------------------
--	utworzy� baz� danych o nazwie [Kolokwium_XXXXXX]
--	w miejsce XXXXXX wpisa� swoj numer indeksu
--	prze��czy� kontekst na t� baz� (polecenie USE ...)

	--	<< tu wpisz kod >>

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

	--	<< tu wpisz kod >>

--	(3)
----------------------------------------------------------------------------------------------------------------
--	w tabeli z danymi pracowniczymi na kolumnie z numerycznym ID, utworzy� PRIMARY KEY
--	mo�na to zrobi� ju� w punkcie drugim lub osobno tutaj (jak Pa�stwu wygodniej)
----------------------------------------------------------------------------------------------------------------

	--	<< tu wpisz kod >>


--	(4)
----------------------------------------------------------------------------------------------------------------
--	napisa� kod, kt�ry za�aduje dane do tabel utworzonych w punkcie (2)
--	u�y� kodu przygotowanego w pliku z danymi
--
--	np. ... INSERT INTO/VALUES
----------------------------------------------------------------------------------------------------------------
	
	--	<< tu wpisz kod >>


--	(5)
----------------------------------------------------------------------------------------------------------------
--	utworzy� widok, 
--	kt�ry zwr�ci pracownik�w maj�cych w nazwie ci�g "Pracownik Szeregowy A"
----------------------------------------------------------------------------------------------------------------
	
	--	<< tu wpisz kod >>


--	(6)
----------------------------------------------------------------------------------------------------------------
--	napisa� zapytanie, kt�re zwr�ci list� pracownik�w (Id oraz nazwa)
--	oraz sumaryczne koszty przypisane do nich

--	... np. JOIN/GROUP BY/SUM()
----------------------------------------------------------------------------------------------------------------
	
	--	<< tu wpisz kod >>


--	(7)
----------------------------------------------------------------------------------------------------------------
--	napisa� zapytanie, kt�re zwr�ci list� dziesi�ciu najwi�kszych poniesionych koszt�w
--	do zapytania doda� kolumn� kt�re numeruje je od najwi�kszego do najmniejszego

--	... np. TOP/ORDER BY/ROW_NUMBER
----------------------------------------------------------------------------------------------------------------
	
	--	<< tu wpisz kod >>

--	(8)
----------------------------------------------------------------------------------------------------------------
--	skasowa� z tabeli z pracownikami wszytkich pracownik�w o nazwie zaczynaj�cej si� na "Pracownik Szeregowy"
--
--	... DELETE/WHERE/LIKE
----------------------------------------------------------------------------------------------------------------


--	(9)
----------------------------------------------------------------------------------------------------------------
--	zrobi� UPDATE na tabeli z kosztami

--	po skasowaniu pracownik�w w punkcie 8 w tabeli pozostan� wpisy z ID pracownik�w, kt�rzy ju� nie istniej� w bazie
--	bo zostali skasowani, we wszystkich takich przypadkach prosz� nadpisa� w tabeli koszt�w ID pracownika na (-1)
--
--	UPDATE/JOIN/IS NULL
----------------------------------------------------------------------------------------------------------------


--	(10*) - nieobowi�zkowe, dodatkowe punkty do oceny ko�cowej z przedmiotu
-------------------------------------------------------------
--	napisa� zapytanie kt�re zwraca koszty wygenerowane przez 
--	wszystkich pracownik�w podlegaj�cych pod "Kierownik Zespo�u A"
--	u�y� rekurencyjnego CTE do wygenerowania listy pracownik�w

--	zapytanie zapisa� w postaci funkcji tabelarycznej
--	a nazw� pracownika "Kierownik Zespo�u A" sparametryzowa�
-------------------------------------------------------------
	
	--	<< tu wpisz kod >>
