USE [master]
GO
/****** Object:  Database [s16guest64]    Script Date: 5/6/2016 4:14:55 PM ******/
CREATE DATABASE [s16guest64]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N's16guest64', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest64.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N's16guest64_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest64_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [s16guest64] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [s16guest64].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [s16guest64] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [s16guest64] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [s16guest64] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [s16guest64] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [s16guest64] SET ARITHABORT OFF 
GO
ALTER DATABASE [s16guest64] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [s16guest64] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest64] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [s16guest64] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest64] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [s16guest64] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [s16guest64] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [s16guest64] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [s16guest64] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [s16guest64] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [s16guest64] SET  ENABLE_BROKER 
GO
ALTER DATABASE [s16guest64] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [s16guest64] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [s16guest64] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [s16guest64] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [s16guest64] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [s16guest64] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [s16guest64] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [s16guest64] SET RECOVERY FULL 
GO
ALTER DATABASE [s16guest64] SET  MULTI_USER 
GO
ALTER DATABASE [s16guest64] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [s16guest64] SET DB_CHAINING OFF 
GO
ALTER DATABASE [s16guest64] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [s16guest64] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N's16guest64', N'ON'
GO
USE [s16guest64]
GO
/****** Object:  User [s16guest64]    Script Date: 5/6/2016 4:14:55 PM ******/
CREATE USER [s16guest64] FOR LOGIN [s16guest64] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest64]
GO
/****** Object:  StoredProcedure [dbo].[Customer_Insert]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jaren
-- Create date: 5/4/2016
-- Description:	Insert customer information
-- =============================================
CREATE PROCEDURE [dbo].[Customer_Insert] 
	-- Add the parameters for the stored procedure here
	@customer_ID int,
	@first_Name varchar(50), 
	@last_Name varchar(50),
	@company_ID  int,
	@company_Name varchar(50),
	@email varchar(50),
	@address_ID int,
	@street varchar(50),
	@city_Name varchar(50),
	@state_Name varchar(50),
	@zip varchar(50)
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO Customer(customer_ID, first_Name, last_Name, email)
	Values (@customer_ID, @first_Name, @last_Name, @email)

    -- Insert statements for procedure here
END

GO
/****** Object:  Table [dbo].[Address]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address](
	[adress_ID] [int] NOT NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip] [varchar](50) NULL,
	[country] [varchar](50) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[adress_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Branch](
	[branch_ID] [int] NOT NULL,
	[branch_Name] [varchar](50) NULL,
	[download_ID] [int] NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Company](
	[company_ID] [int] NOT NULL,
	[address_ID] [int] NULL,
	[company_Name] [varchar](40) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[company_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_ID] [int] NOT NULL,
	[person_ID] [int] NULL,
	[company_ID] [int] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer Release]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer Release](
	[customer_Release_ID] [int] NOT NULL,
	[release_ID] [int] NULL,
 CONSTRAINT [PK_Customer Release] PRIMARY KEY CLUSTERED 
(
	[customer_Release_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Download]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Download](
	[download_ID] [int] NOT NULL,
	[download_Address] [varchar](100) NULL,
	[times_Downloaded] [int] NULL,
 CONSTRAINT [PK_Download] PRIMARY KEY CLUSTERED 
(
	[download_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Download_Tracking]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Download_Tracking](
	[download_ID] [int] NOT NULL,
	[user_ID] [int] NULL,
	[release_ID] [int] NULL,
	[download_Date] [date] NULL,
 CONSTRAINT [PK_Download_Tracking] PRIMARY KEY CLUSTERED 
(
	[download_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Email]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Email](
	[email_ID] [int] NOT NULL,
	[person_ID] [int] NOT NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED 
(
	[email_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Features]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Features](
	[feature_ID] [int] NOT NULL,
	[new_Features] [varchar](200) NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[feature_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Iteration]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Iteration](
	[iteration_ID] [int] NOT NULL,
	[version_ID] [int] NULL,
 CONSTRAINT [PK_Iteration] PRIMARY KEY CLUSTERED 
(
	[iteration_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person](
	[person_ID] [int] NOT NULL,
	[first_Name] [varchar](50) NULL,
	[last_Name] [varchar](50) NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[person_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Phone](
	[phone_ID] [int] NOT NULL,
	[phone_Type] [varchar](20) NULL,
	[phone_Number] [varchar](20) NULL,
	[person_ID] [int] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[phone_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Platform]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Platform](
	[platform_ID] [int] NOT NULL,
	[platform_Name] [varchar](50) NULL,
 CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED 
(
	[platform_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[product_ID] [int] NOT NULL,
	[product_Name] [varchar](50) NULL,
	[product_Description] [varchar](50) NULL,
	[release_ID] [int] NULL,
	[customer_ID] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[product_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Release]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Release](
	[release_ID] [int] NOT NULL,
	[iteration_ID] [int] NULL,
	[release_Name] [varchar](20) NULL,
	[release_Date] [datetime] NULL,
	[release_Type] [varchar](50) NULL,
	[new_Features] [varchar](50) NULL,
	[release_Location] [varchar](50) NULL,
	[platform_ID] [int] NULL,
 CONSTRAINT [PK_Release] PRIMARY KEY CLUSTERED 
(
	[release_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[user_ID] [int] NOT NULL,
	[username] [varchar](50) NULL,
	[person_ID] [int] NULL,
	[password] [varchar](50) NULL,
	[admin] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[user_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Version]    Script Date: 5/6/2016 4:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Version](
	[version_ID] [int] NOT NULL,
	[branch_ID] [int] NULL,
	[version_Name] [varchar](20) NULL,
 CONSTRAINT [PK_Version] PRIMARY KEY CLUSTERED 
(
	[version_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Download] FOREIGN KEY([download_ID])
REFERENCES [dbo].[Download] ([download_ID])
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [FK_Branch_Download]
GO
ALTER TABLE [dbo].[Branch]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Download_Tracking] FOREIGN KEY([download_ID])
REFERENCES [dbo].[Download_Tracking] ([download_ID])
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [FK_Branch_Download_Tracking]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Address] FOREIGN KEY([address_ID])
REFERENCES [dbo].[Address] ([adress_ID])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Address]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Company] FOREIGN KEY([company_ID])
REFERENCES [dbo].[Company] ([company_ID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Company]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Person] FOREIGN KEY([person_ID])
REFERENCES [dbo].[Person] ([person_ID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Person]
GO
ALTER TABLE [dbo].[Customer Release]  WITH CHECK ADD  CONSTRAINT [FK_Customer Release_Release] FOREIGN KEY([release_ID])
REFERENCES [dbo].[Release] ([release_ID])
GO
ALTER TABLE [dbo].[Customer Release] CHECK CONSTRAINT [FK_Customer Release_Release]
GO
ALTER TABLE [dbo].[Download_Tracking]  WITH CHECK ADD  CONSTRAINT [FK_Download_Tracking_User] FOREIGN KEY([user_ID])
REFERENCES [dbo].[User] ([user_ID])
GO
ALTER TABLE [dbo].[Download_Tracking] CHECK CONSTRAINT [FK_Download_Tracking_User]
GO
ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_Person] FOREIGN KEY([person_ID])
REFERENCES [dbo].[Person] ([person_ID])
GO
ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_Person]
GO
ALTER TABLE [dbo].[Iteration]  WITH CHECK ADD  CONSTRAINT [FK_Iteration_Version] FOREIGN KEY([version_ID])
REFERENCES [dbo].[Version] ([version_ID])
GO
ALTER TABLE [dbo].[Iteration] CHECK CONSTRAINT [FK_Iteration_Version]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Person] FOREIGN KEY([person_ID])
REFERENCES [dbo].[Person] ([person_ID])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Person]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Customer] FOREIGN KEY([customer_ID])
REFERENCES [dbo].[Customer] ([customer_ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Customer]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Release] FOREIGN KEY([release_ID])
REFERENCES [dbo].[Release] ([release_ID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Release]
GO
ALTER TABLE [dbo].[Release]  WITH CHECK ADD  CONSTRAINT [FK_Release_Iteration1] FOREIGN KEY([iteration_ID])
REFERENCES [dbo].[Iteration] ([iteration_ID])
GO
ALTER TABLE [dbo].[Release] CHECK CONSTRAINT [FK_Release_Iteration1]
GO
ALTER TABLE [dbo].[Release]  WITH CHECK ADD  CONSTRAINT [FK_Release_Platform] FOREIGN KEY([platform_ID])
REFERENCES [dbo].[Platform] ([platform_ID])
GO
ALTER TABLE [dbo].[Release] CHECK CONSTRAINT [FK_Release_Platform]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Person] FOREIGN KEY([person_ID])
REFERENCES [dbo].[Person] ([person_ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Person]
GO
ALTER TABLE [dbo].[Version]  WITH CHECK ADD  CONSTRAINT [FK_Version_Branch] FOREIGN KEY([branch_ID])
REFERENCES [dbo].[Branch] ([branch_ID])
GO
ALTER TABLE [dbo].[Version] CHECK CONSTRAINT [FK_Version_Branch]
GO
USE [master]
GO
ALTER DATABASE [s16guest64] SET  READ_WRITE 
GO
