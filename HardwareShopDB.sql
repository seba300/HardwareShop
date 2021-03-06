USE [master]
GO
/****** Object:  Database [HardwareStore]    Script Date: 26.05.2020 12:01:36 ******/
-- usunięto linijki 5-10 które wskazywały ścieżke bezwględną gdzie pliki mają się utworzyć
-- dodanie funkcji sprawdzającej czy baza istnieje, jeśli ta to jest usuwana
IF EXISTS
(
SELECT name FROM master.dbo.sysdatabases
WHERE name = N'HardwareStore')
BEGIN 
	DROP DATABASE HardwareStore
END
GO
--
CREATE DATABASE [HardwareStore]
GO
 
ALTER DATABASE [HardwareStore] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HardwareStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HardwareStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HardwareStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HardwareStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HardwareStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HardwareStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [HardwareStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HardwareStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HardwareStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HardwareStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HardwareStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HardwareStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HardwareStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HardwareStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HardwareStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HardwareStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HardwareStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HardwareStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HardwareStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HardwareStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HardwareStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HardwareStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HardwareStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HardwareStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HardwareStore] SET  MULTI_USER 
GO
ALTER DATABASE [HardwareStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HardwareStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HardwareStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HardwareStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HardwareStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HardwareStore] SET QUERY_STORE = OFF
GO
USE [HardwareStore]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 26.05.2020 12:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[IDcategory] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Picture] [image] NULL,
	[Vat] [smallint] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[IDcategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 26.05.2020 12:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[IDemployee] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Surname] [nvarchar](25) NOT NULL,
	[Position] [nvarchar](40) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[EmploymentDate] [datetime] NOT NULL,
	[Address] [nvarchar](60) NOT NULL,
	[City] [nvarchar](20) NOT NULL,
	[Region] [nvarchar](20) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[PhoneNumber] [nvarchar](24) NOT NULL,
	[Photo] [image] NULL,
	[Comments] [nvarchar](max) NULL,
	[Chief] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDemployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order Details]    Script Date: 26.05.2020 12:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[IDorder] [int] NOT NULL,
	[IDproduct] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Vat] [smallint] NOT NULL,
	[Discount] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Order Details] PRIMARY KEY CLUSTERED 
(
	[IDorder] ASC,
	[IDproduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 26.05.2020 12:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[IDorder] [int] IDENTITY(1,1) NOT NULL,
	[IDemployee] [int] NOT NULL,
	[SellDate] [date] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[IDorder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 26.05.2020 12:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[IDproduct] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[UnitQuantity] [nvarchar](255) NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[InventoryState] [int] NOT NULL,
	[Discontinued] [bit] NOT NULL,
	[IDcategory] [int] NOT NULL,
	[Discount] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[IDproduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 26.05.2020 12:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[IDemployee] [int] NOT NULL,
	[Login] [varchar](10) COLLATE Polish_CS_AS NOT NULL,
	[Password] [varchar](60) COLLATE Polish_CS_AS NOT NULL,
	[IDuser] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[IDuser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([IDcategory], [CategoryName], [Description], [Picture], [Vat]) VALUES (1, N'Narzędzia ręczne', N'Narzędzia podstawowe, łączeniowe, pomiarowe, malarskie, budowlane, mechaniczne, tnące', NULL, 23)
INSERT [dbo].[Categories] ([IDcategory], [CategoryName], [Description], [Picture], [Vat]) VALUES (2, N'Elektronarzędzia', N'Narzędzia elektryczne: wiertartki, wkrętarki, szlifierki, pilarki, wyrzyniarki, lutownice', NULL, 5)
INSERT [dbo].[Categories] ([IDcategory], [CategoryName], [Description], [Picture], [Vat]) VALUES (4, N'Narzędzia do ogrodu', N'Narzędzia elektryczne jak i ręczne, wykorzystywane w ogrodzie', NULL, 8)
INSERT [dbo].[Categories] ([IDcategory], [CategoryName], [Description], [Picture], [Vat]) VALUES (6, N'Akcesoria do elektronarzędzi', N'Dłuta, Wiertła, Nasadki magnetyczne, Tarcze', NULL, 23)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([IDemployee], [Name], [Surname], [Position], [BirthDate], [EmploymentDate], [Address], [City], [Region], [ZipCode], [PhoneNumber], [Photo], [Comments], [Chief]) VALUES (4, N'Piotr', N'Błaszczykowski', N'Sprzedawca', CAST(N'1990-01-01T00:00:00.000' AS DateTime), CAST(N'2019-09-30T00:00:00.000' AS DateTime), N'Zawadzkiego 14', N'Ćwiklice', N'Śląsk', N'43-229', N'986132456', NULL, NULL, NULL)
INSERT [dbo].[Employees] ([IDemployee], [Name], [Surname], [Position], [BirthDate], [EmploymentDate], [Address], [City], [Region], [ZipCode], [PhoneNumber], [Photo], [Comments], [Chief]) VALUES (5, N'Anna', N'Wichrowska', N'Sprzedawca', CAST(N'1978-01-01T00:00:00.000' AS DateTime), CAST(N'2000-02-03T00:00:00.000' AS DateTime), N'Szczekocińska 24', N'Pszczyna', N'Śląsk', N'43-200', N'342123456', NULL, NULL, NULL)
INSERT [dbo].[Employees] ([IDemployee], [Name], [Surname], [Position], [BirthDate], [EmploymentDate], [Address], [City], [Region], [ZipCode], [PhoneNumber], [Photo], [Comments], [Chief]) VALUES (6, N'Szymon', N'Piepiura', N'Sprzedawca', CAST(N'1998-12-11T00:00:00.000' AS DateTime), CAST(N'2000-02-03T00:00:00.000' AS DateTime), N'Szczekocińska 25', N'Pszczyna', N'Śląsk', N'43-200', N'341423326', NULL, NULL, NULL)
INSERT [dbo].[Employees] ([IDemployee], [Name], [Surname], [Position], [BirthDate], [EmploymentDate], [Address], [City], [Region], [ZipCode], [PhoneNumber], [Photo], [Comments], [Chief]) VALUES (7, N'Sebastian', N'Soliwa', N'Magazynier', CAST(N'1998-05-21T00:00:00.000' AS DateTime), CAST(N'2001-06-03T00:00:00.000' AS DateTime), N'Hallera 12', N'Pszczyna', N'Śląsk', N'43-200', N'241423122', NULL, NULL, NULL)
INSERT [dbo].[Employees] ([IDemployee], [Name], [Surname], [Position], [BirthDate], [EmploymentDate], [Address], [City], [Region], [ZipCode], [PhoneNumber], [Photo], [Comments], [Chief]) VALUES (8, N'Michał', N'Skokowski', N'Magazynier', CAST(N'2000-07-02T00:00:00.000' AS DateTime), CAST(N'2018-07-04T00:00:00.000' AS DateTime), N'Willowa 12', N'Ćwiklice', N'Śląsk', N'43-229', N'987456123', NULL, NULL, NULL)
INSERT [dbo].[Employees] ([IDemployee], [Name], [Surname], [Position], [BirthDate], [EmploymentDate], [Address], [City], [Region], [ZipCode], [PhoneNumber], [Photo], [Comments], [Chief]) VALUES (9, N'Aneta', N'Żmuda', N'Szef', CAST(N'1980-07-02T00:00:00.000' AS DateTime), CAST(N'1999-01-01T00:00:00.000' AS DateTime), N'Willowa 26', N'Ćwiklice', N'Śląsk', N'43-229', N'478625741', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Employees] OFF
INSERT [dbo].[Order Details] ([IDorder], [IDproduct], [UnitPrice], [Quantity], [Vat], [Discount]) VALUES (1, 1, 106.7900, 2, 23, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Order Details] ([IDorder], [IDproduct], [UnitPrice], [Quantity], [Vat], [Discount]) VALUES (1, 6, 745.9600, 1, 5, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Order Details] ([IDorder], [IDproduct], [UnitPrice], [Quantity], [Vat], [Discount]) VALUES (2, 6, 745.9600, 4, 5, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Order Details] ([IDorder], [IDproduct], [UnitPrice], [Quantity], [Vat], [Discount]) VALUES (4, 9, 99.9900, 1, 8, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Order Details] ([IDorder], [IDproduct], [UnitPrice], [Quantity], [Vat], [Discount]) VALUES (5, 11, 35.9600, 4, 23, CAST(0.00 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([IDorder], [IDemployee], [SellDate]) VALUES (1, 4, CAST(N'2020-05-28' AS Date))
INSERT [dbo].[Orders] ([IDorder], [IDemployee], [SellDate]) VALUES (2, 7, CAST(N'2020-05-28' AS Date))
INSERT [dbo].[Orders] ([IDorder], [IDemployee], [SellDate]) VALUES (4, 7, CAST(N'2020-05-28' AS Date))
INSERT [dbo].[Orders] ([IDorder], [IDemployee], [SellDate]) VALUES (5, 9, CAST(N'2020-04-11' AS Date))
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (1, N'Młotek ślusarski 32.4cm Bosh', N'1 szt', 106.7900, 250, 0, 1, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (3, N'Młotek murarski 0.7kg JUCO', N'1 szt', 27.4900, 122, 0, 1, CAST(5.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (5, N'Wiertarko-wkrętarka 14,4V, 1,5Ah, GRAPHITE 58G218', N'1 szt', 179.0000, 54, 0, 2, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (6, N'Szlifierka kątowa 2600W, 230mm Makita', N'1 szt', 745.9600, 300, 0, 2, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (8, N'Łopata piaskowa z trzonkiem drewnianym T 100 cm', N'1 szt', 35.8000, 300, 0, 4, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (9, N'Grabie wachlarzowe z trzonkiem 130cm Gardena Combisystem 03022-20', N'1 szt', 99.9900, 15, 0, 4, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (10, N'Wiertło 117 mm HSS O: 8mm Bosch', N'1 szt', 34.8600, 1000, 0, 6, CAST(0.00 AS Decimal(4, 2)))
INSERT [dbo].[Products] ([IDproduct], [ProductName], [UnitQuantity], [UnitPrice], [InventoryState], [Discontinued], [IDcategory], [Discount]) VALUES (11, N'Dłuto 1 Piece 25 mm Beton RS PRO', N'1 szt', 35.9600, 1000, 0, 6, CAST(0.00 AS Decimal(4, 2)))
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([IDemployee], [Login], [Password], [IDuser]) VALUES (4, N'PBLASZCZYK', N'Haslo123', 1)
INSERT [dbo].[Users] ([IDemployee], [Login], [Password], [IDuser]) VALUES (9, N'AZMUDA', N'Haslo124', 2)
INSERT [dbo].[Users] ([IDemployee], [Login], [Password], [IDuser]) VALUES (7, N'SSOLIWA', N'Haslo125', 3)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON
GO

CREATE FUNCTION GetOrdersGross(@dateFrom date,@dateTo date)
RETURNS MONEY
AS
BEGIN
	RETURN 
	(
	SELECT ROUND(SUM(((UnitPrice-(UnitPrice*(Discount/100)))*Quantity)*(1+(CAST(Vat as float)/100))),2) AS [Orders gross]
	FROM [Order Details] INNER JOIN Orders ON [Order Details].IDorder=Orders.IDorder
	WHERE SellDate BETWEEN @dateFrom AND @dateTo
	);
END
GO
CREATE TABLE dbo.DDLEvents
(
    EventDate    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EventType    NVARCHAR(64),
    EventDDL     NVARCHAR(MAX),
    EventXML     XML,
    DatabaseName NVARCHAR(255),
    SchemaName   NVARCHAR(255),
    ObjectName   NVARCHAR(255),
    HostName     VARCHAR(64),
    IPAddress    VARCHAR(48),
    ProgramName  NVARCHAR(255),
    LoginName    NVARCHAR(255)
);
GO
CREATE TRIGGER DDLTrigger
    ON DATABASE
    FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE, CREATE_TRIGGER,ALTER_TRIGGER,DROP_TRIGGER,CREATE_FUNCTION,ALTER_FUNCTION,DROP_FUNCTION
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
        @EventData XML = EVENTDATA();
 
    DECLARE @ip varchar(48) = CONVERT(varchar(48), 
        CONNECTIONPROPERTY('client_net_address'));
 
    INSERT dbo.DDLEvents
    (
        EventType,
        EventDDL,
        EventXML,
        DatabaseName,
        SchemaName,
        ObjectName,
        HostName,
        IPAddress,
        ProgramName,
        LoginName
    )
    SELECT
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'), 
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        @EventData,
        DB_NAME(),
        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'), 
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
        HOST_NAME(),
        @ip,
        PROGRAM_NAME(),
        SUSER_SNAME();
END
GO
/****** Object:  Index [UQ__Categori__8517B2E077B2C54A]    Script Date: 26.05.2020 12:01:36 ******/
ALTER TABLE [dbo].[Categories] ADD UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Products__DD5A978A5BD81276]    Script Date: 26.05.2020 12:01:36 ******/
ALTER TABLE [dbo].[Products] ADD UNIQUE NONCLUSTERED 
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__5E55825BCD9D5185]    Script Date: 26.05.2020 12:01:36 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Users__FD0ADB804FA90903]    Script Date: 26.05.2020 12:01:36 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[IDemployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_OrdersPosition_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Order Details]  WITH CHECK ADD  CONSTRAINT [FK_OrdersPosition_Orders] FOREIGN KEY([IDorder])
REFERENCES [dbo].[Orders] ([IDorder])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_OrdersPosition_Orders]
GO
ALTER TABLE [dbo].[Order Details]  WITH CHECK ADD  CONSTRAINT [FK_OrdersPosition_Products] FOREIGN KEY([IDproduct])
REFERENCES [dbo].[Products] ([IDproduct])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_OrdersPosition_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([IDemployee])
REFERENCES [dbo].[Employees] ([IDemployee])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([IDcategory])
REFERENCES [dbo].[Categories] ([IDcategory])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Employees] FOREIGN KEY([IDemployee])
REFERENCES [dbo].[Employees] ([IDemployee])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Employees]
GO
USE [master]
GO
ALTER DATABASE [HardwareStore] SET  READ_WRITE 
GO

