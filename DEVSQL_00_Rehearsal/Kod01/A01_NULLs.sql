USE ContosoRetailDW
GO

	--	IS NULL 

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE [SizeRange] IS NULL

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE [SizeRange] IS NOT NULL

	--	UWAGA !! 
	--	w przypadku warto�ci NULL nie dzia�a por�wnywanie za pomoc� =,<,>,<=,>=, IN
	--	logika tr�jwarto�ciowa (3VL)
	--	w przypadku warunku NULL = NULL , SQL czyta to jako: "czy warto�� nieznana po lewej jest taka jak warto�� nieznana po prawej" 
	--	nie mo�na odpowiedzie� TRUE/FALSE

	--	temat cz�sto poruszany na rozmowach rekrutacyjnych

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE [SizeRange] = NULL

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE [SizeRange] <> NULL

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE 1 = 1

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE NULL = NULL

		SELECT [SizeRange], *
		FROM [dbo].[DimProduct]
		WHERE NULL <> NULL	
