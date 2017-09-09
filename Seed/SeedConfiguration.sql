IF NOT EXISTS (SELECT * FROM [dbo].[Configuration])
	INSERT INTO [dbo].[Configuration]
           ([Id]
           ,[Name]
           ,[IntValue]
           ,[StringValue])
     VALUES
			(NEWID(), 'BrowserTitleIconHeight',		48,		NULL),
			(NEWID(), 'PageImageFontSize',			25,		NULL),
			(NEWID(), 'MessageboxImageFontSize',	20,		NULL),
			(NEWID(), 'TimeSyncInterval',			86400,	NULL),
			(NEWID(), 'CheckInterval',				8000,	NULL),
			(NEWID(), 'LogSize',					4000,	NULL),
			(NEWID(), 'BrowserTitleIconWidth',		48,		NULL),
			(NEWID(), 'ButtonImageFontSize',		20,		NULL),
			(NEWID(), 'MasterTimeSource',			0,		'pool.ntp.org'),
			(NEWID(), 'TimesBetweenFullUpdate',		3,		NULL),
			(NEWID(), 'ButtonImageLeftPadding',		20,		NULL),
			(NEWID(), 'DashboardImageFontSize',		20,		NULL)

GO