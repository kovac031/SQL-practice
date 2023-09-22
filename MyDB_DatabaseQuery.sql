USE [master]
GO
/****** Object:  Database [MyDB]    Script Date: 22/09/2023 14:19:57 ******/
CREATE DATABASE [MyDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MyDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MyDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MyDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MyDB] SET  MULTI_USER 
GO
ALTER DATABASE [MyDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MyDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyDB', N'ON'
GO
ALTER DATABASE [MyDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [MyDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MyDB]
GO
/****** Object:  Table [dbo].[ThePeople]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThePeople](
	[Id] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[RegisteredOn] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheOrders]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheOrders](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderTime] [datetime] NOT NULL,
	[OrderAmount] [int] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheProducts]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheProducts](
	[Id] [uniqueidentifier] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[ProductPrice] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheOrdersTheProducts]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheOrdersTheProducts](
	[OrderId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PurchaseLog]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PurchaseLog] AS
SELECT 
    ThePeople.Id AS PersonId,
    ThePeople.FirstName,
    ThePeople.LastName,
    TheOrders.OrderTime,    
    TheProducts.ProductName,
    TheProducts.ProductPrice,
	TheOrders.OrderAmount
FROM 
    ThePeople
INNER JOIN 
    TheOrders ON ThePeople.Id = TheOrders.CustomerId
INNER JOIN 
    TheOrdersTheProducts ON TheOrders.Id = TheOrdersTheProducts.OrderId
INNER JOIN 
    TheProducts ON TheOrdersTheProducts.ProductId = TheProducts.Id;
GO
/****** Object:  View [dbo].[CustomerOverview]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerOverview] AS
SELECT 
    ThePeople.Id, 
    ThePeople.FirstName, 
    ThePeople.LastName,
    COUNT(TheOrders.Id) AS OrderAmountTotal,
    SUM(TheOrders.OrderAmount) AS MoneySpentTotal
FROM 
    ThePeople
LEFT JOIN 
    TheOrders ON ThePeople.Id = TheOrders.CustomerId
GROUP BY 
    ThePeople.Id, ThePeople.FirstName, ThePeople.LastName;
GO
/****** Object:  View [dbo].[ProductSalesOverview]    Script Date: 22/09/2023 14:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductSalesOverview] AS
SELECT 
	Prod.Id,
    Prod.ProductName, 
	Prod.ProductPrice,
    COUNT(OrdProd.OrderId) AS OrderQuantityTotal,
    SUM(Ord.OrderAmount * Prod.ProductPrice) AS RevenueGeneratedTotal
FROM 
    TheProducts Prod -- malo da vjezbam te skracenice
LEFT JOIN 
    TheOrdersTheProducts OrdProd ON Prod.Id = OrdProd.ProductId
LEFT JOIN
    TheOrders Ord ON OrdProd.OrderId = Ord.Id
GROUP BY 
    Prod.Id, Prod.ProductName, Prod.ProductPrice; -- mora imati sve sto je zajednicko, tj jedan proizvod ce imati sve ovo jedinstveno za svaki proizvod

GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'133a2bf4-fe89-4c58-a273-000e2a1b2659', CAST(N'2022-08-19T10:05:55.000' AS DateTime), 9, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'4bf589df-635c-46a9-a4f2-041a6c500d14', CAST(N'2021-12-11T17:51:29.000' AS DateTime), 3, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'45eddb3c-138f-4931-9c7b-084d1b3c6b7a', CAST(N'2023-08-27T12:56:50.000' AS DateTime), 16, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b53d71ea-a2da-4ee5-bd52-08b0688c4db8', CAST(N'2021-02-02T11:23:07.000' AS DateTime), 1, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'483873bc-a664-466e-a4d3-08e54a4607b3', CAST(N'2023-05-16T23:21:56.000' AS DateTime), 13, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'036705f3-1001-408e-a527-0ce8597dfdc8', CAST(N'2021-03-10T20:50:55.000' AS DateTime), 9, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'32de1b77-62e7-4329-8fe3-10c8cf2c2ade', CAST(N'2023-07-13T13:32:24.000' AS DateTime), 4, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'14284884-a1c3-4346-b4f8-1144143a1709', CAST(N'2022-02-27T19:33:42.000' AS DateTime), 14, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'722dacc6-d797-4a90-95f8-12ea32d88f8a', CAST(N'2023-03-21T04:16:19.000' AS DateTime), 10, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ba53f45b-1467-452b-9e8b-12f0a050b2d0', CAST(N'2022-01-09T21:54:48.000' AS DateTime), 17, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ef0ce0f1-3815-4b3f-8cae-15fc5fc17c70', CAST(N'2019-07-31T02:34:09.000' AS DateTime), 14, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5cc64cbc-1ded-4242-8efc-1712d58f7436', CAST(N'2023-06-28T23:37:57.000' AS DateTime), 16, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'df107c2d-9f0b-4d99-8237-1a3ad5740d9e', CAST(N'2021-01-24T06:19:37.000' AS DateTime), 14, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3dd54fa8-cf6f-4a45-87c5-1b4749a06ebe', CAST(N'2021-09-04T06:38:19.000' AS DateTime), 15, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'447018e7-7a03-4d92-aae5-1cdb3ccaa7a6', CAST(N'2023-02-09T04:09:46.000' AS DateTime), 6, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9b7fb874-93a6-416f-b679-1d4c9ecf036e', CAST(N'2022-11-01T05:53:16.000' AS DateTime), 6, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'95ed7d66-b0c5-4fc1-9345-1db8adccd897', CAST(N'2023-04-04T23:33:07.000' AS DateTime), 7, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3dfd1ef5-3119-491e-9620-1e0ec0a244d8', CAST(N'2023-03-07T19:59:47.000' AS DateTime), 13, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'f892b0f7-be15-404e-b832-1e665cb6884b', CAST(N'2023-02-08T05:54:17.000' AS DateTime), 1, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'742f0890-f96c-4e88-9737-20096b7185e1', CAST(N'2023-06-30T12:45:21.000' AS DateTime), 11, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b9857b84-3c50-4d3a-9dc9-2070ace91724', CAST(N'2022-01-02T22:10:07.000' AS DateTime), 10, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e8ab207b-5849-4a3c-a864-2206939d3d58', CAST(N'2022-05-23T22:20:51.000' AS DateTime), 16, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'073a8b5c-be24-4021-a7f8-231d4f693109', CAST(N'2020-11-15T06:38:32.000' AS DateTime), 6, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'00c005b5-7c69-4c34-bc3f-25ea6f4c842b', CAST(N'2022-04-05T18:35:05.000' AS DateTime), 4, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'71e7885b-e760-4935-a095-27f26a3552c7', CAST(N'2021-07-25T21:48:12.000' AS DateTime), 7, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'26bdf2da-85c2-48e8-8480-28618ff2b687', CAST(N'2021-11-12T03:10:03.000' AS DateTime), 10, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'c4e414c0-34ea-417e-b043-2b0708670fa6', CAST(N'2023-08-30T21:02:08.000' AS DateTime), 8, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'cc4c6745-7ad4-429f-9581-2c75a9fab897', CAST(N'2023-03-26T02:02:30.000' AS DateTime), 9, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'c328fcb2-fa0f-4682-8121-2ce353e30b5b', CAST(N'2022-05-01T22:47:15.000' AS DateTime), 3, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'40afdcb1-2602-4572-846b-2dbe4e39710d', CAST(N'2023-07-21T14:23:50.000' AS DateTime), 14, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'42e2b88b-31f8-4dc6-9672-2de12528be18', CAST(N'2020-04-06T18:55:07.000' AS DateTime), 7, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'f2b018c1-9552-4979-b1b7-2e3db570ecf8', CAST(N'2021-03-29T08:34:48.000' AS DateTime), 4, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'72aeb71c-4407-4d19-8581-2ea1dfbc4b5a', CAST(N'2020-09-07T08:23:40.000' AS DateTime), 8, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e32ca08e-e58e-4c32-b2d5-2f5cb182928b', CAST(N'2021-04-26T10:41:49.000' AS DateTime), 2, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b173c08a-593b-4cbd-a1b4-33003129992a', CAST(N'2021-08-05T06:25:21.000' AS DateTime), 13, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9bada5d5-3459-4299-ab7b-3344bdcf3ce9', CAST(N'2023-06-22T08:02:23.000' AS DateTime), 12, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'523fa7bb-0cb5-4392-9ea1-33a9eb3a0af5', CAST(N'2022-09-28T22:31:53.000' AS DateTime), 17, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'049f64e5-2119-4981-a67c-340a44442680', CAST(N'2022-06-27T22:20:48.000' AS DateTime), 2, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7d548ddd-eb6e-4326-97b3-34ce3b5fd921', CAST(N'2022-09-12T08:27:13.000' AS DateTime), 15, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e2f24ed0-7c3e-4d5e-9c88-363e29016bb8', CAST(N'2023-08-21T19:02:12.000' AS DateTime), 16, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'28109534-264c-491a-9e3f-36479d500352', CAST(N'2022-10-05T01:13:04.000' AS DateTime), 13, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'39e23181-93c1-4027-921a-364ad483309b', CAST(N'2023-03-25T18:00:01.000' AS DateTime), 16, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'2310893d-efde-4c22-b61e-36b96e76307d', CAST(N'2020-04-02T18:00:00.000' AS DateTime), 11, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'd5f35771-92ee-4dfe-9a37-379ce57bbcf8', CAST(N'2023-09-08T09:16:47.000' AS DateTime), 6, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3f5f57ed-415a-4354-aafb-388a7fd179e2', CAST(N'2023-01-27T02:46:33.000' AS DateTime), 10, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'059a75f1-19e6-4c13-8e4c-388e6da29ca5', CAST(N'2023-06-11T18:23:22.000' AS DateTime), 2, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'380a5e1d-2363-4d16-8fc4-396514cff2de', CAST(N'2020-10-16T09:02:45.000' AS DateTime), 10, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'dc38e14f-b359-4c79-a515-3bf07162a6ef', CAST(N'2023-08-08T19:03:09.000' AS DateTime), 7, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'bbdbe7c7-339f-4837-ac50-3ddd05bf763d', CAST(N'2023-06-12T07:42:11.000' AS DateTime), 16, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'64f58818-908a-4913-8ce2-3e01c9608a33', CAST(N'2022-11-26T06:12:33.000' AS DateTime), 17, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ac0df04a-71b4-496e-b8e0-3e13af21be94', CAST(N'2023-03-20T16:18:34.000' AS DateTime), 9, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'81917553-7f43-4009-a8ec-3e4316f67d7b', CAST(N'2023-01-07T02:22:42.000' AS DateTime), 7, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'49abac84-8f1b-4416-8d91-3e63eb2b09f9', CAST(N'2023-04-15T21:05:51.000' AS DateTime), 10, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'4acf6560-a7a4-4239-b693-400ba01d8813', CAST(N'2023-08-11T04:55:30.000' AS DateTime), 3, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'd7557620-f527-4b9e-b795-422bf3e6eb3c', CAST(N'2021-07-06T17:46:54.000' AS DateTime), 1, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a2aaf0b5-ddd0-4c60-95e2-433b94304b6c', CAST(N'2022-11-12T19:17:54.000' AS DateTime), 11, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9494a356-2353-4d81-bbfd-4647b8789c82', CAST(N'2022-03-21T05:33:41.000' AS DateTime), 15, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7f28f7c3-8d37-432a-ab9e-4682caecf296', CAST(N'2023-06-15T00:48:34.000' AS DateTime), 10, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'51a951ee-fb2b-4824-92e3-4772c0ffaceb', CAST(N'2023-05-26T20:57:14.000' AS DateTime), 6, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'bab922d3-0003-4f67-99b0-4baa61c7497f', CAST(N'2022-03-20T19:56:31.000' AS DateTime), 12, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9f5ea89b-f280-4868-8020-5020afd72f0f', CAST(N'2022-08-30T03:50:32.000' AS DateTime), 17, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8508ea7b-fcbe-4aef-988d-521053fde595', CAST(N'2023-04-18T20:58:12.000' AS DateTime), 5, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5f8d5503-35a4-418f-b8e4-52682e065678', CAST(N'2020-08-24T18:34:01.000' AS DateTime), 2, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'274eedba-5cbd-4406-9a15-55df29a382b9', CAST(N'2023-06-15T22:07:38.000' AS DateTime), 3, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'33857c13-c843-47c3-987c-58437f0f03d0', CAST(N'2021-07-05T07:25:38.000' AS DateTime), 3, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'1e3f6aaf-b09c-4ac9-9467-5a52d14fe277', CAST(N'2022-03-08T19:22:30.000' AS DateTime), 15, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'16f04c15-e95f-432f-a0ba-5afbc7ff8132', CAST(N'2021-08-02T11:25:19.000' AS DateTime), 2, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'6e8a1cc2-7f75-4572-a7e4-5ce1eb49847d', CAST(N'2023-01-04T06:38:09.000' AS DateTime), 13, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'1984b416-80df-42a7-b5c1-5d4b250a46e7', CAST(N'2023-01-18T02:40:38.000' AS DateTime), 16, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'70b6b68e-4cdb-411f-8f53-5d4c3b4b3269', CAST(N'2020-02-29T00:36:37.000' AS DateTime), 6, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'f1c1bb98-8e65-496e-bf3c-5eaea1fda6cd', CAST(N'2023-08-16T02:13:47.000' AS DateTime), 13, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9dcef0ff-e548-4caf-99b4-60dcab0574b7', CAST(N'2023-06-01T05:20:03.000' AS DateTime), 16, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'f9a1944f-6d0e-49d5-a4cb-6228ca731930', CAST(N'2020-05-14T20:42:34.000' AS DateTime), 16, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'405c1baf-5998-4565-a511-63383e179971', CAST(N'2023-05-08T19:13:55.000' AS DateTime), 13, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'279b74e1-20c4-4853-bb5e-6366e876390a', CAST(N'2023-04-03T21:22:31.000' AS DateTime), 3, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b71a490f-1a79-45b2-a894-6497729eeefd', CAST(N'2023-05-15T23:18:35.000' AS DateTime), 12, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'4fe2f432-37cb-41ce-9776-65f0d7a1bd97', CAST(N'2021-08-26T04:19:43.000' AS DateTime), 9, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7dbf03f2-1ab3-4c12-be78-6674b51ababf', CAST(N'2020-08-04T07:57:40.000' AS DateTime), 5, N'393614c1-45f6-40a7-b56a-70c96b294475')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'954c4e6b-4b79-45be-9ad2-67d54180ff78', CAST(N'2021-12-01T15:21:51.000' AS DateTime), 15, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'0797c2a5-57b3-42f7-b0c3-67ef49874eb8', CAST(N'2023-06-25T15:07:32.000' AS DateTime), 13, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ce7e748a-f508-443d-9b6e-687cc06659a3', CAST(N'2022-12-16T04:40:57.000' AS DateTime), 14, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8f372f10-fb61-49c7-b7ef-6b0bc860e218', CAST(N'2020-08-20T19:37:30.000' AS DateTime), 5, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5d8d844b-ec85-4ba1-9fb1-6be240bfecb8', CAST(N'2022-12-30T23:54:17.000' AS DateTime), 17, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'31e44bac-b2da-4e52-b208-6c153e6baa9a', CAST(N'2022-07-13T02:42:01.000' AS DateTime), 2, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'47f98621-c205-486c-a74c-6c1c1d38502b', CAST(N'2021-03-05T11:53:36.000' AS DateTime), 14, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a5faf512-8a3d-4a74-b40e-6c571946db1d', CAST(N'2021-11-06T10:04:32.000' AS DateTime), 1, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'346d98a2-52aa-4cc6-aabd-6cde0f0899b2', CAST(N'2021-02-06T03:15:14.000' AS DateTime), 7, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8595964f-e8f4-44a6-b5ad-70ecbeec44f2', CAST(N'2023-08-04T22:47:24.000' AS DateTime), 11, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'f052c563-8aed-4496-9978-744142ae7826', CAST(N'2021-10-04T19:54:19.000' AS DateTime), 16, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ed15f2d9-7573-40fc-9591-759606fb1d9c', CAST(N'2022-02-20T16:02:00.000' AS DateTime), 2, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'0fe5dc94-d82c-4e43-97c0-773827c5e3a6', CAST(N'2021-07-22T00:25:38.000' AS DateTime), 6, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a00a9ae8-08ee-4ab6-9e52-7797cfa659e0', CAST(N'2023-03-25T18:03:48.000' AS DateTime), 17, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'23e1cf22-a9ba-4f99-ab42-786ab54a42f5', CAST(N'2022-06-02T05:35:22.000' AS DateTime), 10, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'2caa1b35-ed79-48c0-9cf0-7ab8b53883d0', CAST(N'2023-03-07T13:57:22.000' AS DateTime), 5, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a4739ac1-eadc-4b8c-97fa-7aeb21655369', CAST(N'2022-06-18T00:01:03.000' AS DateTime), 4, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'765f4f19-b55d-4c7e-acf7-7afaec907055', CAST(N'2022-03-15T08:36:50.000' AS DateTime), 2, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'100f76db-037a-4d48-8b20-7cb56523155f', CAST(N'2023-08-14T23:55:01.000' AS DateTime), 5, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'6398aa97-d810-4d6d-a2cb-7d4a66e226e2', CAST(N'2021-11-11T06:51:47.000' AS DateTime), 2, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'875b2edd-bd64-4b2d-b420-7e380a1da689', CAST(N'2021-03-21T05:06:46.000' AS DateTime), 15, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'2c1f0ca0-6306-4bc0-8d84-8062c20ab1cb', CAST(N'2019-06-26T07:47:34.000' AS DateTime), 14, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9b53e760-00a8-4728-9f19-830f450a54a7', CAST(N'2023-01-24T04:09:27.000' AS DateTime), 3, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5042fe2f-0ff3-4f3d-8cb0-83c504c76cbe', CAST(N'2022-09-17T11:14:06.000' AS DateTime), 6, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'781dfc87-15ac-4388-9f62-83e6bf401baf', CAST(N'2023-05-05T14:21:13.000' AS DateTime), 11, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5d92c4cc-4986-4b3e-ba76-84bee0caa9fa', CAST(N'2022-11-09T13:15:38.000' AS DateTime), 17, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'38bd0a3a-8ae2-40de-aef5-84f6dcaf8265', CAST(N'2023-06-06T09:14:20.000' AS DateTime), 10, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'f2c34d3b-7dd6-4d5d-b158-86417aac3dba', CAST(N'2022-06-21T18:38:01.000' AS DateTime), 5, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'c036076b-3ab4-4777-831a-869900ab52cb', CAST(N'2023-07-06T04:00:19.000' AS DateTime), 7, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'6af8bc9e-8080-4abf-a00c-87440bd82eb0', CAST(N'2023-01-09T12:24:27.000' AS DateTime), 3, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'4e240738-1331-4100-87f5-8840f5d6ffcf', CAST(N'2022-08-29T14:08:01.000' AS DateTime), 8, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9858910a-0b88-4447-a983-88850692b1c4', CAST(N'2020-06-22T05:46:55.000' AS DateTime), 7, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'fda60653-dd49-4778-b102-88c73c7e3290', CAST(N'2020-04-20T23:23:16.000' AS DateTime), 6, N'393614c1-45f6-40a7-b56a-70c96b294475')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8b674bcd-fd19-438f-ac9f-8c6995d0cc84', CAST(N'2022-08-13T09:44:39.000' AS DateTime), 11, N'393614c1-45f6-40a7-b56a-70c96b294475')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b8aa5d6c-6267-4d9f-8572-8cc59301b1c9', CAST(N'2021-10-27T23:02:23.000' AS DateTime), 1, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'6371ca7d-add0-4467-bfa3-8da4886c90ae', CAST(N'2022-08-22T15:44:31.000' AS DateTime), 15, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'442322aa-4816-45e3-88d4-8ea2f387474e', CAST(N'2022-10-05T09:37:20.000' AS DateTime), 4, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e62641c7-db14-469e-8a6a-9082fd93e0e9', CAST(N'2021-09-19T05:04:36.000' AS DateTime), 1, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a5514d03-57e5-43c3-a5b0-9254308c96fb', CAST(N'2019-04-09T14:53:06.000' AS DateTime), 3, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'13ecd7fc-5f40-4dac-a7c5-9478be7e00c7', CAST(N'2022-07-26T01:51:51.000' AS DateTime), 14, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5314fc59-f674-4099-b541-94de14eca2a6', CAST(N'2020-01-26T09:08:34.000' AS DateTime), 15, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'1c13f47a-d750-4431-8cea-95238e7be8f0', CAST(N'2021-04-10T04:59:25.000' AS DateTime), 17, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'286a4cf3-9197-4704-af4f-9684e3acaada', CAST(N'2022-11-15T14:32:46.000' AS DateTime), 1, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e1009e75-92f9-46b2-a6ce-974778aedd46', CAST(N'2021-05-17T17:17:06.000' AS DateTime), 2, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'80810f6b-f36f-49ea-a52f-9b3e6b5b0d4c', CAST(N'2021-08-21T16:06:01.000' AS DateTime), 12, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'30f16704-a012-463a-ab0e-9ba86dd1e797', CAST(N'2019-10-19T17:40:43.000' AS DateTime), 10, N'393614c1-45f6-40a7-b56a-70c96b294475')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'bb169fcf-e33c-41f6-90e4-9d585e8d0fae', CAST(N'2020-06-21T05:48:02.000' AS DateTime), 16, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'264b0615-17bd-4eb7-84ba-9dc013025b2e', CAST(N'2022-12-12T03:48:35.000' AS DateTime), 5, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'167569b8-1982-4668-9be5-9e33ca7cdf8e', CAST(N'2023-08-07T04:23:43.000' AS DateTime), 1, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'4c710100-88ff-41d2-b524-9f7d203d99fe', CAST(N'2021-07-03T07:18:13.000' AS DateTime), 11, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a50835a6-c7e0-49c8-be02-a3cff6f1f4b8', CAST(N'2022-01-25T04:09:12.000' AS DateTime), 16, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8dbf59cd-f71b-4b6d-8284-a447986786cd', CAST(N'2021-03-23T02:28:28.000' AS DateTime), 4, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b81c4f89-3349-402e-80cc-a61759a84ce0', CAST(N'2022-01-22T05:11:45.000' AS DateTime), 14, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a0c57ee0-2e26-4868-a452-a71897971a97', CAST(N'2023-09-12T18:08:47.000' AS DateTime), 2, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5be3bddb-924b-462f-bd30-a71a64dd4840', CAST(N'2021-09-22T09:52:52.000' AS DateTime), 17, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'71e1ff5a-328b-40fb-b30c-a76cd5413365', CAST(N'2020-01-05T15:50:41.000' AS DateTime), 6, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'17f64752-c1c1-4a8f-817d-a7fcfb4bb59c', CAST(N'2022-08-15T04:38:20.000' AS DateTime), 16, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'c000a524-ddb1-4641-91ab-aa48d08b807a', CAST(N'2022-03-02T20:04:27.000' AS DateTime), 4, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'dec0d2ad-aa71-46cd-a3c8-aa704c74272e', CAST(N'2023-03-29T19:40:07.000' AS DateTime), 13, N'393614c1-45f6-40a7-b56a-70c96b294475')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7124c852-f1f1-443b-9818-ab489b393570', CAST(N'2023-06-26T14:52:23.000' AS DateTime), 8, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'edd58a49-0256-4bd5-bc18-acea46d6c1af', CAST(N'2021-10-27T02:48:26.000' AS DateTime), 17, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a7a0eecd-985f-4581-bebd-aced29645688', CAST(N'2022-01-29T12:32:23.000' AS DateTime), 3, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3f7aeda1-eb3e-4faa-b920-ad7f3731c423', CAST(N'2022-08-20T17:52:41.000' AS DateTime), 17, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b36c00c0-3e0e-40b6-acb5-ad83422ab3e1', CAST(N'2023-01-07T17:32:41.000' AS DateTime), 14, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'76c058e4-e4ce-4cfa-b6ce-ae3a0e851760', CAST(N'2022-02-23T05:34:49.000' AS DateTime), 2, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7298f477-8235-4c2c-a20f-afe72b462bba', CAST(N'2023-01-23T11:12:49.000' AS DateTime), 6, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'1b578284-a444-416f-a035-b0ae6b1dec3b', CAST(N'2022-07-26T21:26:57.000' AS DateTime), 8, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'eb2f995b-d652-47d1-b7a2-b176ba50688c', CAST(N'2020-05-31T05:45:21.000' AS DateTime), 8, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'315f4ddc-8ff5-4d25-b949-b2ada4e46feb', CAST(N'2023-01-19T02:06:29.000' AS DateTime), 14, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9fdf6685-6de9-464e-84c7-b3f107afbe85', CAST(N'2021-04-05T22:32:48.000' AS DateTime), 10, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'def9ec7e-5cc7-420a-97e3-b3f9e831f0c8', CAST(N'2022-08-16T08:39:52.000' AS DateTime), 15, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e731d91e-6381-4a3e-b857-b713d90df159', CAST(N'2021-12-19T14:25:44.000' AS DateTime), 10, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'4cb38d43-03ef-426e-82f3-b7c26d9c32d2', CAST(N'2022-11-16T09:46:08.000' AS DateTime), 14, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'38cc6cb1-481b-4ca3-90e3-b8152e91272e', CAST(N'2023-05-11T22:16:27.000' AS DateTime), 10, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9a2522fa-359c-4605-bee3-b882e766a1e6', CAST(N'2022-10-12T23:24:34.000' AS DateTime), 14, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a47e73dc-f323-4662-a2be-baba63bbb7de', CAST(N'2023-07-31T02:34:23.000' AS DateTime), 17, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3350b4bb-02c8-4cd8-9c24-bc19b2edad43', CAST(N'2023-07-26T19:57:06.000' AS DateTime), 16, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'1ed86db4-1f65-4c09-a89d-bc3195da8ea1', CAST(N'2022-03-13T09:20:39.000' AS DateTime), 10, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b0ba9b12-19d8-418e-a416-be7c4bd04763', CAST(N'2022-10-07T07:31:18.000' AS DateTime), 13, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'946e4871-cd18-4076-9590-c03bcb285ed7', CAST(N'2019-12-19T07:41:46.000' AS DateTime), 15, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'508fb3d4-99fe-4c2f-8b54-c0ccf33c09b1', CAST(N'2021-02-25T00:38:38.000' AS DateTime), 17, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'50afc90f-f5ea-48eb-9e2e-c4bd2a3b01a0', CAST(N'2023-09-02T17:43:46.000' AS DateTime), 13, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'75ba231d-89fd-4e43-8266-c7a2919cbd49', CAST(N'2021-01-13T07:25:18.000' AS DateTime), 10, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'44abd56d-7fb1-4294-b1b3-c7d0d1dc0ae0', CAST(N'2020-09-06T01:28:42.000' AS DateTime), 4, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'20a3170d-b31a-45bb-a46c-c8d685a3d680', CAST(N'2020-08-20T08:29:37.000' AS DateTime), 3, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'2b9918f7-1dd7-47c4-86b0-cbad3dae1e9d', CAST(N'2021-07-14T17:00:16.000' AS DateTime), 5, N'55317769-940b-4083-90e0-07de2681cdb7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'0820a9ee-85e2-434c-9971-cbe800311870', CAST(N'2022-10-28T10:52:50.000' AS DateTime), 6, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ee167c7c-aee6-4e81-8886-cfeb8ed2d163', CAST(N'2022-02-04T02:56:59.000' AS DateTime), 10, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7504625b-2627-42a1-bd20-d00d896da8c7', CAST(N'2021-05-12T07:54:52.000' AS DateTime), 10, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'42793ff0-be54-4546-afe9-d11981ea6149', CAST(N'2023-02-14T23:47:08.000' AS DateTime), 5, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8eb399d6-5488-4853-be40-d27ba2f651de', CAST(N'2021-03-14T23:30:53.000' AS DateTime), 7, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7353cb74-9f38-4373-a0f8-d484db298847', CAST(N'2020-05-02T11:08:20.000' AS DateTime), 16, N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e5bc9382-b009-4c0c-a6c6-d4ecf42aa22e', CAST(N'2021-10-05T11:02:10.000' AS DateTime), 16, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'072e1390-850c-44b4-87cf-d5c623b08820', CAST(N'2022-08-25T04:33:18.000' AS DateTime), 6, N'b84aed35-ea80-4eca-8458-67ecd9372533')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ca2ed4cc-47a6-4a1e-a31b-d6ccc4d09c75', CAST(N'2020-05-23T15:16:21.000' AS DateTime), 6, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'121a7c81-49f8-4e0e-a15b-db89d34e048b', CAST(N'2022-12-15T04:23:12.000' AS DateTime), 12, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'600c51c5-9d6e-4703-be9f-dc321a62ceb9', CAST(N'2022-07-12T02:08:55.000' AS DateTime), 16, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'52086d1f-abd5-4a8a-af03-dc494470f2a9', CAST(N'2021-03-16T21:53:02.000' AS DateTime), 15, N'393614c1-45f6-40a7-b56a-70c96b294475')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'80e4cb0e-670b-4321-803a-dff2628d3e5c', CAST(N'2023-04-04T21:19:11.000' AS DateTime), 17, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'84eb6182-3653-4755-8c32-e08a62fc98e7', CAST(N'2022-06-09T02:02:35.000' AS DateTime), 7, N'5e20846f-6616-4409-88d1-e2f4fef63fa3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'd88084c7-36a5-4011-9343-e13ebac5a82d', CAST(N'2021-10-15T07:47:33.000' AS DateTime), 8, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3ac62d3a-d79f-43af-9890-e1653e4c40e3', CAST(N'2022-06-19T04:20:07.000' AS DateTime), 4, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'5de757bf-4f60-4dde-8140-e37241bfca7a', CAST(N'2023-04-13T04:10:54.000' AS DateTime), 15, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'ae206410-1a8e-4814-aabe-e3fe4266f796', CAST(N'2023-03-18T02:15:25.000' AS DateTime), 4, N'404e9b6c-b257-475c-afd1-c61039869107')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7edaf78a-c528-4182-970e-e716bcce7124', CAST(N'2019-08-23T20:24:06.000' AS DateTime), 16, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'7d8f3f14-7837-4e99-b87e-e727cc4fd77a', CAST(N'2019-06-19T15:27:43.000' AS DateTime), 12, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'78909943-fb3b-4431-b7c4-e7973060a092', CAST(N'2022-11-30T15:50:13.000' AS DateTime), 13, N'ec019f54-8c64-4c92-8edd-772a2376004e')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'da85449c-90c7-4b4d-8a0c-e81c20378381', CAST(N'2023-06-09T04:42:53.000' AS DateTime), 1, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'24e6692b-8df6-4e62-8697-ede87304d275', CAST(N'2021-12-08T15:05:38.000' AS DateTime), 16, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'e2b927e4-c486-4c52-be4b-eeb32d0f27f3', CAST(N'2021-06-18T01:56:11.000' AS DateTime), 6, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'44f0ad46-f5b5-4824-9be6-f0715a2294de', CAST(N'2023-03-03T00:43:31.000' AS DateTime), 10, N'ee7000b6-3ace-4215-bbe2-fe483a57bb58')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8684b3b6-f1db-4b31-b235-f0d2780d5444', CAST(N'2023-08-14T09:22:47.000' AS DateTime), 7, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'9507f0f2-d425-4e0d-a15b-f2185153d8b7', CAST(N'2023-08-08T20:39:35.000' AS DateTime), 12, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'b26ffbca-4d2c-45b6-9593-f2c6f2829817', CAST(N'2022-12-12T21:24:28.000' AS DateTime), 4, N'1a2d3431-d00d-4dd8-939c-a8569b5749a2')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'622f4204-b806-4146-9d53-f41ada4a0122', CAST(N'2022-06-26T09:31:29.000' AS DateTime), 7, N'31de8ff9-9639-4f31-8f41-34ada4fbc49d')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'3e9f3b02-3a43-4436-8e40-f44defee45ac', CAST(N'2021-11-10T23:48:54.000' AS DateTime), 6, N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'a35ef2dd-bc42-4361-b51b-f53fee3cbabb', CAST(N'2020-09-11T15:58:29.000' AS DateTime), 5, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'46cb6a23-2689-44df-ba7f-f59662acfe9f', CAST(N'2022-10-06T05:03:50.000' AS DateTime), 4, N'68817e80-b624-4b6e-9c31-f9400a2fd9ac')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'c5b7f733-bfb4-4669-9d5c-f6faabd53aef', CAST(N'2023-09-02T22:25:26.000' AS DateTime), 15, N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'8bd87e65-c8e6-4c0d-9403-f95cc7570951', CAST(N'2023-01-23T09:39:25.000' AS DateTime), 7, N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'91179025-f723-4837-bf0c-fef5a5c51569', CAST(N'2020-12-10T13:49:54.000' AS DateTime), 15, N'0719bd35-c735-4713-b6ea-b0010716da88')
GO
INSERT [dbo].[TheOrders] ([Id], [OrderTime], [OrderAmount], [CustomerId]) VALUES (N'601aa251-7dd3-41fb-a41f-ff71794e9517', CAST(N'2020-11-12T10:40:42.000' AS DateTime), 13, N'd3ef090d-5ad1-477c-8aa6-d8a6be790534')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'133a2bf4-fe89-4c58-a273-000e2a1b2659', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'4bf589df-635c-46a9-a4f2-041a6c500d14', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'45eddb3c-138f-4931-9c7b-084d1b3c6b7a', N'b9fac82d-af71-4083-beda-a172cb637f7d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b53d71ea-a2da-4ee5-bd52-08b0688c4db8', N'21736824-1288-4fec-9ed6-817cc31437d9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'483873bc-a664-466e-a4d3-08e54a4607b3', N'b7e58599-12a3-4fe3-8d25-3111022b4a88')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'036705f3-1001-408e-a527-0ce8597dfdc8', N'60acdc5f-0c13-48fc-9f8d-284381241e98')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'32de1b77-62e7-4329-8fe3-10c8cf2c2ade', N'db849ca1-a30e-4994-bc24-bfc150b8f9af')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'14284884-a1c3-4346-b4f8-1144143a1709', N'cc735a63-c796-450b-b5e0-5c13568857e8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'722dacc6-d797-4a90-95f8-12ea32d88f8a', N'ae5a0fa5-cd05-4b2f-9113-a482827e3243')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ba53f45b-1467-452b-9e8b-12f0a050b2d0', N'a4f18f01-b8b9-4a90-bf16-916d8d6aa5df')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ef0ce0f1-3815-4b3f-8cae-15fc5fc17c70', N'005fec1c-22da-484e-a855-2abe908df12d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5cc64cbc-1ded-4242-8efc-1712d58f7436', N'92c36ece-225e-43c8-858e-9fe2643653bd')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'df107c2d-9f0b-4d99-8237-1a3ad5740d9e', N'4508f8b1-f69b-428c-bcff-8c5430702b66')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3dd54fa8-cf6f-4a45-87c5-1b4749a06ebe', N'3e5486e5-90dc-45bc-8dfd-b15083d50da5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'447018e7-7a03-4d92-aae5-1cdb3ccaa7a6', N'1915d376-2ace-481d-99df-17fc091b4bb3')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9b7fb874-93a6-416f-b679-1d4c9ecf036e', N'455f24db-91d1-4a29-9987-d3ff9586e46a')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'95ed7d66-b0c5-4fc1-9345-1db8adccd897', N'21736824-1288-4fec-9ed6-817cc31437d9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3dfd1ef5-3119-491e-9620-1e0ec0a244d8', N'18ba3259-85f5-49db-bfc3-8809d5f09bf9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'f892b0f7-be15-404e-b832-1e665cb6884b', N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'742f0890-f96c-4e88-9737-20096b7185e1', N'bb657e68-e161-403a-8247-31eca0da9c85')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b9857b84-3c50-4d3a-9dc9-2070ace91724', N'92c36ece-225e-43c8-858e-9fe2643653bd')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e8ab207b-5849-4a3c-a864-2206939d3d58', N'4fa5d70d-aaa7-417a-be9a-926ff9eb2369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'073a8b5c-be24-4021-a7f8-231d4f693109', N'21736824-1288-4fec-9ed6-817cc31437d9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'00c005b5-7c69-4c34-bc3f-25ea6f4c842b', N'18ba3259-85f5-49db-bfc3-8809d5f09bf9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'71e7885b-e760-4935-a095-27f26a3552c7', N'7f601dc7-8182-454c-b890-6a90d3cac9c9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'26bdf2da-85c2-48e8-8480-28618ff2b687', N'a7311d43-4e23-4607-84b1-ec452df9ca6d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'c4e414c0-34ea-417e-b043-2b0708670fa6', N'07268e24-351a-4fa6-9e18-59ed83b17d60')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'cc4c6745-7ad4-429f-9581-2c75a9fab897', N'fdcf4f67-a8dc-4492-8303-e1efd99b9062')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'c328fcb2-fa0f-4682-8121-2ce353e30b5b', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'40afdcb1-2602-4572-846b-2dbe4e39710d', N'bdcefd78-93d4-41da-a591-12284f2661fb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'42e2b88b-31f8-4dc6-9672-2de12528be18', N'02cd9055-2d95-42de-8655-0d08071bab73')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'f2b018c1-9552-4979-b1b7-2e3db570ecf8', N'bbd515b4-2cbf-4675-b331-ea7f1599c24e')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'72aeb71c-4407-4d19-8581-2ea1dfbc4b5a', N'bdcefd78-93d4-41da-a591-12284f2661fb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e32ca08e-e58e-4c32-b2d5-2f5cb182928b', N'66f57204-cbd1-4d96-81da-a8c9127ea954')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b173c08a-593b-4cbd-a1b4-33003129992a', N'3d84d38f-130e-4ccc-9a4a-ab87328c51a1')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9bada5d5-3459-4299-ab7b-3344bdcf3ce9', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'523fa7bb-0cb5-4392-9ea1-33a9eb3a0af5', N'dbddf365-30f5-4e8b-89c3-9eac6acee722')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'049f64e5-2119-4981-a67c-340a44442680', N'a9c05906-27ce-4f6c-8281-03dd967db4f7')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7d548ddd-eb6e-4326-97b3-34ce3b5fd921', N'3e5486e5-90dc-45bc-8dfd-b15083d50da5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e2f24ed0-7c3e-4d5e-9c88-363e29016bb8', N'b4fc8321-752a-41c6-a72b-2883a6725322')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'28109534-264c-491a-9e3f-36479d500352', N'b7e58599-12a3-4fe3-8d25-3111022b4a88')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'39e23181-93c1-4027-921a-364ad483309b', N'2c469466-fd90-4493-887f-bc41151d2260')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'2310893d-efde-4c22-b61e-36b96e76307d', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'd5f35771-92ee-4dfe-9a37-379ce57bbcf8', N'02cd9055-2d95-42de-8655-0d08071bab73')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3f5f57ed-415a-4354-aafb-388a7fd179e2', N'dbddf365-30f5-4e8b-89c3-9eac6acee722')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'059a75f1-19e6-4c13-8e4c-388e6da29ca5', N'17ebf1fb-9e4b-48da-b6ce-d70955034e05')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'380a5e1d-2363-4d16-8fc4-396514cff2de', N'be383d4e-8e91-49b1-a30d-3122861cf369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'dc38e14f-b359-4c79-a515-3bf07162a6ef', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'bbdbe7c7-339f-4837-ac50-3ddd05bf763d', N'be383d4e-8e91-49b1-a30d-3122861cf369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'64f58818-908a-4913-8ce2-3e01c9608a33', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ac0df04a-71b4-496e-b8e0-3e13af21be94', N'bdc334f5-5427-4baa-9095-24ef57650c8c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'81917553-7f43-4009-a8ec-3e4316f67d7b', N'18ba3259-85f5-49db-bfc3-8809d5f09bf9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'49abac84-8f1b-4416-8d91-3e63eb2b09f9', N'b7e58599-12a3-4fe3-8d25-3111022b4a88')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'4acf6560-a7a4-4239-b693-400ba01d8813', N'92313420-50d6-463d-83ca-f8bdbce1e7a6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'd7557620-f527-4b9e-b795-422bf3e6eb3c', N'ae27d324-4541-4476-a463-f713e05c37ea')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a2aaf0b5-ddd0-4c60-95e2-433b94304b6c', N'bbd515b4-2cbf-4675-b331-ea7f1599c24e')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9494a356-2353-4d81-bbfd-4647b8789c82', N'fdcf4f67-a8dc-4492-8303-e1efd99b9062')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7f28f7c3-8d37-432a-ab9e-4682caecf296', N'7f601dc7-8182-454c-b890-6a90d3cac9c9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'51a951ee-fb2b-4824-92e3-4772c0ffaceb', N'969000b8-ddf0-4360-ad74-58ecec44980d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'bab922d3-0003-4f67-99b0-4baa61c7497f', N'be383d4e-8e91-49b1-a30d-3122861cf369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9f5ea89b-f280-4868-8020-5020afd72f0f', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8508ea7b-fcbe-4aef-988d-521053fde595', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5f8d5503-35a4-418f-b8e4-52682e065678', N'92c36ece-225e-43c8-858e-9fe2643653bd')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'274eedba-5cbd-4406-9a15-55df29a382b9', N'1c77d1b4-a31c-4bc3-817b-7658f655a3ed')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'33857c13-c843-47c3-987c-58437f0f03d0', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'1e3f6aaf-b09c-4ac9-9467-5a52d14fe277', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'16f04c15-e95f-432f-a0ba-5afbc7ff8132', N'1f296f45-60a1-4bb4-a417-834f316ba45e')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'6e8a1cc2-7f75-4572-a7e4-5ce1eb49847d', N'07268e24-351a-4fa6-9e18-59ed83b17d60')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'1984b416-80df-42a7-b5c1-5d4b250a46e7', N'1e18946f-5944-4d1c-a3f9-ec1891f63aa1')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'70b6b68e-4cdb-411f-8f53-5d4c3b4b3269', N'4508f8b1-f69b-428c-bcff-8c5430702b66')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'f1c1bb98-8e65-496e-bf3c-5eaea1fda6cd', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9dcef0ff-e548-4caf-99b4-60dcab0574b7', N'ae5a0fa5-cd05-4b2f-9113-a482827e3243')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'f9a1944f-6d0e-49d5-a4cb-6228ca731930', N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'405c1baf-5998-4565-a511-63383e179971', N'a4f18f01-b8b9-4a90-bf16-916d8d6aa5df')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'279b74e1-20c4-4853-bb5e-6366e876390a', N'd854a6f2-9504-4f31-8de3-3ea271b77b19')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b71a490f-1a79-45b2-a894-6497729eeefd', N'8be19cb9-4983-45ba-9665-01e96291a9f6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'4fe2f432-37cb-41ce-9776-65f0d7a1bd97', N'92c36ece-225e-43c8-858e-9fe2643653bd')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7dbf03f2-1ab3-4c12-be78-6674b51ababf', N'92313420-50d6-463d-83ca-f8bdbce1e7a6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'954c4e6b-4b79-45be-9ad2-67d54180ff78', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'0797c2a5-57b3-42f7-b0c3-67ef49874eb8', N'bdd261ac-b8a2-431f-9af1-ab3b6ee6e850')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ce7e748a-f508-443d-9b6e-687cc06659a3', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8f372f10-fb61-49c7-b7ef-6b0bc860e218', N'b9fac82d-af71-4083-beda-a172cb637f7d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5d8d844b-ec85-4ba1-9fb1-6be240bfecb8', N'214f48c4-25ec-4d29-9c73-9591b6ec226f')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'31e44bac-b2da-4e52-b208-6c153e6baa9a', N'92c36ece-225e-43c8-858e-9fe2643653bd')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'47f98621-c205-486c-a74c-6c1c1d38502b', N'dbddf365-30f5-4e8b-89c3-9eac6acee722')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a5faf512-8a3d-4a74-b40e-6c571946db1d', N'b4fc8321-752a-41c6-a72b-2883a6725322')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'346d98a2-52aa-4cc6-aabd-6cde0f0899b2', N'1e18946f-5944-4d1c-a3f9-ec1891f63aa1')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8595964f-e8f4-44a6-b5ad-70ecbeec44f2', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'f052c563-8aed-4496-9978-744142ae7826', N'1c77d1b4-a31c-4bc3-817b-7658f655a3ed')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ed15f2d9-7573-40fc-9591-759606fb1d9c', N'7f601dc7-8182-454c-b890-6a90d3cac9c9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'0fe5dc94-d82c-4e43-97c0-773827c5e3a6', N'66f57204-cbd1-4d96-81da-a8c9127ea954')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a00a9ae8-08ee-4ab6-9e52-7797cfa659e0', N'bdc334f5-5427-4baa-9095-24ef57650c8c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'23e1cf22-a9ba-4f99-ab42-786ab54a42f5', N'd799ba68-66a1-4415-8ae9-94a6f0e3281f')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'2caa1b35-ed79-48c0-9cf0-7ab8b53883d0', N'5010d05f-5dce-4fea-8158-61a3873bf978')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a4739ac1-eadc-4b8c-97fa-7aeb21655369', N'bdd261ac-b8a2-431f-9af1-ab3b6ee6e850')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'765f4f19-b55d-4c7e-acf7-7afaec907055', N'02cd9055-2d95-42de-8655-0d08071bab73')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'100f76db-037a-4d48-8b20-7cb56523155f', N'8be19cb9-4983-45ba-9665-01e96291a9f6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'6398aa97-d810-4d6d-a2cb-7d4a66e226e2', N'b7e58599-12a3-4fe3-8d25-3111022b4a88')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'875b2edd-bd64-4b2d-b420-7e380a1da689', N'c110c3bb-52c1-4043-b91d-4998e2a905b8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'2c1f0ca0-6306-4bc0-8d84-8062c20ab1cb', N'18ba3259-85f5-49db-bfc3-8809d5f09bf9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9b53e760-00a8-4728-9f19-830f450a54a7', N'bb657e68-e161-403a-8247-31eca0da9c85')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5042fe2f-0ff3-4f3d-8cb0-83c504c76cbe', N'd854a6f2-9504-4f31-8de3-3ea271b77b19')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'781dfc87-15ac-4388-9f62-83e6bf401baf', N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5d92c4cc-4986-4b3e-ba76-84bee0caa9fa', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'38bd0a3a-8ae2-40de-aef5-84f6dcaf8265', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'f2c34d3b-7dd6-4d5d-b158-86417aac3dba', N'214f48c4-25ec-4d29-9c73-9591b6ec226f')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'c036076b-3ab4-4777-831a-869900ab52cb', N'1e18946f-5944-4d1c-a3f9-ec1891f63aa1')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'6af8bc9e-8080-4abf-a00c-87440bd82eb0', N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'4e240738-1331-4100-87f5-8840f5d6ffcf', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9858910a-0b88-4447-a983-88850692b1c4', N'20cc7814-7337-4d2a-b81d-0e75fdf29deb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'fda60653-dd49-4778-b102-88c73c7e3290', N'214f48c4-25ec-4d29-9c73-9591b6ec226f')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8b674bcd-fd19-438f-ac9f-8c6995d0cc84', N'4fa5d70d-aaa7-417a-be9a-926ff9eb2369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b8aa5d6c-6267-4d9f-8572-8cc59301b1c9', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'6371ca7d-add0-4467-bfa3-8da4886c90ae', N'06c1b985-634f-45df-bc21-f69c21f856ae')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'442322aa-4816-45e3-88d4-8ea2f387474e', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e62641c7-db14-469e-8a6a-9082fd93e0e9', N'969000b8-ddf0-4360-ad74-58ecec44980d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a5514d03-57e5-43c3-a5b0-9254308c96fb', N'b4fc8321-752a-41c6-a72b-2883a6725322')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'13ecd7fc-5f40-4dac-a7c5-9478be7e00c7', N'a5bd415d-c3a1-40e3-a3fd-e7f8c122a031')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5314fc59-f674-4099-b541-94de14eca2a6', N'214f48c4-25ec-4d29-9c73-9591b6ec226f')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'1c13f47a-d750-4431-8cea-95238e7be8f0', N'1f296f45-60a1-4bb4-a417-834f316ba45e')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'286a4cf3-9197-4704-af4f-9684e3acaada', N'1c77d1b4-a31c-4bc3-817b-7658f655a3ed')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e1009e75-92f9-46b2-a6ce-974778aedd46', N'2bb0557a-9177-4729-a4d9-c965302fa4eb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'80810f6b-f36f-49ea-a52f-9b3e6b5b0d4c', N'd854a6f2-9504-4f31-8de3-3ea271b77b19')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'30f16704-a012-463a-ab0e-9ba86dd1e797', N'7f601dc7-8182-454c-b890-6a90d3cac9c9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'bb169fcf-e33c-41f6-90e4-9d585e8d0fae', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'264b0615-17bd-4eb7-84ba-9dc013025b2e', N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'167569b8-1982-4668-9be5-9e33ca7cdf8e', N'a9c05906-27ce-4f6c-8281-03dd967db4f7')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'4c710100-88ff-41d2-b524-9f7d203d99fe', N'4fa5d70d-aaa7-417a-be9a-926ff9eb2369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a50835a6-c7e0-49c8-be02-a3cff6f1f4b8', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8dbf59cd-f71b-4b6d-8284-a447986786cd', N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b81c4f89-3349-402e-80cc-a61759a84ce0', N'5010d05f-5dce-4fea-8158-61a3873bf978')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a0c57ee0-2e26-4868-a452-a71897971a97', N'bb657e68-e161-403a-8247-31eca0da9c85')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5be3bddb-924b-462f-bd30-a71a64dd4840', N'bb657e68-e161-403a-8247-31eca0da9c85')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'71e1ff5a-328b-40fb-b30c-a76cd5413365', N'60acdc5f-0c13-48fc-9f8d-284381241e98')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'17f64752-c1c1-4a8f-817d-a7fcfb4bb59c', N'f0b90ac4-2532-4501-b4b4-8a2575fcc1dc')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'c000a524-ddb1-4641-91ab-aa48d08b807a', N'f0b90ac4-2532-4501-b4b4-8a2575fcc1dc')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'dec0d2ad-aa71-46cd-a3c8-aa704c74272e', N'b9fac82d-af71-4083-beda-a172cb637f7d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7124c852-f1f1-443b-9818-ab489b393570', N'21736824-1288-4fec-9ed6-817cc31437d9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'edd58a49-0256-4bd5-bc18-acea46d6c1af', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a7a0eecd-985f-4581-bebd-aced29645688', N'3e5486e5-90dc-45bc-8dfd-b15083d50da5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3f7aeda1-eb3e-4faa-b920-ad7f3731c423', N'4508f8b1-f69b-428c-bcff-8c5430702b66')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b36c00c0-3e0e-40b6-acb5-ad83422ab3e1', N'7f601dc7-8182-454c-b890-6a90d3cac9c9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'76c058e4-e4ce-4cfa-b6ce-ae3a0e851760', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7298f477-8235-4c2c-a20f-afe72b462bba', N'2bb0557a-9177-4729-a4d9-c965302fa4eb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'1b578284-a444-416f-a035-b0ae6b1dec3b', N'ae5a0fa5-cd05-4b2f-9113-a482827e3243')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'eb2f995b-d652-47d1-b7a2-b176ba50688c', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'315f4ddc-8ff5-4d25-b949-b2ada4e46feb', N'ff22aa9d-3cad-4113-8452-2ac037290bc6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9fdf6685-6de9-464e-84c7-b3f107afbe85', N'ae5a0fa5-cd05-4b2f-9113-a482827e3243')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'def9ec7e-5cc7-420a-97e3-b3f9e831f0c8', N'a9c05906-27ce-4f6c-8281-03dd967db4f7')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e731d91e-6381-4a3e-b857-b713d90df159', N'890aeff9-0e36-4714-9121-0b190ce3732d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'4cb38d43-03ef-426e-82f3-b7c26d9c32d2', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'38cc6cb1-481b-4ca3-90e3-b8152e91272e', N'1e18946f-5944-4d1c-a3f9-ec1891f63aa1')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9a2522fa-359c-4605-bee3-b882e766a1e6', N'06c1b985-634f-45df-bc21-f69c21f856ae')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a47e73dc-f323-4662-a2be-baba63bbb7de', N'b7e58599-12a3-4fe3-8d25-3111022b4a88')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3350b4bb-02c8-4cd8-9c24-bc19b2edad43', N'02cd9055-2d95-42de-8655-0d08071bab73')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'1ed86db4-1f65-4c09-a89d-bc3195da8ea1', N'05e59652-d170-43c7-b346-27fc9beb7828')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b0ba9b12-19d8-418e-a416-be7c4bd04763', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'946e4871-cd18-4076-9590-c03bcb285ed7', N'20cc7814-7337-4d2a-b81d-0e75fdf29deb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'508fb3d4-99fe-4c2f-8b54-c0ccf33c09b1', N'a5bd415d-c3a1-40e3-a3fd-e7f8c122a031')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'50afc90f-f5ea-48eb-9e2e-c4bd2a3b01a0', N'ff22aa9d-3cad-4113-8452-2ac037290bc6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'75ba231d-89fd-4e43-8266-c7a2919cbd49', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'44abd56d-7fb1-4294-b1b3-c7d0d1dc0ae0', N'a5bd415d-c3a1-40e3-a3fd-e7f8c122a031')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'20a3170d-b31a-45bb-a46c-c8d685a3d680', N'b9fac82d-af71-4083-beda-a172cb637f7d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'2b9918f7-1dd7-47c4-86b0-cbad3dae1e9d', N'60acdc5f-0c13-48fc-9f8d-284381241e98')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'0820a9ee-85e2-434c-9971-cbe800311870', N'bb657e68-e161-403a-8247-31eca0da9c85')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ee167c7c-aee6-4e81-8886-cfeb8ed2d163', N'cc735a63-c796-450b-b5e0-5c13568857e8')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7504625b-2627-42a1-bd20-d00d896da8c7', N'bb657e68-e161-403a-8247-31eca0da9c85')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'42793ff0-be54-4546-afe9-d11981ea6149', N'd854a6f2-9504-4f31-8de3-3ea271b77b19')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8eb399d6-5488-4853-be40-d27ba2f651de', N'b7e58599-12a3-4fe3-8d25-3111022b4a88')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7353cb74-9f38-4373-a0f8-d484db298847', N'1f296f45-60a1-4bb4-a417-834f316ba45e')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e5bc9382-b009-4c0c-a6c6-d4ecf42aa22e', N'ff22aa9d-3cad-4113-8452-2ac037290bc6')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'072e1390-850c-44b4-87cf-d5c623b08820', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ca2ed4cc-47a6-4a1e-a31b-d6ccc4d09c75', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'121a7c81-49f8-4e0e-a15b-db89d34e048b', N'a4f18f01-b8b9-4a90-bf16-916d8d6aa5df')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'600c51c5-9d6e-4703-be9f-dc321a62ceb9', N'ae27d324-4541-4476-a463-f713e05c37ea')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'52086d1f-abd5-4a8a-af03-dc494470f2a9', N'c9caa234-b77e-49ee-9b8a-a37fe299d355')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'80e4cb0e-670b-4321-803a-dff2628d3e5c', N'005fec1c-22da-484e-a855-2abe908df12d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'84eb6182-3653-4755-8c32-e08a62fc98e7', N'4fa5d70d-aaa7-417a-be9a-926ff9eb2369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'd88084c7-36a5-4011-9343-e13ebac5a82d', N'be383d4e-8e91-49b1-a30d-3122861cf369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3ac62d3a-d79f-43af-9890-e1653e4c40e3', N'3e5486e5-90dc-45bc-8dfd-b15083d50da5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'5de757bf-4f60-4dde-8140-e37241bfca7a', N'ae5a0fa5-cd05-4b2f-9113-a482827e3243')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'ae206410-1a8e-4814-aabe-e3fe4266f796', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7edaf78a-c528-4182-970e-e716bcce7124', N'ae5a0fa5-cd05-4b2f-9113-a482827e3243')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'7d8f3f14-7837-4e99-b87e-e727cc4fd77a', N'7f601dc7-8182-454c-b890-6a90d3cac9c9')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'78909943-fb3b-4431-b7c4-e7973060a092', N'a7311d43-4e23-4607-84b1-ec452df9ca6d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'da85449c-90c7-4b4d-8a0c-e81c20378381', N'bdcefd78-93d4-41da-a591-12284f2661fb')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'24e6692b-8df6-4e62-8697-ede87304d275', N'a5bd415d-c3a1-40e3-a3fd-e7f8c122a031')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'e2b927e4-c486-4c52-be4b-eeb32d0f27f3', N'6ade36ce-a155-440a-82e1-ee5f27b84c2c')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'44f0ad46-f5b5-4824-9be6-f0715a2294de', N'07268e24-351a-4fa6-9e18-59ed83b17d60')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8684b3b6-f1db-4b31-b235-f0d2780d5444', N'a5bd415d-c3a1-40e3-a3fd-e7f8c122a031')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'9507f0f2-d425-4e0d-a15b-f2185153d8b7', N'a4f18f01-b8b9-4a90-bf16-916d8d6aa5df')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'b26ffbca-4d2c-45b6-9593-f2c6f2829817', N'890aeff9-0e36-4714-9121-0b190ce3732d')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'622f4204-b806-4146-9d53-f41ada4a0122', N'3e5486e5-90dc-45bc-8dfd-b15083d50da5')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'3e9f3b02-3a43-4436-8e40-f44defee45ac', N'be383d4e-8e91-49b1-a30d-3122861cf369')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'a35ef2dd-bc42-4361-b51b-f53fee3cbabb', N'c7fd2977-e536-40b6-aef8-69620971d51b')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'46cb6a23-2689-44df-ba7f-f59662acfe9f', N'ae27d324-4541-4476-a463-f713e05c37ea')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'c5b7f733-bfb4-4669-9d5c-f6faabd53aef', N'8a079444-ba28-4656-9a92-037c5b434f26')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'8bd87e65-c8e6-4c0d-9403-f95cc7570951', N'd799ba68-66a1-4415-8ae9-94a6f0e3281f')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'91179025-f723-4837-bf0c-fef5a5c51569', N'07268e24-351a-4fa6-9e18-59ed83b17d60')
GO
INSERT [dbo].[TheOrdersTheProducts] ([OrderId], [ProductId]) VALUES (N'601aa251-7dd3-41fb-a41f-ff71794e9517', N'a4f18f01-b8b9-4a90-bf16-916d8d6aa5df')
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'55317769-940b-4083-90e0-07de2681cdb7', N'Yasmin', N'Al-Salem', CAST(N'1997-02-12T00:00:00.000' AS DateTime), N'yasmin.alsalem@outlook.com', CAST(N'2020-09-11T04:25:26.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'31de8ff9-9639-4f31-8f41-34ada4fbc49d', N'Emilia', N'Rodriguez', CAST(N'1985-06-25T00:00:00.000' AS DateTime), N'emilia.rodriguez@yahoo.com', CAST(N'2019-04-16T09:44:31.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'b84aed35-ea80-4eca-8458-67ecd9372533', N'Mårten', N'Åberg', CAST(N'1995-11-13T00:00:00.000' AS DateTime), N'marten.aberg@swedishmail.se', CAST(N'2021-04-10T17:01:30.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'393614c1-45f6-40a7-b56a-70c96b294475', N'Mohamed', N'Saleh', CAST(N'2000-01-01T00:00:00.000' AS DateTime), N'mohamed.s@zoho.com', CAST(N'2019-06-01T12:50:40.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'ec019f54-8c64-4c92-8edd-772a2376004e', N'İsmail', N'Yılmaz', CAST(N'2000-02-27T00:00:00.000' AS DateTime), N'ismail.yilmaz@turkpost.com.tr', CAST(N'2020-05-16T20:51:19.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'b4a44f1c-f657-45b1-8405-a67cfc7c2b0c', N'Lúcia', N'Fernández', CAST(N'1985-05-08T00:00:00.000' AS DateTime), N'lucia.fernandez@correo.es', CAST(N'2023-08-06T12:30:13.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'1a2d3431-d00d-4dd8-939c-a8569b5749a2', N'Kai', N'Yamamoto', CAST(N'2005-08-01T00:00:00.000' AS DateTime), N'kai.y@icloud.com', CAST(N'2022-10-21T19:40:14.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'0719bd35-c735-4713-b6ea-b0010716da88', N'Sanjay', N'Patel', CAST(N'2002-12-13T00:00:00.000' AS DateTime), N'sanjay.p@hotmail.com', CAST(N'2019-06-21T17:25:03.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'b86026ed-a3f5-4062-bd1f-c4f8a87464a7', N'Kwame', N'Mensah', CAST(N'1999-03-09T00:00:00.000' AS DateTime), N'kwame.mensah@mail.com', CAST(N'2022-03-19T21:29:21.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'404e9b6c-b257-475c-afd1-c61039869107', N'John', N'Doe', CAST(N'1992-06-05T00:00:00.000' AS DateTime), N'jdoe420@gmail.com', CAST(N'2021-05-27T17:31:56.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'd3ef090d-5ad1-477c-8aa6-d8a6be790534', N'Chioma', N'Okafor', CAST(N'1993-08-27T00:00:00.000' AS DateTime), N'chioma.okafor@aol.com', CAST(N'2019-03-26T11:54:53.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'5e20846f-6616-4409-88d1-e2f4fef63fa3', N'Maya', N'Johnson', CAST(N'1992-09-21T00:00:00.000' AS DateTime), N'maya.j@msn.com', CAST(N'2021-06-03T02:20:42.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'4e6df9d4-95ff-48fe-96ab-e3ae2c602df3', N'Sergei', N'Petrov', CAST(N'1994-02-04T00:00:00.000' AS DateTime), N'sergei.p@yandex.com', CAST(N'2019-02-03T01:11:18.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'411d1eb6-c8a2-4ebe-8ca3-f48b4c833ec2', N'Ivan', N'Kovač', CAST(N'1992-03-24T00:00:00.000' AS DateTime), N'ivan.kovac.email@gmail.com', CAST(N'2019-10-28T19:51:18.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'68817e80-b624-4b6e-9c31-f9400a2fd9ac', N'Eléonore', N'Dûmont', CAST(N'2000-01-07T00:00:00.000' AS DateTime), N'eleonore.dumont@orange.fr', CAST(N'2021-03-20T04:17:41.000' AS DateTime))
GO
INSERT [dbo].[ThePeople] ([Id], [FirstName], [LastName], [DateOfBirth], [EmailAddress], [RegisteredOn]) VALUES (N'ee7000b6-3ace-4215-bbe2-fe483a57bb58', N'Chen', N'Wang', CAST(N'1999-11-08T00:00:00.000' AS DateTime), N'chen.wang@protonmail.com', CAST(N'2022-12-29T14:08:34.000' AS DateTime))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'8be19cb9-4983-45ba-9665-01e96291a9f6', N'Sesame Oil 5oz', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'8a079444-ba28-4656-9a92-037c5b434f26', N'Baking Soda 16oz', CAST(1.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'a9c05906-27ce-4f6c-8281-03dd967db4f7', N'Sweet Potatoes 1lb', CAST(1.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'890aeff9-0e36-4714-9121-0b190ce3732d', N'Sparkling Water 12-Pack', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'02cd9055-2d95-42de-8655-0d08071bab73', N'Canned Tomatoes 14oz', CAST(1.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'20cc7814-7337-4d2a-b81d-0e75fdf29deb', N'White Sugar 4lb', CAST(2.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'bdcefd78-93d4-41da-a591-12284f2661fb', N'Honey 12oz', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'1915d376-2ace-481d-99df-17fc091b4bb3', N'Apple Juice 64oz', CAST(2.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'4dce9608-2296-42f0-aeec-1e2b790fc387', N'Frozen Peas 16oz', CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'bdc334f5-5427-4baa-9095-24ef57650c8c', N'Ground Cinnamon 2.6oz', CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'05e59652-d170-43c7-b346-27fc9beb7828', N'Jarred Pickles 16oz', CAST(3.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'60acdc5f-0c13-48fc-9f8d-284381241e98', N'Popcorn 1kg', CAST(9.99 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'b4fc8321-752a-41c6-a72b-2883a6725322', N'Almond Butter 16oz', CAST(7.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'005fec1c-22da-484e-a855-2abe908df12d', N'Dijon Mustard 8oz', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'ff22aa9d-3cad-4113-8452-2ac037290bc6', N'Paprika 2.1oz', CAST(1.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'b7e58599-12a3-4fe3-8d25-3111022b4a88', N'Red Wine Vinegar 16oz', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'be383d4e-8e91-49b1-a30d-3122861cf369', N'Vegetable Broth 32oz', CAST(2.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'bb657e68-e161-403a-8247-31eca0da9c85', N'Instant Coffee 8oz', CAST(4.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'd854a6f2-9504-4f31-8de3-3ea271b77b19', N'Laundry Detergent 50oz', CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'3fb1b9f1-69b5-41a0-89f3-3ed5c64c019e', N'Ground Beef 1lb', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'c110c3bb-52c1-4043-b91d-4998e2a905b8', N'Coconut Milk 13.5oz', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'969000b8-ddf0-4360-ad74-58ecec44980d', N'Olive Oil Spray 7oz', CAST(3.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'07268e24-351a-4fa6-9e18-59ed83b17d60', N'Oregano Leaves 0.75oz', CAST(1.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'cc735a63-c796-450b-b5e0-5c13568857e8', N'Rice Cakes 14-Pack', CAST(2.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'5010d05f-5dce-4fea-8158-61a3873bf978', N'Aluminum Foil 30ft', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'c7fd2977-e536-40b6-aef8-69620971d51b', N'Canned Tuna 5oz', CAST(1.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'7f601dc7-8182-454c-b890-6a90d3cac9c9', N'Organic Eggs 12-Pack', CAST(5.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'1c77d1b4-a31c-4bc3-817b-7658f655a3ed', N'Cornstarch 16oz', CAST(1.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'21736824-1288-4fec-9ed6-817cc31437d9', N'Whole Nutmeg 1.5oz', CAST(2.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'1f296f45-60a1-4bb4-a417-834f316ba45e', N'Canned Chickpeas 15.5oz', CAST(0.90 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'18ba3259-85f5-49db-bfc3-8809d5f09bf9', N'Toilet Paper 6 Rolls', CAST(5.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'f0b90ac4-2532-4501-b4b4-8a2575fcc1dc', N'Kosher Salt 1lb', CAST(1.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'4508f8b1-f69b-428c-bcff-8c5430702b66', N'Black Peppercorns 4oz', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'a4f18f01-b8b9-4a90-bf16-916d8d6aa5df', N'Boneless Chicken Breast 1lb', CAST(3.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'4fa5d70d-aaa7-417a-be9a-926ff9eb2369', N'Chicken Stock 32oz', CAST(2.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'd799ba68-66a1-4415-8ae9-94a6f0e3281f', N'Chunky Peanut Butter 16oz', CAST(2.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'214f48c4-25ec-4d29-9c73-9591b6ec226f', N'Shredded Mozzarella Cheese 8oz', CAST(2.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'dbddf365-30f5-4e8b-89c3-9eac6acee722', N'All-Purpose Flour 5lb', CAST(2.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'92c36ece-225e-43c8-858e-9fe2643653bd', N'Baby Carrots 1lb', CAST(1.30 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'b9fac82d-af71-4083-beda-a172cb637f7d', N'Greek Yogurt 32oz', CAST(5.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'c9caa234-b77e-49ee-9b8a-a37fe299d355', N'Milk 1 Gallon', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'ae5a0fa5-cd05-4b2f-9113-a482827e3243', N'Granulated Sugar 5lb', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'66f57204-cbd1-4d96-81da-a8c9127ea954', N'Garlic Powder 3oz', CAST(2.20 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'bdd261ac-b8a2-431f-9af1-ab3b6ee6e850', N'Unsalted Butter 1lb', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'3d84d38f-130e-4ccc-9a4a-ab87328c51a1', N'Paper Towels 2 Rolls', CAST(3.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'3e5486e5-90dc-45bc-8dfd-b15083d50da5', N'Quinoa 16oz', CAST(4.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'2c469466-fd90-4493-887f-bc41151d2260', N'Basmati Rice 2lb', CAST(3.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'db849ca1-a30e-4994-bc24-bfc150b8f9af', N'Organic Brown Rice 2lb', CAST(3.60 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'2bb0557a-9177-4729-a4d9-c965302fa4eb', N'Olive Oil 500ml', CAST(8.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'455f24db-91d1-4a29-9987-d3ff9586e46a', N'Whole Wheat Pasta 16oz', CAST(2.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'17ebf1fb-9e4b-48da-b6ce-d70955034e05', N'Orange Juice 64oz', CAST(3.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'fdcf4f67-a8dc-4492-8303-e1efd99b9062', N'Soy Sauce 15oz', CAST(2.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'3407e211-a45e-44fd-8cf9-e3a2c2febbd5', N'Vanilla Extract 2oz', CAST(4.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'a5bd415d-c3a1-40e3-a3fd-e7f8c122a031', N'Ground Turkey 1lb', CAST(3.80 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'bbd515b4-2cbf-4675-b331-ea7f1599c24e', N'Frozen Mixed Vegetables 16oz', CAST(1.40 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'1e18946f-5944-4d1c-a3f9-ec1891f63aa1', N'Boxed Mac and Cheese', CAST(2.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'a7311d43-4e23-4607-84b1-ec452df9ca6d', N'Pork Tenderloin 1lb', CAST(4.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'6ade36ce-a155-440a-82e1-ee5f27b84c2c', N'White Bread Loaf', CAST(2.50 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'06c1b985-634f-45df-bc21-f69c21f856ae', N'Salmon Fillet 1lb', CAST(8.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'ae27d324-4541-4476-a463-f713e05c37ea', N'Coffee Grounds 12oz', CAST(6.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TheProducts] ([Id], [ProductName], [ProductPrice]) VALUES (N'92313420-50d6-463d-83ca-f8bdbce1e7a6', N'Whole-Wheat Spaghetti 16oz', CAST(1.50 AS Decimal(10, 2)))
GO
ALTER TABLE [dbo].[TheOrders]  WITH CHECK ADD  CONSTRAINT [FK_TheOrders_ThePeople_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[ThePeople] ([Id])
GO
ALTER TABLE [dbo].[TheOrders] CHECK CONSTRAINT [FK_TheOrders_ThePeople_CustomerId]
GO
ALTER TABLE [dbo].[TheOrdersTheProducts]  WITH CHECK ADD  CONSTRAINT [FK_TheOrdersTheProducts_TheOrders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[TheOrders] ([Id])
GO
ALTER TABLE [dbo].[TheOrdersTheProducts] CHECK CONSTRAINT [FK_TheOrdersTheProducts_TheOrders_OrderId]
GO
ALTER TABLE [dbo].[TheOrdersTheProducts]  WITH CHECK ADD  CONSTRAINT [FK_TheOrdersTheProducts_TheProducts_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[TheProducts] ([Id])
GO
ALTER TABLE [dbo].[TheOrdersTheProducts] CHECK CONSTRAINT [FK_TheOrdersTheProducts_TheProducts_ProductId]
GO
USE [master]
GO
ALTER DATABASE [MyDB] SET  READ_WRITE 
GO
