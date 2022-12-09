USE [SupplementFacts]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 12/9/2022 3:17:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[CustomerOrderDetails]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[Delivery]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[Goods]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[Receipt]    Script Date: 12/9/2022 3:17:51 PM ******/
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
/****** Object:  Table [dbo].[ReceiptDetails]    Script Date: 12/9/2022 3:17:51 PM ******/
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
INSERT [dbo].[Agents] ([ID], [name], [phone], [address], [discount]) VALUES (N'HCM07TP', N'Tan Phong', N'0123456789', N'19 Nguyen Huu Tho Street, Tan Phong Wart, District 7, Ho Chi Minh City', 5)
INSERT [dbo].[Agents] ([ID], [name], [phone], [address], [discount]) VALUES (N'HCMTDGM', N'Gigamall', N'0123654987', N'242 Pham Van Dong Street, Thu Duc City, Ho Chi Minh City', 7)
INSERT [dbo].[Agents] ([ID], [name], [phone], [address], [discount]) VALUES (N'HNHBT', N'Vincom Center Ba Trieu', N'0983320046', N'191 Ba Trieu Street, Le Dai Hanh Wart, Hai Ba Trung District, Ha Noi', 10)
GO
SET IDENTITY_INSERT [dbo].[Delivery] ON 

INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (1, CAST(N'2022-12-05T12:46:07.577' AS DateTime), 9, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (2, CAST(N'2022-12-05T14:53:56.443' AS DateTime), 5, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (6, CAST(N'2022-12-05T15:51:41.527' AS DateTime), 4, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (17, CAST(N'2022-12-08T16:05:48.410' AS DateTime), 6, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (18, CAST(N'2022-12-08T20:51:13.387' AS DateTime), 12, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (19, CAST(N'2022-12-08T20:58:41.467' AS DateTime), 7, N'Pending')
INSERT [dbo].[Delivery] ([ID], [createDate], [orderID], [status]) VALUES (20, CAST(N'2022-12-09T14:47:09.837' AS DateTime), 11, N'Pending')
SET IDENTITY_INSERT [dbo].[Delivery] OFF
GO
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0001', N'SuperBeets - Daily Memory, Focus & Alertness, Without The Crash', CAST(1000000 AS Decimal(18, 0)), CAST(1100000 AS Decimal(18, 0)), 987)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0002', N'Ultra High Absorption - Tumeric and Ginger, Vegan, Gluten Free, 90ct Gummies', CAST(1050000 AS Decimal(18, 0)), CAST(1150000 AS Decimal(18, 0)), 992)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0003', N'Quest Nutrition Tortilla Style Protein Chips, Loaded Taco, Low Carb, Gluten Free, Baked, 1.1 Ounce', CAST(1120000 AS Decimal(18, 0)), CAST(1244089 AS Decimal(18, 0)), 991)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0004', N'NuBest - Advanced Bone Strength Formula 60 Capsules (1 Pack)', CAST(2800000 AS Decimal(18, 0)), CAST(2900000 AS Decimal(18, 0)), 995)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0005', N'Z Nutrition - Fitness EAAs (45 Total Servings)', CAST(850000 AS Decimal(18, 0)), CAST(950000 AS Decimal(18, 0)), 988)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0006', N'Focus Factor -  Dietary Supplement 150 Tablets', CAST(500000 AS Decimal(18, 0)), CAST(650000 AS Decimal(18, 0)), 989)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0007', N'Optimum Nutrition - Opti-Men 150 Tablets', CAST(800000 AS Decimal(18, 0)), CAST(900000 AS Decimal(18, 0)), 991)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0008', N'Optimum Nutrition - Opti-Women 120 Tablets', CAST(600000 AS Decimal(18, 0)), CAST(680000 AS Decimal(18, 0)), 994)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0009', N'GAT Sport - Caffeine 100 Tablets', CAST(300000 AS Decimal(18, 0)), CAST(350000 AS Decimal(18, 0)), 994)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0010', N'SPECIES - Fiber Supplement Drink', CAST(500000 AS Decimal(18, 0)), CAST(650000 AS Decimal(18, 0)), 986)
INSERT [dbo].[Goods] ([ID], [name], [importPrice], [salePrice], [stock]) VALUES (N'SF0011', N'SPECIES - High Molecular Weight Carbohydrates Banana Flavor', CAST(1000000 AS Decimal(18, 0)), CAST(1200000 AS Decimal(18, 0)), 987)
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (4, CAST(N'2022-11-04T02:05:18.433' AS DateTime), N'HCM07TP', 5, CAST(16102500 AS Decimal(18, 0)), N'Momo', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (5, CAST(N'2022-12-04T02:07:23.797' AS DateTime), N'HCMTDGM', 7, CAST(5254500 AS Decimal(18, 0)), N'Momo', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (6, CAST(N'2022-12-04T12:46:00.793' AS DateTime), N'HCM07TP', 5, CAST(28905038 AS Decimal(18, 0)), N'Momo', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (7, CAST(N'2022-12-04T12:47:25.193' AS DateTime), N'HCM07TP', 5, CAST(8686885 AS Decimal(18, 0)), N'Momo', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (9, CAST(N'2022-12-04T12:59:07.517' AS DateTime), N'HCM07TP', 5, CAST(7725654 AS Decimal(18, 0)), N'Banking', N'Paid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (10, CAST(N'2022-12-04T13:06:43.050' AS DateTime), N'HCM07TP', 5, CAST(6549385 AS Decimal(18, 0)), N'Banking', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (11, CAST(N'2022-12-04T13:21:40.173' AS DateTime), N'HCM07TP', 5, CAST(13414423 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (12, CAST(N'2022-12-04T13:22:27.097' AS DateTime), N'HCM07TP', 5, CAST(4180000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'Confirmed')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (13, CAST(N'2022-12-04T13:23:28.140' AS DateTime), N'HCM07TP', 5, CAST(3135000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (14, CAST(N'2022-12-04T15:16:23.777' AS DateTime), N'HNHBT', 10, CAST(8229680 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (15, CAST(N'2022-12-04T15:16:43.460' AS DateTime), N'HCM07TP', 5, CAST(10824385 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (21, CAST(N'2022-12-04T15:48:04.157' AS DateTime), N'HNHBT', 10, CAST(2970000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (22, CAST(N'2022-12-08T21:11:01.190' AS DateTime), N'HCM07TP', 5, CAST(44741538 AS Decimal(18, 0)), N'Banking', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (23, CAST(N'2022-12-08T21:23:00.950' AS DateTime), N'HCM07TP', 5, CAST(48402923 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (24, CAST(N'2022-12-08T21:58:40.860' AS DateTime), N'HCM07TP', 5, CAST(4275000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (25, CAST(N'2022-12-08T22:13:02.993' AS DateTime), N'HCM07TP', 5, CAST(6680654 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
INSERT [dbo].[Order] ([ID], [createDate], [agentID], [discount], [total], [paymentMethod], [paymentStatus], [orderStatus]) VALUES (26, CAST(N'2022-12-09T14:33:35.597' AS DateTime), N'HCM07TP', 5, CAST(3420000 AS Decimal(18, 0)), N'Cash', N'Unpaid', N'New')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (4, N'SF0001', 6, CAST(6600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (4, N'SF0002', 9, CAST(10350000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (5, N'SF0001', 2, CAST(2200000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (5, N'SF0002', 3, CAST(3450000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (6, N'SF0001', 20, CAST(22000000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (6, N'SF0002', 3, CAST(3450000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (6, N'SF0003', 4, CAST(4976356 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (7, N'SF0001', 3, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (7, N'SF0002', 4, CAST(4600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (7, N'SF0003', 1, CAST(1244089 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (9, N'SF0001', 4, CAST(4400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (9, N'SF0003', 3, CAST(3732267 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (10, N'SF0001', 2, CAST(2200000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (10, N'SF0002', 3, CAST(3450000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (10, N'SF0003', 1, CAST(1244089 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (11, N'SF0001', 3, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (11, N'SF0002', 4, CAST(4600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (11, N'SF0003', 5, CAST(6220445 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (12, N'SF0001', 4, CAST(4400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (13, N'SF0001', 3, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (14, N'SF0001', 3, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (14, N'SF0002', 4, CAST(4600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (14, N'SF0003', 1, CAST(1244089 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (15, N'SF0001', 4, CAST(4400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (15, N'SF0002', 5, CAST(5750000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (15, N'SF0003', 1, CAST(1244089 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (21, N'SF0001', 3, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0001', 4, CAST(4400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0002', 4, CAST(4600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0003', 4, CAST(4976356 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0004', 4, CAST(11600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0005', 4, CAST(3800000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0006', 4, CAST(2600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0007', 4, CAST(3600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0008', 4, CAST(2720000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0009', 4, CAST(1400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0010', 4, CAST(2600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (22, N'SF0011', 4, CAST(4800000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0001', 4, CAST(4400000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0002', 2, CAST(2300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0003', 5, CAST(6220445 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0004', 1, CAST(2900000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0005', 8, CAST(7600000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0006', 7, CAST(4550000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0007', 5, CAST(4500000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0008', 6, CAST(4080000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0009', 2, CAST(700000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0010', 10, CAST(6500000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (23, N'SF0011', 6, CAST(7200000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (24, N'SF0001', 2, CAST(2200000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (24, N'SF0002', 2, CAST(2300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (25, N'SF0001', 3, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (25, N'SF0003', 3, CAST(3732267 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetails] ([orderID], [goodsID], [quantity], [total]) VALUES (26, N'SF0011', 3, CAST(3600000 AS Decimal(18, 0)))
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
