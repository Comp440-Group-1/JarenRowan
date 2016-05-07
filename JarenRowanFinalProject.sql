USE [master]
GO
/****** Object:  Database [s16guest64]    Script Date: 5/6/2016 9:26:13 PM ******/
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
/****** Object:  User [s16guest64]    Script Date: 5/6/2016 9:26:14 PM ******/
CREATE USER [s16guest64] FOR LOGIN [s16guest64] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest64]
GO
/****** Object:  StoredProcedure [dbo].[insert_Feature]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jaren Rowan
-- Create date: 5/6/2016
-- Description:	Update product with new version information
-- =============================================
CREATE PROCEDURE [dbo].[insert_Feature] 
	-- Add the parameters for the stored procedure here
	@product_Name varchar(50) = NULL,
	@new_Feature varchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @product_ID INT
	DECLARE @release_ID INT

	SELECT @product_ID = product_ID FROM dbo.Product WHERE dbo.Product.product_Name = @product_Name
	SELECT TOP 1 @release_ID = release_ID FROM dbo.Release WHERE dbo.Release.product_ID = @product_ID ORDER BY release_ID DESC	
	
	IF EXISTS(SELECT product_Name from dbo.Product WHERE product_Name = @product_Name)
		BEGIN
			INSERT INTO Features(new_Features, release_ID)
			Values (@new_Feature, @release_ID)
		END
	ELSE
		BEGIN
			PRINT 'The product does not exist'
			SELECT product_ID from dbo.Product WHERE product_Name = @product_Name
		END
END
GO
/****** Object:  StoredProcedure [dbo].[insert_Product]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jaren Rowan
-- Create date: 5/6/2016
-- Description:	Insert a new product into the product table
-- =============================================
CREATE PROCEDURE [dbo].[insert_Product]
	-- Add the parameters for the stored procedure here
	@product_Name varchar(50) = NULL, 
	@product_Description varchar(50) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT product_Name from dbo.Product WHERE product_Name = @product_Name)
		BEGIN
			INSERT INTO Product(product_Name, product_Description)
			Values (@product_Name, @product_Description)
		END
	ELSE
		BEGIN
			PRINT 'The product already exists'
			SELECT product_ID from dbo.Product WHERE product_Name = @product_Name
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[insert_Release]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jaren Rowan
-- Create date: 5/6/2016
-- Description:	Update product with new version information
-- =============================================
CREATE PROCEDURE [dbo].[insert_Release] 
	-- Add the parameters for the stored procedure here
	@product_Name varchar(50) = NULL,
	@version_Name varchar(50) = NULL,
	@release_Name varchar(50) = NULL,
	@release_Date date = NULL,
	@release_Type varchar(50) = NULL,
	@platform_Name varchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @product_ID INT
	DECLARE @release_ID INT
	DECLARE @version_ID INT
	DECLARE @platform_ID INT

	IF EXISTS(SELECT product_Name from dbo.Product WHERE product_Name = @product_Name)
		BEGIN
			SELECT @product_ID = product_ID FROM dbo.Product WHERE dbo.Product.product_Name = @product_Name
			SELECT TOP 1 @release_ID = release_ID FROM dbo.Release WHERE dbo.Release.product_ID = @product_ID ORDER BY release_ID DESC
			SELECT @version_ID = version_ID FROM dbo.Version WHERE dbo.Version.version_Name = @version_Name
			SELECT @platform_ID = platform_ID FROM dbo.Platform WHERE dbo.Platform.platform_Name = @platform_Name
			 	 		
			INSERT INTO Release(version_ID, release_Name, release_Date, release_Type, platform_ID, product_ID)
			Values (@version_ID, @release_Name, @release_Date, @release_Type, @platform_ID, @product_ID)
		END
	ELSE
		BEGIN
			PRINT 'The product does not exist'
			SELECT product_ID from dbo.Product WHERE product_Name = @product_Name
		END
END
GO
/****** Object:  StoredProcedure [dbo].[update_Product]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jaren Rowan
-- Create date: 5/6/2016
-- Description:	Update product with new version information
-- =============================================
CREATE PROCEDURE [dbo].[update_Product] 
	-- Parameters are the product's name and the new version of the product
	@product_Name varchar(50) = NULL, 
	@new_Version varchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @product_ID INT
	DECLARE @version_ID INT
	DECLARE @release_ID INT

	IF EXISTS(SELECT product_Name from dbo.Product WHERE product_Name = @product_Name)
		BEGIN
			SELECT @product_ID = product_ID FROM dbo.Product WHERE dbo.Product.product_Name = @product_Name
			SELECT TOP 1 @release_ID = release_ID FROM dbo.Release WHERE dbo.Release.product_ID = @product_ID ORDER BY release_ID DESC
			SELECT TOP 1 @version_ID = version_ID FROM dbo.Version WHERE dbo.Version.product_ID = @product_ID 
				and dbo.Version.version_Name = @new_Version ORDER BY version_ID DESC
			
			UPDATE dbo.Release
			SET version_ID=@version_ID
			WHERE release_ID=@release_ID
		END
	ELSE
		BEGIN
			PRINT 'The product does not exist'
			SELECT product_ID from dbo.Product WHERE product_Name = @product_Name
		END
		

    -- Insert statements for procedure here
	SELECT @product_Name, @new_Version
END

GO
/****** Object:  Table [dbo].[Address]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address](
	[adress_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Branch]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Branch](
	[branch_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Company]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Company](
	[company_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Customer]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_ID] [int] IDENTITY(1,1) NOT NULL,
	[person_ID] [int] NULL,
	[company_ID] [int] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer Release]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer Release](
	[customer_Release_ID] [int] IDENTITY(1,1) NOT NULL,
	[release_ID] [int] NULL,
 CONSTRAINT [PK_Customer Release] PRIMARY KEY CLUSTERED 
(
	[customer_Release_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Download]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Download](
	[download_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Download_Tracking]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Download_Tracking](
	[download_ID] [int] IDENTITY(1,1) NOT NULL,
	[user_ID] [int] NULL,
	[release_ID] [int] NULL,
	[download_Date] [date] NULL,
 CONSTRAINT [PK_Download_Tracking] PRIMARY KEY CLUSTERED 
(
	[download_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Email]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Email](
	[email_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Features]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Features](
	[feature_ID] [int] IDENTITY(1,1) NOT NULL,
	[new_Features] [varchar](200) NULL,
	[release_ID] [int] NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[feature_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Iteration]    Script Date: 5/6/2016 9:26:14 PM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person](
	[person_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Phone]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Phone](
	[phone_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Platform]    Script Date: 5/6/2016 9:26:14 PM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[product_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Release]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Release](
	[release_ID] [int] IDENTITY(1,1) NOT NULL,
	[version_ID] [int] NULL,
	[release_Name] [varchar](20) NULL,
	[release_Date] [datetime] NULL,
	[release_Type] [varchar](50) NULL,
	[release_Location] [varchar](50) NULL,
	[platform_ID] [int] NULL,
	[product_ID] [int] NULL,
 CONSTRAINT [PK_Release] PRIMARY KEY CLUSTERED 
(
	[release_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[user_ID] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Version]    Script Date: 5/6/2016 9:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Version](
	[version_ID] [int] IDENTITY(1,1) NOT NULL,
	[branch_ID] [int] NULL,
	[version_Name] [varchar](20) NULL,
	[version_Date] [date] NULL,
	[product_ID] [int] NULL,
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
ALTER TABLE [dbo].[Download]  WITH CHECK ADD  CONSTRAINT [FK_Download_Download_Tracking] FOREIGN KEY([download_ID])
REFERENCES [dbo].[Download_Tracking] ([download_ID])
GO
ALTER TABLE [dbo].[Download] CHECK CONSTRAINT [FK_Download_Download_Tracking]
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
ALTER TABLE [dbo].[Features]  WITH CHECK ADD  CONSTRAINT [FK_Features_Release] FOREIGN KEY([release_ID])
REFERENCES [dbo].[Release] ([release_ID])
GO
ALTER TABLE [dbo].[Features] CHECK CONSTRAINT [FK_Features_Release]
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
ALTER TABLE [dbo].[Release]  WITH CHECK ADD  CONSTRAINT [FK_Release_Platform] FOREIGN KEY([platform_ID])
REFERENCES [dbo].[Platform] ([platform_ID])
GO
ALTER TABLE [dbo].[Release] CHECK CONSTRAINT [FK_Release_Platform]
GO
ALTER TABLE [dbo].[Release]  WITH CHECK ADD  CONSTRAINT [FK_Release_Version] FOREIGN KEY([version_ID])
REFERENCES [dbo].[Version] ([version_ID])
GO
ALTER TABLE [dbo].[Release] CHECK CONSTRAINT [FK_Release_Version]
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
