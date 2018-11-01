--	SQL Server 2008 przechowuje wszystkie istotne informacje o rozszerzonych zdarzeniach w 8 widokach katalogowych, 
--	z kt�rych najwa�niejsze to:
  
	--	sys.dm_xe_packages			� zwraca list� paczek (paczka jest identyfikowana przez nazw� i GUID),
	--	sys.dm_xe_objects			� zwraca list� obiekt�w zawartych w paczkach,
	--	sys.dm_xe_object_columns	� zwraca list� kolumn opisuj�cych obiekty znajduj�ce si� w paczkach.

--	Opr�cz tego do dyspozycji administrator�w s� dynamiczne widoki zarz�dzane (DMV), 
--	kt�re umo�liwiaj� monitorowanie sesji przechwytywania rozszerzonych zdarze�:

	--	sys.dm_xe_sessions � zwraca informacje o aktywnych sesjach
	--	sys.dm_xe_session_targets � zwraca informacje o docelowych obiektach sesji
	--	sys.dm_xe_session_events � zwraca informacje o zdarzeniach w sesjach
	--	sys.dm_xe_session_event_actions � zwraca informacje o akcjach w sesjach
	--	sys.dm_xe_map_values � zwraca odpowiedniki tekstowe map
	--	sys.dm_xe_session_object_columns - zwraca informacje o konfiguracji sesji

--	Istnieje co najmniej kilka scenariusz�w, w kt�rych zastosowanie mechanizmu rozszerzonych zdarze� wydaje si� doskona�ym rozwi�zaniem:

	--	rozwi�zywanie problem�w z zakleszczaniem (deadlocks)
	--	rozwi�zywanie problem�w wynikaj�cych z nadmiernego zu�ycia zasob�w procesora
	--	diagnozowanie problem�w z pami�ci� serwera
	--	powi�zanie zdarze� wyst�puj�cych na serwerze SQL ze zdarzeniami z systemu operacyjnego

--	Podsumowuj�c w�tek teoretyczny mo�na oceni�, i� mechanizm XE jest jednym z najpot�niejszych, 
--	jakie kiedykolwiek mieli administratorzy baz danych do swojej dyspozycji. 
--	Na tym mechanizmie zbudowano np. inn� funkcjonalno�� � Database Audit.