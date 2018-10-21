	----------------------------------------------------------------
	--	Database Fundamentals																							
	--	z04s03
	----------------------------------------------------------------

	--	utworzenie bazy
	-------------------------------------------
    
		USE [master]
		GO
    
		IF DB_ID('DMLAdv') IS NOT NULL DROP DATABASE DMLAdv
		GO
    
		CREATE DATABASE [DMLAdv]
		GO
    
		USE [DMLAdv]
		GO
    
    
	--	utworzenie tabeli
	-------------------------------------------
    		
		IF OBJECT_ID('tabela1') IS NOT NULL DROP TABLE [dbo].[tabela1]
		IF OBJECT_ID('tabela2') IS NOT NULL DROP TABLE [dbo].[tabela2]
    
		CREATE TABLE [dbo].[tabela1]
		(
    		tab_key	INT PRIMARY KEY NOT NULL,
    		tab_val	VARCHAR(100) NULL
		)	
    		
		CREATE TABLE [dbo].[tabela2]
		(
    		tab_key	INT PRIMARY KEY NOT NULL,
    		tab_val	VARCHAR(100) NULL
		)			
    
		INSERT INTO [dbo].[tabela1]
		VALUES
    			( 1,'Stara warto�� 1'),
    			( 2,'Stara warto�� 2'),
    			( 3,'Stara warto�� 3'),
    			( 4,'Stara warto�� 4'),
    			( 5,'Stara warto�� 5'),
    			( 6,'Stara warto�� 6'),
    			( 7,'Stara warto�� 7')
    
		INSERT INTO [dbo].[tabela2]
		VALUES
    			( 1,'Nowa warto�� 1'),
    			( 2,'Nowa warto�� 2'),
    			( 3,'Nowa warto�� 3'),
    			( 4,'Nowa warto�� 4')
    
	--	UPDATE
	-------------------------------------------
    
		-- w tabeli 1 nadpisz warto�� zgodnie z danymy w tabeli 2
    
		UPDATE		[t]
		SET			[t].[tab_val] = [t2].[tab_val]
		FROM 
    				[dbo].[tabela1] AS [t]
		INNER JOIN	[dbo].[tabela2] AS [t2] ON [t2].[tab_key] = [t].[tab_key]
    
		SELECT *
		FROM [dbo].[tabela1] AS [t]
    
	--	DELETE
	-------------------------------------------
    
		-- z tabeli 1 skasuj wiersze wyst�puj�ce w tabeli 2
    
		DELETE		[t]
		FROM 
    				[dbo].[tabela1] AS [t]
		INNER JOIN	[dbo].[tabela2] AS [t2] ON [t2].[tab_key] = [t].[tab_key]
    
		SELECT *
		FROM [dbo].[tabela1] AS [t]
    
	--	sprz�tamy - kasowanie bazy
	-------------------------------------------
    
		USE [master]
		GO
    
		IF DB_ID('DMLAdv') IS NOT NULL DROP DATABASE [DMLAdv]
		GO
