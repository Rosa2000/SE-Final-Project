USE [master]
GO
/****** Object:  Database [SupplementFacts]    Script Date: 12/13/2022 7:37:34 AM ******/
CREATE DATABASE [SupplementFacts]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SupplementFacts', FILENAME = N'F:\TRYHARD\HK1 - 20222023\CNPM\SupplementFacts.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SupplementFacts_log', FILENAME = N'F:\TRYHARD\HK1 - 20222023\CNPM\SupplementFacts_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SupplementFacts] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SupplementFacts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SupplementFacts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SupplementFacts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SupplementFacts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SupplementFacts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SupplementFacts] SET ARITHABORT OFF 
GO
ALTER DATABASE [SupplementFacts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SupplementFacts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SupplementFacts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SupplementFacts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SupplementFacts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SupplementFacts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SupplementFacts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SupplementFacts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SupplementFacts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SupplementFacts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SupplementFacts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SupplementFacts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SupplementFacts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SupplementFacts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SupplementFacts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SupplementFacts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SupplementFacts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SupplementFacts] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SupplementFacts] SET  MULTI_USER 
GO
ALTER DATABASE [SupplementFacts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SupplementFacts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SupplementFacts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SupplementFacts] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SupplementFacts] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SupplementFacts] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SupplementFacts] SET QUERY_STORE = OFF
GO
ALTER AUTHORIZATION ON DATABASE::[SupplementFacts] TO [sa]
GO
USE [SupplementFacts]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agents](
	[ID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](max) NULL,
	[discount] [int] NULL,
 CONSTRAINT [PK_Agents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Agents] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[ID] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[total] [decimal](18, 0) NULL,
	[customerName] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
 CONSTRAINT [PK_CustomerOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[CustomerOrder] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[CustomerOrderDetails]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderDetails](
	[customerOrderID] [int] NOT NULL,
	[goodsID] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[total] [decimal](18, 0) NULL,
 CONSTRAINT [PK_CustomerOrderDetails] PRIMARY KEY CLUSTERED 
(
	[customerOrderID] ASC,
	[goodsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[CustomerOrderDetails] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[createDate] [datetime] NULL,
	[orderID] [int] NULL,
	[status] [nvarchar](max) NULL,
 CONSTRAINT [PK_Delivery_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Delivery] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Goods]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Goods](
	[ID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](max) NULL,
	[importPrice] [decimal](18, 0) NULL,
	[salePrice] [decimal](18, 0) NULL,
	[stock] [int] NULL,
 CONSTRAINT [PK_Goods] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Goods] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Order]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[createDate] [datetime] NULL,
	[agentID] [nvarchar](50) NULL,
	[discount] [int] NULL,
	[total] [decimal](18, 0) NULL,
	[paymentMethod] [nvarchar](50) NULL,
	[paymentStatus] [nvarchar](50) NULL,
	[orderStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Order] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[orderID] [int] NOT NULL,
	[goodsID] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[total] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC,
	[goodsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[OrderDetails] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[createDate] [datetime] NULL,
	[total] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Receipt] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Receipt] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[ReceiptDetails]    Script Date: 12/13/2022 7:37:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiptDetails](
	[receiptID] [int] NOT NULL,
	[goodsID] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[total] [decimal](18, 0) NULL,
 CONSTRAINT [PK_ReceiptDetails] PRIMARY KEY CLUSTERED 
(
	[receiptID] ASC,
	[goodsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[ReceiptDetails] TO  SCHEMA OWNER 
GO
INSERT [dbo].[Agents] ([ID], [name], [phone], [address], [discount]) VALUES (N'HCM07TP', N'Tan Phong', N'0123456789', N'19 Nguyen Huu Tho Street, Tan Phong Wart, District 7, Ho Chi Minh City', 5)
INSERT [dbo].[Agents] ([ID], [name], [phone], [address], [discount]) VALUES (N'HCMTDGM', N'Gigamall', N'0123654987', N'242 Pham Van Dong Street, Thu Duc City, Ho Chi Minh City', 7)
INSERT [dbo].[Agents] ([ID], [name], [phone], [address], [discount]) VALUES (N'HNHBT', N'Vincom Center Ba Trieu', N'0983320046', N'191 Ba Trieu Street, Le Dai Hanh Wart, Hai Ba Trung District, Ha Noi', 10)
GO
INSERT [dbo].[CustomerOrder] ([ID], [createDate], [total], [customerName], [phone], [address], [email]) VALUES (1, CAST(N'2022-11-04T02:05:18.433' AS DateTime), CAST(1100000 AS Decimal(18, 0)), N'Nhi', N'0123456789', N'19 A', N'rosa121120@gmail.com')
INSERT [dbo].[CustomerOrder] ([ID], [createDate], [total], [customerName], [phone], [address], [email]) VALUES (2, CAST(N'2022-12-13T02:09:13.113' AS DateTime), CAST(4444089 AS Decimal(18, 0)), N'Trần Thị Mỹ Nhi', N'0123456789', N'Ho Chi Minh', N'rosa121120@gmail.com')
INSERT [dbo].[CustomerOrder] ([ID], [createDate], [total], [customerName], [phone], [address], [email]) VALUES (3, CAST(N'2022-12-13T02:10:15.710' AS DateTime), CAST(5800000 AS Decimal(18, 0)), N'Trần Thị Mỹ Nhi', N'0123456789', N'Ho Chi Minh', N'rosa121120@gmail.com')
INSERT [dbo].[CustomerOrder] ([ID], [createDate], [total], [customerName], [phone], [address], [email]) VALUES (4, CAST(N'2022-12-13T02:12:18.440' AS DateTime), CAST(10500000 AS Decimal(18, 0)), N'Nhi Nhi', N'0123456789', N'Ho Chi Minh', N'rosa121120@gmail.com')
INSERT [dbo].[CustomerOrder] ([ID], [createDate], [total], [customerName], [phone], [address], [email]) VALUES (5, CAST(N'2022-12-13T02:14:41.987' AS DateTime), CAST(3944089 AS Decimal(18, 0)), N'Nhi Nhi', N'0123456789', N'Ho Chi Minh', N'rosa121120@gmail.com')
INSERT [dbo].[CustomerOrder] ([ID], [createDate], [total], [customerName], [phone], [address], [email]) VALUES (6, CAST(N'2022-12-13T02:20:43.727' AS DateTime), CAST(5594089 AS Decimal(18, 0)), N'Nhi Nhi', N'0123456789', N'Ho Chi Minh', N'rosa121120@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Delivery] ON 

INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (1, CAST(N'2022-12-05T12:46:07.577' AS DateTime), 9, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (2, CAST(N'2022-12-05T14:53:56.443' AS DateTime), 5, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (6, CAST(N'2022-12-05T15:51:41.527' AS DateTime), 4, N'Pending')
SET IDENTITY_INSERT [dbo].[Delivery] OFF
GO
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0001', N'SuperBeets - Daily Memory, Focus & Alertness, Without The Crash', CAST(1000000 AS Decimal(18, 0)), CAST(1100000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0002', N'Ultra High Absorption - Tumeric and Ginger, Vegan, Gluten Free, 90ct Gummies', CAST(1050000 AS Decimal(18, 0)), CAST(1150000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0003', N'Quest Nutrition Tortilla Style Protein Chips, Loaded Taco, Low Carb, Gluten Free, Baked, 1.1 Ounce', CAST(1120000 AS Decimal(18, 0)), CAST(1244089 AS Decimal(18, 0)), 1003)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0004', N'NuBest - Advanced Bone Strength Formula 60 Capsules (1 Pack)', CAST(2800000 AS Decimal(18, 0)), CAST(2900000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0005', N'Z Nutrition - Fitness EAAs (45 Total Servings)', CAST(850000 AS Decimal(18, 0)), CAST(950000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0006', N'Focus Factor -  Dietary Supplement 150 Tablets', CAST(500000 AS Decimal(18, 0)), CAST(650000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0007', N'Optimum Nutrition - Opti-Men 150 Tablets', CAST(800000 AS Decimal(18, 0)), CAST(900000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0008', N'Optimum Nutrition - Opti-Women 120 Tablets', CAST(600000 AS Decimal(18, 0)), CAST(680000 AS Decimal(18, 0)), 1004)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0009', N'GAT Sport - Caffeine 100 Tablets', CAST(300000 AS Decimal(18, 0)), CAST(350000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0010', N'SPECIES - Fiber Supplement Drink', CAST(500000 AS Decimal(18, 0)), CAST(650000 AS Decimal(18, 0)), 1000)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0011', N'SPECIES - High Molecular Weight Carbohydrates Banana Flavor', CAST(1000000 AS Decimal(18, 0)), CAST(1200000 AS Decimal(18, 0)), 1000)
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (4, CAST(N'2022-11-04T02:05:18.433' AS DateTime), N'HCM07TP', 5, CAST(16102500 AS Decimal(18, 0)), N'Momo', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (5, CAST(N'2022-12-04T02:07:23.797' AS DateTime), N'HCMTDGM', 7, CAST(5254500 AS Decimal(18, 0)), N'Momo', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (6, CAST(N'2022-12-04T12:46:00.793' AS DateTime), N'HCM07TP', 5, CAST(28905038 AS Decimal(18, 0)), N'Momo', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (7, CAST(N'2022-12-04T12:47:25.193' AS DateTime), N'HCM07TP', 5, CAST(8686885 AS Decimal(18, 0)), N'Momo', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (9, CAST(N'2022-12-04T12:59:07.517' AS DateTime), N'HCM07TP', 5, CAST(7725654 AS Decimal(18, 0)), N'Banking', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (10, CAST(N'2022-12-04T13:06:43.050' AS DateTime), N'HCM07TP', 5, CAST(6549385 AS Decimal(18, 0)), N'Banking', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (11, CAST(N'2022-12-04T13:21:40.173' AS DateTime), N'HCM07TP', 5, CAST(13414423 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (12, CAST(N'2022-12-04T13:22:27.097' AS DateTime), N'HCM07TP', 5, CAST(4180000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (13, CAST(N'2022-12-04T13:23:28.140' AS DateTime), N'HCM07TP', 5, CAST(3135000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (14, CAST(N'2022-12-04T15:16:23.777' AS DateTime), N'HNHBT', 10, CAST(8229680 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (15, CAST(N'2022-12-04T15:16:43.460' AS DateTime), N'HCM07TP', 5, CAST(10824385 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (21, CAST(N'2022-12-04T15:48:04.157' AS DateTime), N'HNHBT', 10, CAST(2970000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (4, N'SF0001', 6, CAST(330000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (4, N'SF0002', 9, CAST(517500 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (5, N'SF0001', 2, CAST(154000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (5, N'SF0002', 3, CAST(241500 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (6, N'SF0001', 20, CAST(1100000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (6, N'SF0002', 3, CAST(172500 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (6, N'SF0003', 4, CAST(248818 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (7, N'SF0001', 3, CAST(165000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (7, N'SF0002', 4, CAST(230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (7, N'SF0003', 1, CAST(62204 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (9, N'SF0001', 4, CAST(220000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (9, N'SF0003', 3, CAST(186613 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (10, N'SF0001', 2, CAST(110000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (10, N'SF0002', 3, CAST(172500 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (10, N'SF0003', 1, CAST(62204 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (11, N'SF0001', 3, CAST(165000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (11, N'SF0002', 4, CAST(230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (11, N'SF0003', 5, CAST(311022 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (12, N'SF0001', 4, CAST(220000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (13, N'SF0001', 3, CAST(165000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (14, N'SF0001', 3, CAST(330000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (14, N'SF0002', 4, CAST(460000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (14, N'SF0003', 1, CAST(124409 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (15, N'SF0001', 4, CAST(220000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (15, N'SF0002', 5, CAST(287500 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (15, N'SF0003', 1, CAST(62204 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (21, N'SF0001', 3, CAST(330000 AS Decimal(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Receipt] ON 

INSERT [dbo].[Receipt] ([ID], [createDate], [total]) VALUES (0, CAST(N'2022-11-29T21:46:30.370' AS DateTime), CAST(7050000 AS Decimal(18, 0)))
INSERT [dbo].[Receipt] ([ID], [createDate], [total]) VALUES (1, CAST(N'2022-12-04T15:30:40.547' AS DateTime), CAST(45360000 AS Decimal(18, 0)))
INSERT [dbo].[Receipt] ([ID], [createDate], [total]) VALUES (2, CAST(N'2022-12-05T14:01:56.633' AS DateTime), CAST(11360000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Receipt] OFF
GO
INSERT [dbo].[ReceiptDetails] ([receiptID], [goodsID], [quantity], [total]) VALUES (0, N'SF0001', 3, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[ReceiptDetails] ([receiptID], [goodsID], [quantity], [total]) VALUES (0, N'SF0002', 1, CAST(1050000 AS Decimal(18, 0)))
INSERT [dbo].[ReceiptDetails] ([receiptID], [goodsID], [quantity], [total]) VALUES (1, N'SF0001', 21, CAST(21000000 AS Decimal(18, 0)))
INSERT [dbo].[ReceiptDetails] ([receiptID], [goodsID], [quantity], [total]) VALUES (1, N'SF0003', 3, CAST(3360000 AS Decimal(18, 0)))
INSERT [dbo].[ReceiptDetails] ([receiptID], [goodsID], [quantity], [total]) VALUES (2, N'SF0003', 3, CAST(3360000 AS Decimal(18, 0)))
INSERT [dbo].[ReceiptDetails] ([receiptID], [goodsID], [quantity], [total]) VALUES (2, N'SF0008', 4, CAST(2400000 AS Decimal(18, 0)))
GO
/****** Object:  Index [IX_ReceiptDetails]    Script Date: 12/13/2022 7:37:35 AM ******/
CREATE NONCLUSTERED INDEX [IX_ReceiptDetails] ON [dbo].[ReceiptDetails]
(
	[receiptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Delivery] ADD  CONSTRAINT [DF_Delivery_status]  DEFAULT (N'New') FOR [status]
GO
ALTER TABLE [dbo].[Goods] ADD  CONSTRAINT [DF_Goods_stock]  DEFAULT ((0)) FOR [stock]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_paymentStatus]  DEFAULT (N'Unpaid') FOR [paymentStatus]
GO
ALTER TABLE [dbo].[CustomerOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderDetails_CustomerOrder] FOREIGN KEY([customerOrderID])
REFERENCES [dbo].[CustomerOrder] ([ID])
GO
ALTER TABLE [dbo].[CustomerOrderDetails] CHECK CONSTRAINT [FK_CustomerOrderDetails_CustomerOrder]
GO
ALTER TABLE [dbo].[CustomerOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderDetails_Goods] FOREIGN KEY([goodsID])
REFERENCES [dbo].[Goods] ([ID])
GO
ALTER TABLE [dbo].[CustomerOrderDetails] CHECK CONSTRAINT [FK_CustomerOrderDetails_Goods]
GO
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_Order]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Agents] FOREIGN KEY([agentID])
REFERENCES [dbo].[Agents] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Agents]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Goods] FOREIGN KEY([goodsID])
REFERENCES [dbo].[Goods] ([ID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Goods]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[ReceiptDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptDetails_Goods1] FOREIGN KEY([goodsID])
REFERENCES [dbo].[Goods] ([ID])
GO
ALTER TABLE [dbo].[ReceiptDetails] CHECK CONSTRAINT [FK_ReceiptDetails_Goods1]
GO
ALTER TABLE [dbo].[ReceiptDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReceiptDetails_Receipt1] FOREIGN KEY([receiptID])
REFERENCES [dbo].[Receipt] ([ID])
GO
ALTER TABLE [dbo].[ReceiptDetails] CHECK CONSTRAINT [FK_ReceiptDetails_Receipt1]
GO
USE [master]
GO
ALTER DATABASE [SupplementFacts] SET  READ_WRITE 
GO
