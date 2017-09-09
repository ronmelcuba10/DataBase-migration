
IF NOT EXISTS (SELECT * FROM [dbo].[Country])
	INSERT INTO [dbo].[Country]
			   ([Id]
			   ,[Code]
			   ,[Name])
		 VALUES
				(NEWID(), 'US', 'United States'),
				(NEWID(), 'AD', 'Andorra'),
				(NEWID(), 'AE', 'United Arab Emirates'),
				(NEWID(), 'AF', 'Afghanistan'),
				(NEWID(), 'AG', 'Antigua and Barbuda'),
				(NEWID(), 'AI', 'Anguilla'),
				(NEWID(), 'AL', 'Albania'),
				(NEWID(), 'AM', 'Armenia'),
				(NEWID(), 'AO', 'Angola'),
				(NEWID(), 'AQ', 'Antarctica'),
				(NEWID(), 'AR', 'Argentina'),
				(NEWID(), 'AS', 'American Samoa'),
				(NEWID(), 'AT', 'Austria'),
				(NEWID(), 'AU', 'Australia'),
				(NEWID(), 'AW', 'Aruba'),
				(NEWID(), 'AX', 'Aland'),
				(NEWID(), 'AZ', 'Azerbaijan'),
				(NEWID(), 'BA', 'Bosnia and Herzegovina'),
				(NEWID(), 'BB', 'Barbados'),
				(NEWID(), 'BD', 'Bangladesh'),
				(NEWID(), 'BE', 'Belgium'),
				(NEWID(), 'BF', 'Burkina Faso'),
				(NEWID(), 'BG', 'Bulgaria'),
				(NEWID(), 'BH', 'Bahrain'),
				(NEWID(), 'BI', 'Burundi'),
				(NEWID(), 'BJ', 'Benin'),
				(NEWID(), 'BL', 'Saint Barth�lemy'),
				(NEWID(), 'BM', 'Bermuda'),
				(NEWID(), 'BN', 'Brunei'),
				(NEWID(), 'BO', 'Bolivia'),
				(NEWID(), 'BQ', 'Bonaire'),
				(NEWID(), 'BR', 'Brazil'),
				(NEWID(), 'BS', 'Bahamas'),
				(NEWID(), 'BT', 'Bhutan'),
				(NEWID(), 'BV', 'Bouvet Island'),
				(NEWID(), 'BW', 'Botswana'),
				(NEWID(), 'BY', 'Belarus'),
				(NEWID(), 'BZ', 'Belize'),
				(NEWID(), 'CA', 'Canada'),
				(NEWID(), 'CC', 'Cocos [Keeling] Islands'),
				(NEWID(), 'CD', 'Democratic Republic of the Congo'),
				(NEWID(), 'CF', 'Central African Republic'),
				(NEWID(), 'CG', 'Republic of the Congo'),
				(NEWID(), 'CH', 'Switzerland'),
				(NEWID(), 'CI', 'Ivory Coast'),
				(NEWID(), 'CK', 'Cook Islands'),
				(NEWID(), 'CL', 'Chile'),
				(NEWID(), 'CM', 'Cameroon'),
				(NEWID(), 'CN', 'China'),
				(NEWID(), 'CO', 'Colombia'),
				(NEWID(), 'CR', 'Costa Rica'),
				(NEWID(), 'CU', 'Cuba'),
				(NEWID(), 'CV', 'Cape Verde'),
				(NEWID(), 'CW', 'Curacao'),
				(NEWID(), 'CX', 'Christmas Island'),
				(NEWID(), 'CY', 'Cyprus'),
				(NEWID(), 'CZ', 'Czechia'),
				(NEWID(), 'DE', 'Germany'),
				(NEWID(), 'DJ', 'Djibouti'),
				(NEWID(), 'DK', 'Denmark'),
				(NEWID(), 'DM', 'Dominica'),
				(NEWID(), 'DO', 'Dominican Republic'),
				(NEWID(), 'DZ', 'Algeria'),
				(NEWID(), 'EC', 'Ecuador'),
				(NEWID(), 'EE', 'Estonia'),
				(NEWID(), 'EG', 'Egypt'),
				(NEWID(), 'EH', 'Western Sahara'),
				(NEWID(), 'ER', 'Eritrea'),
				(NEWID(), 'ES', 'Spain'),
				(NEWID(), 'ET', 'Ethiopia'),
				(NEWID(), 'FI', 'Finland'),
				(NEWID(), 'FJ', 'Fiji'),
				(NEWID(), 'FK', 'Falkland Islands'),
				(NEWID(), 'FM', 'Micronesia'),
				(NEWID(), 'FO', 'Faroe Islands'),
				(NEWID(), 'FR', 'France'),
				(NEWID(), 'GA', 'Gabon'),
				(NEWID(), 'GB', 'United Kingdom'),
				(NEWID(), 'GD', 'Grenada'),
				(NEWID(), 'GE', 'Georgia'),
				(NEWID(), 'GF', 'French Guiana'),
				(NEWID(), 'GG', 'Guernsey'),
				(NEWID(), 'GH', 'Ghana'),
				(NEWID(), 'GI', 'Gibraltar'),
				(NEWID(), 'GL', 'Greenland'),
				(NEWID(), 'GM', 'Gambia'),
				(NEWID(), 'GN', 'Guinea'),
				(NEWID(), 'GP', 'Guadeloupe'),
				(NEWID(), 'GQ', 'Equatorial Guinea'),
				(NEWID(), 'GR', 'Greece'),
				(NEWID(), 'GS', 'South Georgia and the South Sandwich Islands'),
				(NEWID(), 'GT', 'Guatemala'),
				(NEWID(), 'GU', 'Guam'),
				(NEWID(), 'GW', 'Guinea-Bissau'),
				(NEWID(), 'GY', 'Guyana'),
				(NEWID(), 'HK', 'Hong Kong'),
				(NEWID(), 'HM', 'Heard Island and McDonald Islands'),
				(NEWID(), 'HN', 'Honduras'),
				(NEWID(), 'HR', 'Croatia'),
				(NEWID(), 'HT', 'Haiti'),
				(NEWID(), 'HU', 'Hungary'),
				(NEWID(), 'ID', 'Indonesia'),
				(NEWID(), 'IE', 'Ireland'),
				(NEWID(), 'IL', 'Israel'),
				(NEWID(), 'IM', 'Isle of Man'),
				(NEWID(), 'IN', 'India'),
				(NEWID(), 'IO', 'British Indian Ocean Territory'),
				(NEWID(), 'IQ', 'Iraq'),
				(NEWID(), 'IR', 'Iran'),
				(NEWID(), 'IS', 'Iceland'),
				(NEWID(), 'IT', 'Italy'),
				(NEWID(), 'JE', 'Jersey'),
				(NEWID(), 'JM', 'Jamaica'),
				(NEWID(), 'JO', 'Jordan'),
				(NEWID(), 'JP', 'Japan'),
				(NEWID(), 'KE', 'Kenya'),
				(NEWID(), 'KG', 'Kyrgyzstan'),
				(NEWID(), 'KH', 'Cambodia'),
				(NEWID(), 'KI', 'Kiribati'),
				(NEWID(), 'KM', 'Comoros'),
				(NEWID(), 'KN', 'Saint Kitts and Nevis'),
				(NEWID(), 'KP', 'North Korea'),
				(NEWID(), 'KR', 'South Korea'),
				(NEWID(), 'KW', 'Kuwait'),
				(NEWID(), 'KY', 'Cayman Islands'),
				(NEWID(), 'KZ', 'Kazakhstan'),
				(NEWID(), 'LA', 'Laos'),
				(NEWID(), 'LB', 'Lebanon'),
				(NEWID(), 'LC', 'Saint Lucia'),
				(NEWID(), 'LI', 'Liechtenstein'),
				(NEWID(), 'LK', 'Sri Lanka'),
				(NEWID(), 'LR', 'Liberia'),
				(NEWID(), 'LS', 'Lesotho'),
				(NEWID(), 'LT', 'Lithuania'),
				(NEWID(), 'LU', 'Luxembourg'),
				(NEWID(), 'LV', 'Latvia'),
				(NEWID(), 'LY', 'Libya'),
				(NEWID(), 'MA', 'Morocco'),
				(NEWID(), 'MC', 'Monaco'),
				(NEWID(), 'MD', 'Moldova'),
				(NEWID(), 'ME', 'Montenegro'),
				(NEWID(), 'MF', 'Saint Martin'),
				(NEWID(), 'MG', 'Madagascar'),
				(NEWID(), 'MH', 'Marshall Islands'),
				(NEWID(), 'MK', 'Macedonia'),
				(NEWID(), 'ML', 'Mali'),
				(NEWID(), 'MM', 'Myanmar [Burma]'),
				(NEWID(), 'MN', 'Mongolia'),
				(NEWID(), 'MO', 'Macao'),
				(NEWID(), 'MP', 'Northern Mariana Islands'),
				(NEWID(), 'MQ', 'Martinique'),
				(NEWID(), 'MR', 'Mauritania'),
				(NEWID(), 'MS', 'Montserrat'),
				(NEWID(), 'MT', 'Malta'),
				(NEWID(), 'MU', 'Mauritius'),
				(NEWID(), 'MV', 'Maldives'),
				(NEWID(), 'MW', 'Malawi'),
				(NEWID(), 'MX', 'Mexico'),
				(NEWID(), 'MY', 'Malaysia'),
				(NEWID(), 'MZ', 'Mozambique'),
				(NEWID(), 'NA', 'Namibia'),
				(NEWID(), 'NC', 'New Caledonia'),
				(NEWID(), 'NE', 'Niger'),
				(NEWID(), 'NF', 'Norfolk Island'),
				(NEWID(), 'NG', 'Nigeria'),
				(NEWID(), 'NI', 'Nicaragua'),
				(NEWID(), 'NL', 'Netherlands'),
				(NEWID(), 'NO', 'Norway'),
				(NEWID(), 'NP', 'Nepal'),
				(NEWID(), 'NR', 'Nauru'),
				(NEWID(), 'NU', 'Niue'),
				(NEWID(), 'NZ', 'New Zealand'),
				(NEWID(), 'OM', 'Oman'),
				(NEWID(), 'PA', 'Panama'),
				(NEWID(), 'PE', 'Peru'),
				(NEWID(), 'PF', 'French Polynesia'),
				(NEWID(), 'PG', 'Papua New Guinea'),
				(NEWID(), 'PH', 'Philippines'),
				(NEWID(), 'PK', 'Pakistan'),
				(NEWID(), 'PL', 'Poland'),
				(NEWID(), 'PM', 'Saint Pierre and Miquelon'),
				(NEWID(), 'PN', 'Pitcairn Islands'),
				(NEWID(), 'PR', 'Puerto Rico'),
				(NEWID(), 'PS', 'Palestine'),
				(NEWID(), 'PT', 'Portugal'),
				(NEWID(), 'PW', 'Palau'),
				(NEWID(), 'PY', 'Paraguay'),
				(NEWID(), 'QA', 'Qatar'),
				(NEWID(), 'RE', 'R�union'),
				(NEWID(), 'RO', 'Romania'),
				(NEWID(), 'RS', 'Serbia'),
				(NEWID(), 'RU', 'Russia'),
				(NEWID(), 'RW', 'Rwanda'),
				(NEWID(), 'SA', 'Saudi Arabia'),
				(NEWID(), 'SB', 'Solomon Islands'),
				(NEWID(), 'SC', 'Seychelles'),
				(NEWID(), 'SD', 'Sudan'),
				(NEWID(), 'SE', 'Sweden'),
				(NEWID(), 'SG', 'Singapore'),
				(NEWID(), 'SH', 'Saint Helena'),
				(NEWID(), 'SI', 'Slovenia'),
				(NEWID(), 'SJ', 'Svalbard and Jan Mayen'),
				(NEWID(), 'SK', 'Slovakia'),
				(NEWID(), 'SL', 'Sierra Leone'),
				(NEWID(), 'SM', 'San Marino'),
				(NEWID(), 'SN', 'Senegal'),
				(NEWID(), 'SO', 'Somalia'),
				(NEWID(), 'SR', 'Suriname'),
				(NEWID(), 'SS', 'South Sudan'),
				(NEWID(), 'ST', 'S�o Tom� and Pr�ncipe'),
				(NEWID(), 'SV', 'El Salvador'),
				(NEWID(), 'SX', 'Sint Maarten'),
				(NEWID(), 'SY', 'Syria'),
				(NEWID(), 'SZ', 'Swaziland'),
				(NEWID(), 'TC', 'Turks and Caicos Islands'),
				(NEWID(), 'TD', 'Chad'),
				(NEWID(), 'TF', 'French Southern Territories'),
				(NEWID(), 'TG', 'Togo'),
				(NEWID(), 'TH', 'Thailand'),
				(NEWID(), 'TJ', 'Tajikistan'),
				(NEWID(), 'TK', 'Tokelau'),
				(NEWID(), 'TL', 'East Timor'),
				(NEWID(), 'TM', 'Turkmenistan'),
				(NEWID(), 'TN', 'Tunisia'),
				(NEWID(), 'TO', 'Tonga'),
				(NEWID(), 'TR', 'Turkey'),
				(NEWID(), 'TT', 'Trinidad and Tobago'),
				(NEWID(), 'TV', 'Tuvalu'),
				(NEWID(), 'TW', 'Taiwan'),
				(NEWID(), 'TZ', 'Tanzania'),
				(NEWID(), 'UA', 'Ukraine'),
				(NEWID(), 'UG', 'Uganda'),
				(NEWID(), 'UM', 'U.S. Minor Outlying Islands'),
				(NEWID(), 'UY', 'Uruguay'),
				(NEWID(), 'UZ', 'Uzbekistan'),
				(NEWID(), 'VA', 'Vatican City'),
				(NEWID(), 'VC', 'Saint Vincent and the Grenadines'),
				(NEWID(), 'VE', 'Venezuela'),
				(NEWID(), 'VG', 'British Virgin Islands'),
				(NEWID(), 'VI', 'U.S. Virgin Islands'),
				(NEWID(), 'VN', 'Vietnam'),
				(NEWID(), 'VU', 'Vanuatu'),
				(NEWID(), 'WF', 'Wallis and Futuna'),
				(NEWID(), 'WS', 'Samoa'),
				(NEWID(), 'XK', 'Kosovo'),
				(NEWID(), 'YE', 'Yemen'),
				(NEWID(), 'YT', 'Mayotte'),
				(NEWID(), 'ZA', 'South Africa'),
				(NEWID(), 'ZM', 'Zambia'),
				(NEWID(), 'ZW', 'Zimbabwe')
GO





