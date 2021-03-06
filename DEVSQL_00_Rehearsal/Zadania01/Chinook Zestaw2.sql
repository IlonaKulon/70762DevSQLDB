USE [Chinook]
GO

--	01
--------------------------------------------------------------
--	wyświetlić wszystkie piosenki, które pojawiły sie na playlistach:
--	Music, Movies, TV Shows

	SELECT
		[p].[Name]
	,	[t].[Name]
	FROM
		[dbo].[Playlist]				AS [p]
	INNER JOIN [dbo].[PlaylistTrack] AS [pt] ON [pt].[PlaylistId] = [p].[PlaylistId]
	INNER JOIN [dbo].[Track]	AS [t] ON [t].[TrackId]			= [pt].[TrackId]
	WHERE
		[p].[Name] IN ( 'Music', 'Movies', 'TV Shows' );

--	02
--------------------------------------------------------------
--	wyświedlić wszystkie playlisty, na których pojawiły się piosenki zespołów:
--	AC/DC, Black Sabbath, Metallica

	SELECT	DISTINCT
			[p].[Name]
	FROM
		[dbo].[Playlist]				AS [p]
	INNER JOIN [dbo].[PlaylistTrack] AS [pt] ON [pt].[PlaylistId] = [p].[PlaylistId]
	INNER JOIN [dbo].[Track]	AS [t] ON [t].[TrackId]			= [pt].[TrackId]
	INNER JOIN [dbo].[Album]	AS [a] ON [a].[AlbumId]			= [t].[AlbumId]
	INNER JOIN [dbo].[Artist]	AS [a2] ON [a2].[ArtistId]		= [a].[ArtistId]
	WHERE
		[a2].[Name] IN ( 'AC/DC', 'Black Sabbath', 'Metallica' );

--	03
--------------------------------------------------------------
--	na podstawie zapytań 01 oraz 02 utworzyć widoki

--	04
--------------------------------------------------------------
--	na podstawie zapytań 01 oraz 02 utworzyć funkcje tabelaryczne
--	w 01 ustawić nazwę playlisty w parametrze
--	w 02 ustawić nazwę zespołu w parametrze

--	05*
--------------------------------------------------------------
--	zmienić kod procedury tak, aby podanie w parametrze NULL
--	wyświetlało wszystkie dane



