IF NOT EXISTS (SELECT * FROM [dbo].[VideoProfile])
	INSERT INTO [dbo].[Button]
			([Id],		[Name],				[VCodec],			[SdiVideoMode],	[Value])
		   VALUES
			(NEWID(), 	'720p 50 fps',		'HDSDI 720 hp50',	'hp50',			'720p50'),
			(NEWID(), 	'1080i 59.94 fps',	'HDSDI 1080 Hi59', 	'Hi59',			'1080i59'),
			(NEWID(), 	'720x576 25 pfs', 	'HDSDI 576 pal', 	'pal', 			'PALSD'),
			(NEWID(), 	'1080i 25 fps', 	'HDSDI 1080 Hi50', 	'Hi50',			'1080i50'),
			(NEWID(), 	'720p 60 fps', 		'HDSDI 720 hp60', 	'hp60',			'720p60'),
			(NEWID(), 	'480i',				'HDSDI 486 ntsc', 	'ntsc',			'480i'),
			(NEWID(), 	'1080p 25 fps', 	'HDSDI 1080 Hp25', 	'Hp25',			'1080p50'),
			(NEWID(), 	'1080i 30 fps', 	'HDSDI 1080 Hi60', 	'Hi60',			'1080i60'),
			(NEWID(), 	'720p 59.94 fps', 	'HDSDI 720 hp59', 	'hp59',			'720p59')
Go

