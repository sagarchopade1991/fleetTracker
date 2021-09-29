/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(     
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
            
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
            
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END
GO
/****** Object:  Table [dbo].[Alerts]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alerts](
	[alertId] [int] IDENTITY(1,1) NOT NULL,
	[vehicleId] [int] NOT NULL,
	[geofenceId] [int] NOT NULL,
	[severity] [tinyint] NOT NULL,
	[type] [tinyint] NOT NULL,
	[description] [nvarchar](256) NOT NULL,
	[updatedAt] [datetime] NOT NULL,
	[tripId] [int] NULL,
 CONSTRAINT [PK_Alerts] PRIMARY KEY CLUSTERED 
(
	[alertId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Device](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[deviceSerialNumber] [varchar](100) NOT NULL,
	[tenantId] [int] NOT NULL,
	[deviceType] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[IMEINumber] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fleet]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fleet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](max) NOT NULL,
	[description] [varchar](max) NULL,
	[tenantId] [int] NOT NULL,
	[timeZoneId] [int] NOT NULL,
	[metric] [int] NOT NULL,
	[speedLimit] [int] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FleetOwnerMapping]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FleetOwnerMapping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fleetId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FleetVehicleMapping]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FleetVehicleMapping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fleetId] [int] NOT NULL,
	[vehicleId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Geofence]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geofence](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[geofenceTypeId] [int] NOT NULL,
	[fleetId] [int] NOT NULL,
	[latitude] [decimal](11, 8) NOT NULL,
	[longitude] [decimal](11, 8) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[radius] [varchar](50) NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeofenceType]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeofenceType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeofenceVehicleMapping]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeofenceVehicleMapping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[geofenceId] [int] NOT NULL,
	[vehicleId] [int] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role] [varchar](100) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tenant]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tenant](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tenant] [varchar](100) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeZone]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeZone](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[zoneId] [varchar](200) NOT NULL,
	[displayName] [varchar](200) NOT NULL,
	[baseUTCOffset] [int] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trip]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trip](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vehicleId] [int] NOT NULL,
	[partition] [nvarchar](64) NOT NULL,
	[startTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[totalDistance] [nvarchar](max) NULL,
	[startLocation] [nvarchar](max) NULL,
	[endLocation] [nvarchar](max) NULL,
	[status] [int] NOT NULL,
	[isDeleted] [tinyint] NOT NULL,
 CONSTRAINT [PK_Trip] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](100) NOT NULL,
	[lastName] [varchar](100) NOT NULL,
	[roleId] [int] NOT NULL,
	[tenantId] [int] NOT NULL,
	[mobileNo] [varchar](100) NULL,
	[userName] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleData]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vehicleId] [int] NOT NULL,
	[parametersData] [varchar](max) NOT NULL,
	[uploadDate] [datetime] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[latitude] [decimal](11, 8) NULL,
	[longitude] [decimal](11, 8) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 23-09-2021 12:51:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[deviceId] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[driverUserId] [int] NOT NULL,
	[tenantId] [int] NOT NULL,
	[vin] [varchar](100) NOT NULL,
	[odometer] [int] NOT NULL,
	[passengersCount] [int] NULL,
	[registrationNo] [varchar](100) NULL,
	[make] [varchar](100) NULL,
	[model] [varchar](100) NULL,
	[manufacturingYear] [int] NULL,
	[manufacturingCountry] [varchar](100) NULL,
	[isActive] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[updatedBy] [varchar](50) NULL,
	[deviceSerialNumber] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Device] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Fleet] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[FleetOwnerMapping] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[FleetVehicleMapping] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Geofence] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[GeofenceType] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[GeofenceVehicleMapping] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Role] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Tenant] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[TimeZone] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Trip] ADD  CONSTRAINT [DF_Trip_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[VehicleData] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Vehicles] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Fleet]  WITH CHECK ADD FOREIGN KEY([tenantId])
REFERENCES [dbo].[Tenant] ([id])
GO
ALTER TABLE [dbo].[Fleet]  WITH CHECK ADD FOREIGN KEY([timeZoneId])
REFERENCES [dbo].[TimeZone] ([id])
GO
ALTER TABLE [dbo].[FleetOwnerMapping]  WITH CHECK ADD FOREIGN KEY([fleetId])
REFERENCES [dbo].[Fleet] ([id])
GO
ALTER TABLE [dbo].[FleetOwnerMapping]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[FleetVehicleMapping]  WITH CHECK ADD FOREIGN KEY([fleetId])
REFERENCES [dbo].[Fleet] ([id])
GO
ALTER TABLE [dbo].[FleetVehicleMapping]  WITH CHECK ADD FOREIGN KEY([vehicleId])
REFERENCES [dbo].[Vehicles] ([id])
GO
ALTER TABLE [dbo].[Geofence]  WITH CHECK ADD FOREIGN KEY([fleetId])
REFERENCES [dbo].[Fleet] ([id])
GO
ALTER TABLE [dbo].[Geofence]  WITH CHECK ADD FOREIGN KEY([geofenceTypeId])
REFERENCES [dbo].[GeofenceType] ([id])
GO
ALTER TABLE [dbo].[GeofenceVehicleMapping]  WITH CHECK ADD FOREIGN KEY([geofenceId])
REFERENCES [dbo].[Geofence] ([id])
GO
ALTER TABLE [dbo].[GeofenceVehicleMapping]  WITH CHECK ADD FOREIGN KEY([vehicleId])
REFERENCES [dbo].[Vehicles] ([id])
GO
ALTER TABLE [dbo].[Trip]  WITH CHECK ADD  CONSTRAINT [FK_Trip_Vehicle] FOREIGN KEY([vehicleId])
REFERENCES [dbo].[Vehicles] ([id])
GO
ALTER TABLE [dbo].[Trip] CHECK CONSTRAINT [FK_Trip_Vehicle]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([tenantId])
REFERENCES [dbo].[Tenant] ([id])
GO
ALTER TABLE [dbo].[VehicleData]  WITH CHECK ADD FOREIGN KEY([vehicleId])
REFERENCES [dbo].[Vehicles] ([id])
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD FOREIGN KEY([deviceId])
REFERENCES [dbo].[Device] ([id])
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD FOREIGN KEY([driverUserId])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD FOREIGN KEY([tenantId])
REFERENCES [dbo].[Tenant] ([id])
GO
/****** Object:  StoredProcedure [dbo].[GetFleetById]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetFleetById]
( 
@fleetId int 
,@tenantId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN  
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet retrive successfully.'
	DECLARE @fleet varchar(max)
	DECLARE @users varchar(max)
	DECLARE @vehicles varchar(max)

	BEGIN TRANSACTION
	BEGIN TRY

	IF EXISTS(SELECT 1 FROM dbo.Fleet(nolock) WHERE id = @fleetId AND isActive = 1 and tenantId = @tenantId)
	BEGIN
		select * from Fleet where id = @fleetId
		select * from Users where id IN (select userId from fleetOwnerMapping where fleetId = @fleetId)
		select * from Vehicles where id IN (select vehicleId from fleetVehicleMapping where fleetId = @fleetId)
		select id, zoneId, displayName from TimeZone
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Fleet not exists.'
	END

	END TRY
	BEGIN CATCH		
		SET @l_ResultMessage = N'Error occurred while getting Fleet by id.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[getFleetListByTenant]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getFleetListByTenant]
( 
@tenantId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN  
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet list retrive successfully.'
	DECLARE @fleetOwnerId VARCHAR(100) = (select id from Role where role = 'FleetOwner' )
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Fleet(nolock) WHERE tenantId = @tenantId AND isActive = 1 )
	BEGIN
		--select * from Fleet where tenantId = @tenantId AND name != 'Unassigned'
		--select fleetId, userId from fleetOwnerMapping where fleetId in (select id from Fleet where tenantId = @tenantId AND name != 'Unassigned')
		--select id, firstName, lastName, roleId from Users where roleId = @fleetOwnerId
		--select count(*) as vehicleCount, fleetId from FleetVehicleMapping where fleetId in (select id from Fleet where tenantId = @tenantId) group by fleetId
		select * from Fleet where tenantId = @tenantId
		select fleetId, userId from fleetOwnerMapping where fleetId in (select id from Fleet where tenantId = @tenantId)
		select id, firstName, lastName, roleId from Users where roleId = @fleetOwnerId
		select count(*) as vehicleCount, fleetId from FleetVehicleMapping where fleetId in (select id from Fleet where tenantId = @tenantId) group by fleetId
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Fleet not exists for a teanat.'
	END

	END TRY
	BEGIN CATCH		
		SET @l_ResultMessage = N'Error occurred while retriving Fleets by tenant.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[upsGetVehicleByDriverUserId]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[upsGetVehicleByDriverUserId]
( 
@tenantId int
,@userId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN  
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicle retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE driverUserId = @userId AND tenantId = @tenantId AND isActive = 1 AND isDeleted = 0)
	BEGIN
		select V.id as vehicleId, V.deviceId, V.name as vehicleName, V.driverUserId, V.deviceSerialNumber, V.vin, FVM.fleetId, F.metric, F.speedLimit 
		from Vehicles V
		inner Join FleetVehicleMapping FVM on V.id = FVM.vehicleId AND V.isActive = FVM.isActive AND V.isDeleted = FVM.isDeleted
		inner Join Fleet F on F.id = FVM.fleetId
		where V.driverUserId = @userId AND V.tenantId = @tenantId AND V.isActive = 1 AND V.isDeleted = 0;
		--select id as vehicleId, deviceId, name as vehicleName, driverUserId, deviceSerialNumber from Vehicles where driverUserId = @userId AND tenantId = @tenantId AND isActive = 1 AND isDeleted = 0;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicle not exists.'
	END

	END TRY
	BEGIN CATCH		
		SET @l_ResultMessage = N'Error occurred while retriving vehicle by driver userId.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspAssociateVehiclesWithGeofence]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspAssociateVehiclesWithGeofence]
@fleetId Int,
@geofenceId Int,
@vehicleIds varchar(100),
@createdBy varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicles associated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM GeofenceVehicleMapping(nolock) WHERE geofenceId = @geofenceId AND vehicleId in (SELECT CAST(Item AS int) FROM [dbo].[SplitString](@vehicleIds,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0) AND isActive = 1)
	BEGIN
		SET @l_ResultMessage = N'Vehicles already associated, Please check'
	END
	ELSE
	BEGIN
		INSERT INTO GeofenceVehicleMapping([geofenceId],[vehicleId],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy])
		SELECT @geofenceId,CAST(Item AS int),1,0,GETDATE(),GETDATE(),@createdBy,@createdBy FROM [dbo].[SplitString](@vehicleIds,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0
		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while associate vehicles.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspCreateDevice]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCreateDevice]
@deviceSerialNumber varchar(100)
,@tenantId int
,@deviceType int
,@createdBy varchar(100)  
,@IMEINumber varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Device created successfully.'

	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Device(nolock) WHERE deviceSerialNumber = RTRIM(LTRIM(@deviceSerialNumber)) AND isActive = 1 AND tenantId = @tenantId)
	BEGIN
		SET @l_ResultMessage = N'deviceSerialNumber already exists.'
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[Device]([deviceSerialNumber],[IMEINumber],[tenantId],[deviceType],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy]) 
		   VALUES(@deviceSerialNumber,@IMEINumber,@tenantId,@deviceType,1,0,GETDATE(),GETDATE(),@createdBy,@createdBy)

		SET @l_Id = SCOPE_IDENTITY()
	END
	
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while creating device.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspCreateFleet]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCreateFleet]
@name varchar(max)
,@description varchar(max)
,@tenantId int
,@timeZoneId int
,@metric int
,@speedLimit int
,@createdBy varchar(100)  	
,@fleetOwnerList varchar(100)
,@fleetVeicleList varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet created successfully.'

	BEGIN TRANSACTION
	BEGIN TRY

	IF EXISTS(SELECT 1 FROM dbo.Fleet(nolock) WHERE name = RTRIM(LTRIM(@name)) AND isDeleted = 0 and tenantId = @tenantId)
	BEGIN
		SET @l_ResultMessage = N'Fleet Name already exists.'
	END
	ELSE
	BEGIN
	
		INSERT INTO [dbo].[Fleet]([name],[description],[tenantId],[timeZoneId],[metric],[speedLimit],[createdDate],[updatedDate],[createdBy],[updatedBy],[isActive],[isDeleted])
		VALUES
		(RTRIM(LTRIM(@name))
		,@description
		,@tenantId
		,@timeZoneId
		,@metric
		,@speedLimit
		,GETDATE()
		,GETDATE()
		,@createdBy
		,@createdBy
		,1
		,0)

		SET @l_Id = SCOPE_IDENTITY()
		
		INSERT INTO [dbo].[FleetOwnerMapping]([fleetId],[userId],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy])
		SELECT @l_Id,CAST(Item AS int),1,0,GETDATE(),GETDATE(),@createdBy,@createdBy FROM [dbo].[SplitString](@fleetOwnerList,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0
		
		IF @fleetVeicleList IS NOT NULL AND LEN(@fleetVeicleList) > 0
		BEGIN
			DELETE FROM FleetVehicleMapping WHERE vehicleId in (SELECT CAST(Item AS int) FROM [dbo].[SplitString](@fleetVeicleList,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0) AND isActive = 1;
			INSERT INTO [dbo].[FleetVehicleMapping]
			SELECT @l_Id,CAST(Item AS int),1,0,GETDATE(),GETDATE(),@createdBy,@createdBy FROM [dbo].[SplitString](@fleetVeicleList,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0
		END
		
	END

	END TRY
	BEGIN CATCH		
		SET @l_ResultMessage = N'Error occurred while creating Fleet.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspCreateGeofence]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspCreateGeofence]
(  
@geofenceTypeId Int
,@fleetId Int
,@latitude DECIMAL(11,8)
,@longitude DECIMAL(11,8)
,@name varchar(100)
,@radius varchar(100)
,@createdBy varchar(100)  
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Geofence created successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Geofence(nolock) WHERE name = RTRIM(LTRIM(@name)) AND isDeleted = 0 AND isActive = 1)
	BEGIN
		SET @l_ResultMessage = N'Geofence Name already exists.'
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[Geofence]([name],[geofenceTypeId],[fleetId],[latitude],[longitude],[radius],[createdDate],[updatedDate],[createdBy],[updatedBy],[isActive],[isDeleted])
		VALUES(RTRIM(LTRIM(@name)),@geofenceTypeId,@fleetId,@latitude,@longitude,@radius,GETDATE(),GETDATE(),@createdBy,@createdBy,1,0)
		SET @l_Id = SCOPE_IDENTITY()	
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while creating geofence.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspCreateUser]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCreateUser]
@firstName varchar(100)
,@lastName varchar(100)
,@roleId int
,@tenantId int
,@mobileNo varchar(100)
,@userName varchar(100)
,@password varchar(100)
,@createdBy varchar(100)  	
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	print 'in sp 1';
	SET NOCOUNT ON;
	DECLARE @strUserId varchar(100) = ''
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'User created successfully.'

	BEGIN TRANSACTION
	BEGIN TRY
	print 'in sp 2';
	IF EXISTS(SELECT 1 FROM dbo.Users(nolock) WHERE userName = RTRIM(LTRIM(@userName)) AND isDeleted = 0)
	BEGIN
		SET @l_ResultMessage = N'User Name already exists.'
	END
	ELSE
	print 'in sp 4';
	BEGIN
		print 'in sp 3';
		declare @role varchar(100) = (SELECT TOP 1 role FROM dbo.Role WHERE id = @roleId AND isActive = 1 and isDeleted = 0)
		declare @fleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)
		declare @userId int = ''

		INSERT INTO [dbo].[Users]([firstName],[lastName],[roleId],[tenantId],[mobileNo],[userName],[password],[createdDate],[updatedDate],[createdBy],[updatedBy],[isActive],[isDeleted])		
		VALUES(@firstName,@lastName,@roleId,@tenantId,@mobileNo,RTRIM(LTRIM(@userName)),@password,GETDATE(),GETDATE(),@createdBy,@createdBy,1,0)

		SET @userId = SCOPE_IDENTITY()

		IF @role = 'FleetOwner' OR @role = 'Driver'
		BEGIN
			INSERT INTO [dbo].[FleetOwnerMapping]
           ([fleetId],[userId],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy])
			VALUES(@fleetId,@userId,1,0,GETDATE(),GETDATE(),@createdBy,@createdBy)
		END	

		SET @l_Id = @userId
	END
	
	END TRY
	BEGIN CATCH	
		print 'in sp 5';
		SET @l_ResultMessage = N'Error occurred while creating User.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	print 'in sp 6';
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspCreateVehicle]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspCreateVehicle]
@fleetId int
,@deviceId int
,@deviceSerialNumber varchar(100)
,@name varchar(100)
,@driverUserId int
,@tenantId int
,@vin varchar(100)
,@odometer int

,@passengersCount int
,@registrationNo varchar(100)
,@make varchar(100)
,@model varchar(100)
,@manufacturingYear int
,@manufacturingCountry varchar(100)
,@createdBy varchar(100)  	
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicle created successfully.'
	DECLARE @no_Device_Id INT = (SELECT id FROM Device where deviceSerialNumber = 'NoDevice') 

	BEGIN TRANSACTION
	BEGIN TRY
	IF @no_Device_Id != @deviceId AND EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE deviceId = @deviceId AND isActive = 1)
	BEGIN
		SET @l_ResultMessage = N'Device already assigned.'
	END
	ELSE IF EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE driverUserId = @driverUserId AND isActive = 1)
	BEGIN
		SET @l_ResultMessage = N'Driver already exists.'
	END
	ELSE
	BEGIN
		declare @vehicleId int = ''

		INSERT INTO [dbo].[Vehicles]([deviceId],[deviceSerialNumber],[name],[driverUserId],[tenantId],[vin],[odometer],[passengersCount],[registrationNo],
		[make],[model],[manufacturingYear],[manufacturingCountry],[isActive],[isDeleted],[createdDate],[createdBy])
     VALUES(@deviceId,@deviceSerialNumber,@name,@driverUserId,@tenantId,@vin,@odometer, @passengersCount,@registrationNo,
	 @make,@model,@manufacturingYear,@manufacturingCountry,1,0,GETDATE(),@createdBy)
	
		SET @vehicleId = SCOPE_IDENTITY()

		INSERT INTO [dbo].[FleetVehicleMapping]
        ([fleetId],[vehicleId],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy])
		VALUES(@fleetId,@vehicleId,1,0,GETDATE(),GETDATE(),@createdBy,@createdBy)
		
		SET @l_Id = @vehicleId
	END
	
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while creating Vehicle.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteDevices]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspDeleteDevices] 
(  
@deviceIds varchar(100),
@tenantId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Device Deleted successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE deviceId in (SELECT CAST(Item AS int) FROM [dbo].[SplitString](@deviceIds,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0) AND isActive = 1 AND tenantId = @tenantId)
	BEGIN
		SET @l_ResultMessage = N'Please first unassociate device then try to delete.'
	END
	ELSE
	BEGIN
		DELETE FROM Device WHERE id in (SELECT CAST(Item AS int) FROM [dbo].[SplitString](@deviceIds,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0) AND tenantId = @tenantId AND isActive = 1;	
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while deleting device.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '", "deviceIds":"' + @deviceIds + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteFleet]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspDeleteFleet] 
(  
@id int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet Deleted successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	
	IF NOT EXISTS(SELECT 1 FROM dbo.FleetOwnerMapping(nolock) WHERE fleetId = @id AND isActive = 1) AND NOT EXISTS(SELECT 1 FROM dbo.FleetVehicleMapping(nolock) WHERE fleetId = @id AND isActive = 1) AND NOT EXISTS(SELECT 1 FROM dbo.Geofence(nolock) WHERE fleetId = @id AND isActive = 1) AND EXISTS(SELECT 1 FROM dbo.Fleet(nolock) WHERE id = @id AND isActive = 1)
	BEGIN
		--DELETE FROM FleetOwnerMapping WHERE fleetId = @id;
		--DELETE FROM FleetVehicleMapping WHERE fleetId = @id;
		DELETE FROM Fleet WHERE id = @id;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Please unassociate owners, vehicles & delete geofence .'
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while deleting Fleet.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteGeofence]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDeleteGeofence]
@fleetId Int,
@geofenceId Int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Geofence deleted successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM Geofence(nolock) WHERE id = @geofenceId AND fleetId = @fleetId AND isActive = 1)
	BEGIN
		DELETE FROM GeofenceVehicleMapping WHERE geofenceId = @geofenceId;
		DELETE FROM Geofence WHERE id = @geofenceId AND fleetId = @fleetId AND isActive = 1
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Geofence not exist.'
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while deleting geofence.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspDeleteUser]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspDeleteUser] 
(  
@id int
,@roleId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'User Deleted successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	declare @role varchar(100) = (SELECT TOP 1 role FROM dbo.Role WHERE id = @roleId AND isActive = 1 and isDeleted = 0)
	declare @fleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)

	IF @role = 'SuperAdmin' AND EXISTS(SELECT 1 FROM dbo.Users(nolock) WHERE id = @id AND isActive = 1)
	BEGIN
		DELETE FROM Users WHERE id = @id;
	END
	ELSE IF @role = 'FleetOwner' AND NOT EXISTS(SELECT 1 FROM dbo.FleetOwnerMapping where userId = @id AND fleetId != @fleetId) AND EXISTS(SELECT 1 FROM dbo.Users(nolock) WHERE id = @id AND isActive = 1)
	BEGIN
		DELETE FROM FleetOwnerMapping WHERE userId = @id AND fleetId = @fleetId;
		DELETE FROM Users WHERE id = @id;
	END
	ELSE IF @role = 'Driver' AND NOT EXISTS(SELECT 1 FROM dbo.Vehicles where driverUserId = @id) AND EXISTS(SELECT 1 FROM dbo.Users(nolock) WHERE id = @id AND isActive = 1)
	BEGIN
		DELETE FROM FleetOwnerMapping WHERE userId = @id AND fleetId = @fleetId;
		DELETE FROM Users WHERE id = @id;
	END
	ELSE
	BEGIN
		IF @role = 'FleetOwner'
			SET @l_ResultMessage = N'Detach associated fleet, then try to delete'
		ELSE IF @role = 'Driver'
			SET @l_ResultMessage = N'Detach associated vehicle, then try to delete'
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while deleting User.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteVehicle]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspDeleteVehicle] 
(  
@id int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicle Deleted successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE id = @id AND isActive = 1)
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM dbo.GeofenceVehicleMapping(nolock) WHERE vehicleId = @id AND isActive = 1 AND isDeleted = 0)
		BEGIN
			DELETE FROM FleetVehicleMapping WHERE vehicleId = @id;
			DELETE FROM Vehicles WHERE id = @id;
		END
		ELSE
		BEGIN
			SET @l_ResultMessage = N'Remove vehicle from geofence.'
		END
		--DELETE FROM FleetVehicleMapping WHERE vehicleId = @id;
		--DELETE FROM Vehicles WHERE id = @id;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicle Inactive Or not exist.'
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while deleting vehicle.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetAlertsByVehicleIdAndDate]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetAlertsByVehicleIdAndDate]
@fleetId int
,@tenantId int
,@vehicleId int
,@startDate varchar(100)
,@endDate varchar(100)
,@tripId int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Alerts retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	
	IF EXISTS(SELECT 1 FROM dbo.Alerts(nolock) WHERE vehicleId = @vehicleId AND updatedAt > @startDate And updatedAt <= @endDate)
	BEGIN
			select A.alertId, A.vehicleId, A.geofenceId, A.severity, A.type, A.description, A.updatedAt, V.name as vehicleName, G.name as geofenceName
			from ALerts A
			inner join Vehicles V on A.vehicleId = V.id
			inner join Geofence G on A.geofenceId = G.id
			where A.vehicleId = @vehicleId AND A.tripId = @tripId AND A.updatedAt > @startDate And A.updatedAt <= @endDate
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Alerts not available.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving alerts.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetDashboardCounts]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetDashboardCounts]

AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Counts retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	    SELECT 'tenantCount' AS tableCount, COUNT(*) FROM Tenant
		UNION
		SELECT 'fleetCount' AS tableCount, COUNT(*) FROM Fleet where name != 'Unassigned'
		UNION
		SELECT 'vehicleCount' AS tableCount, COUNT(*) FROM Vehicles
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving Tenents, Fleets, Vehicles count.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetDataBySerialNumber]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetDataBySerialNumber]
@serialNumber varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Data Retruve successfully.'
	declare @vehicleId int = (SELECT TOP 1 id FROM dbo.Vehicles WHERE deviceSerialNumber=@serialNumber AND isActive =1 and isDeleted = 0)
	

	BEGIN TRANSACTION
	BEGIN TRY

        SELECT V.id, V.deviceId, V.deviceSerialNumber, V.name,V.driverUserId,V.tenantId, V.vin, V.odometer,V.passengersCount,V.registrationNo, V.make,V.model, V.manufacturingYear, V.manufacturingCountry, FVM.fleetId FROM dbo.Vehicles V
		inner join FleetVehicleMapping FVM on V.id = FVM.vehicleId
		WHERE V.deviceSerialNumber=@serialNumber AND V.isActive =1 and V.isDeleted = 0;

		SELECT TOP 1 * FROM Trip where vehicleId=@vehicleId AND status = 1 ORDER BY id DESC;
		SELECT * FROM VehicleData WHERE vehicleId=@vehicleId;

		--select G.id, G.geofenceTypeId, G.fleetId, G.latitude, G.longitude, G.name, G.radius from Geofence G
		--inner join GeofenceVehicleMapping GVM on G.id = GVM.geofenceId
		--where GVM.vehicleId = @vehicleId
		--SELECT * FROM dbo.Vehicles WHERE deviceSerialNumber=@serialNumber AND isActive =1 and isDeleted = 0;
		
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving Vehicle, vehicleTrip, vehicleData.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetDeviceDataByTenant]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetDeviceDataByTenant]
(  
@tenantId INT
) 
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Devices retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	
	IF EXISTS(SELECT 1 FROM dbo.Device(nolock) WHERE tenantId = @tenantId)
	BEGIN
		select * from Device where tenantId = @tenantId
		--select * from Device where deviceSerialNumber != 'NoDevice' AND tenantId  = @tenantId;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Devices not available for given tenant.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving tenant devices.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetFleetOwnerFleetList]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetFleetOwnerFleetList]
@tenantId int
,@userId int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet retrive successfully.'
	--DECLARE @pageNoOffset INT = ((@pageNo - 1) * @pageSize)
	--DECLARE @total INT = 0
	
	BEGIN TRANSACTION
	BEGIN TRY
	declare @role varchar(100) = (SELECT TOP 1 role FROM dbo.Role WHERE id = (select roleId from Users where id =@userId))
	declare @fleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)
	IF @role = 'SuperAdmin'
	BEGIN
		select * from Fleet where tenantId = @tenantId
	END
	ELSE IF @role = 'FleetOwner' AND EXISTS(SELECT 1 FROM dbo.FleetOwnerMapping(nolock) WHERE userId = @userId AND isActive = 1)
	BEGIN
		select * from Fleet where id in (select fleetId from FleetOwnerMapping where userId = @userId) and tenantId = @tenantId
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Fleet not assigned to user.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving fleets.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetGeofenceByFleetId]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetGeofenceByFleetId]
@fleetId int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Geofence retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Geofence(nolock) WHERE fleetId = @fleetId AND isActive = 1)
	BEGIN
		select * from Geofence where fleetId = @fleetId
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Geofence not available.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving geofence.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetGeofences]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[uspGetGeofences]
@vehicleId varchar(100)
,@tenantId varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Data Retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
		select G.id, G.geofenceTypeId, G.fleetId, G.latitude, G.longitude, G.name, G.radius from Geofence G
		inner join GeofenceVehicleMapping GVM on G.id = GVM.geofenceId
		where GVM.vehicleId = @vehicleId
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving Vehicles geofence.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END


GO
/****** Object:  StoredProcedure [dbo].[uspGetOnlineOfflineVehiclesByFleetId]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetOnlineOfflineVehiclesByFleetId]
@fleetId int
,@tenantId int
,@retrivTime DATETIME
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicle retrive successfully.'
	declare @unassignedFleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)

	BEGIN TRANSACTION
	BEGIN TRY
	IF @fleetId = 0
	SET @fleetId = @unassignedFleetId

	IF EXISTS(SELECT 1 FROM dbo.FleetVehicleMapping(nolock) WHERE fleetId = @fleetId AND isActive = 1)
	BEGIN
	  
		select V.id as vehicleId, V.deviceId, V.deviceSerialNumber, V.name as vehicleName, V.vin, V.make,  VD.uploadDate, SUM(CAST(T.totalDistance AS DECIMAL(7,2))) as totalDistance,
		 case 
		 When VD.uploadDate >= DATEADD(MINUTE,-5,@retrivTime) Then 1
		 else 0
		 end as isOnline, VD.parametersData, VD.latitude, VD.longitude
		 from Vehicles V
		 inner Join FleetVehicleMapping FVM on V.id = FVM.vehicleId AND V.isActive = FVM.isActive AND V.isDeleted = FVM.isDeleted
		 left Join VehicleData VD on V.id = VD.vehicleId
		  left Join Trip T on T.vehicleId = VD.vehicleId AND CAST(T.startTime as DATE) = CAST(GETDATE() as DATE) AND CAST(T.endTime as DATE) = CAST(GETDATE() as DATE)  
		 where FVM.fleetId = @fleetId AND V.tenantId = @tenantId
		 AND V.isActive = 1 AND V.isDeleted = 0 GROUP BY V.id, V.deviceId, V.deviceSerialNumber, V.name, V.vin, V.make,  VD.uploadDate,  VD.parametersData, VD.latitude, VD.longitude 

	  
	  --   select V.id as vehicleId, V.deviceId, V.deviceSerialNumber, V.name as vehicleName, V.vin, V.make, VD.uploadDate,
		 --case 
		 --When VD.uploadDate >= DATEADD(MINUTE,-5,@retrivTime) Then 1
		 --else 0
		 --end as isOnline, VD.parametersData, VD.latitude, VD.longitude
		 --from Vehicles V
		 --inner Join FleetVehicleMapping FVM on v.id = FVM.vehicleId AND v.isActive = FVM.isActive AND v.isDeleted = FVM.isDeleted
		 --left Join VehicleData VD on V.id = VD.vehicleId
		 --where fvm.fleetId = @fleetId AND v.tenantId = @tenantId
		 --AND v.isActive = 1 AND v.isDeleted = 0 
		 

		--select id, deviceId, deviceSerialNumber, name, driverUserId from Vehicles where id in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId) AND tenantId = @tenantId;
		--select id, vehicleId, uploadDate FROM VehicleData where uploadDate >= DATEADD(MINUTE,-5,@retrivTime) AND vehicleId in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId)
		--select id, deviceId, deviceSerialNumber, name, driverUserId from Vehicles where id in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId) AND tenantId = @tenantId;
		--select id, vehicleId, uploadDate FROM VehicleData where uploadDate >= DATEADD(MINUTE,-5,@retrivTime) AND vehicleId in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId)
		--select id, vehicleId, uploadDate from VehicleData where vehicleId in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId)
	    
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicles not available.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving Vehicles.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTenantsDeviceData]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTenantsDeviceData]
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Devices retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	
	IF EXISTS(SELECT 1 FROM dbo.Tenant(nolock) WHERE id = 1)
	BEGIN
		select count(*) as deviceCount, d.tenantId from Device d group By tenantId
		select * from Tenant
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Tenant not available.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving devices.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetTripListByFilter]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTripListByFilter]
@tenantId int,
@vehicleId int,
@recordStartDateStr varchar(100),
@recordEndDateStr varchar(100),
@pageNo int,
@pageSize int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Trip retrive successfully.'
	--declare @unassignedFleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)

	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM Trip(nolock) WHERE vehicleId = @vehicleId AND startTime >= @recordStartDateStr AND startTime < @recordEndDateStr)
	BEGIN
		
		SELECT T.id, T.vehicleId, T.partition as tripPartationKey, T.startTime, T.endTime, T.totalDistance as tripDistance, T.status, V.deviceSerialNumber, V.deviceId, tripCount.tCount AS totalCounts 
		FROM Trip T
		inner join Vehicles V on T.vehicleId = V.id
		CROSS JOIN (SELECT Count(*) AS tCount From Trip WHERE vehicleId = @vehicleId AND startTime >= @recordStartDateStr AND startTime < @recordEndDateStr) AS tripCount
		WHERE vehicleId = @vehicleId AND startTime >= @recordStartDateStr AND startTime < @recordEndDateStr 
		ORDER BY id OFFSET (@pageSize * (@pageNo - 1)) ROWS FETCH NEXT @pageSize ROWS ONLY;

		--SELECT T.id, T.vehicleId, T.partition as tripPartationKey, T.startTime, T.endTime, T.totalDistance as tripDistance, T.status, V.deviceSerialNumber, V.deviceId 
		--FROM Trip T
		--inner join Vehicles V on T.vehicleId = V.id
		--WHERE vehicleId = @vehicleId AND startTime >= @recordStartDateStr AND endTime < @recordEndDateStr;

	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Trip not available for given duration.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving trip.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetUnassociatedDeviceList]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetUnassociatedDeviceList]
(  
@tenantId INT
) 
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Unassociated device list retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	
	IF EXISTS(SELECT 1 FROM dbo.Device(nolock) WHERE tenantId = @tenantId AND id NOT in (select deviceId from Vehicles where deviceId != (select id from Device where deviceSerialNumber = 'NoDevice')))
	BEGIN
		select * from Device where id NOT in (select deviceId from Vehicles where deviceId != (select id from Device where deviceSerialNumber = 'NoDevice')) AND tenantId = @tenantId
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'All devices associated.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving Unassociated devices.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspGetUsersByRole]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetUsersByRole]
@userId int
,@role int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Retrive drivers successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	declare @roleId varchar(100) = (SELECT TOP 1 roleId FROM dbo.Users WHERE id = @userId AND isActive = 1 and isDeleted = 0)
	IF @roleId = 1
	BEGIN
		select id, firstName, lastName, roleId, mobileNo, userName, createdBy, updatedBy, createdDate, updatedDate from Users where roleId = @role
	END
	ELSE
	BEGIN
		 select FOM.fleetId, FVM.vehicleId, U.*, V.driverUserId from FleetOwnerMapping FOM
		 inner join fleetVehicleMapping FVM on FVM.fleetId = FOM.fleetId
		 inner join vehicles V on V.id = FVM.vehicleId
		 inner join users U on U.id = V.driverUserId
		 where FOM.userId in (@userId) AND U.isActive = 1 And U.isDeleted = 0
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving driver user.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetVehiclesByFleetId]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetVehiclesByFleetId]
@fleetId int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicle retrive successfully.'
	declare @unassignedFleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)

	BEGIN TRANSACTION
	BEGIN TRY
	IF @fleetId = 0
	SET @fleetId = @unassignedFleetId

	IF EXISTS(SELECT 1 FROM dbo.FleetVehicleMapping(nolock) WHERE fleetId = @fleetId AND isActive = 1)
	BEGIN
		select * from Vehicles where id in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId)
		select * from Device where id in (select deviceId from Vehicles where id in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId))
		select * from Users where id in (select driverUserId from Vehicles where id in (select VehicleId from FleetVehicleMapping where fleetId = @fleetId))
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicles not available.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving Vehicles.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspGetVehiclesByGeofenceIdAndFleetId]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetVehiclesByGeofenceIdAndFleetId]
@fleetId Int,
@geofenceId Int,
@type int
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicles retrive successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF @type = 0 AND EXISTS(SELECT 1 FROM GeofenceVehicleMapping(nolock) WHERE geofenceId = @geofenceId AND isActive = 1)
	BEGIN
		select * from Vehicles where id in (select vehicleId from GeofenceVehicleMapping where geofenceId = @geofenceId);
	END
	ELSE IF @type = 1 AND EXISTS(SELECT * FROM FleetVehicleMapping(nolock) WHERE fleetId = @fleetId AND isActive = 1)
	BEGIN
		select * from Vehicles where id in (SELECT vehicleId FROM FleetVehicleMapping WHERE fleetId = @fleetId) 
		select id from Vehicles where id in (select vehicleId from GeofenceVehicleMapping where geofenceId = @geofenceId);
	END
	ELSE
	BEGIN
		IF @type = 0
		SET @l_ResultMessage = N'Vehicles not Associated.'
		ELSE
		SET @l_ResultMessage = N'Vehicles not exist.'
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while retriving vehicles.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertTrip]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertTrip]
@vehicleId int
,@partition varchar(100)
,@startTime DATETIME
,@endTime DATETIME
,@totalDistance varchar(100)
,@status int
,@isDeleted TinyInt
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Trip inserted successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
		Insert into Trip (vehicleId, partition, startTime, endTime, totalDistance, status, isDeleted)
		values(@vehicleId, @partition, @startTime, @endTime, @totalDistance, @status, @isDeleted);
		SET @l_Id = SCOPE_IDENTITY();
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while inserting trip.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END



GO
/****** Object:  StoredProcedure [dbo].[uspInsertUpdateGeofenceAlert]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertUpdateGeofenceAlert]
@vehicleId int
,@geofenceId int
,@geofenceName varchar(100)
,@type int
,@updatedAt varchar(100)
,@description varchar(100)
,@tripId int 
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @lastType varchar(100) = (SELECT TOP 1 type FROM Alerts where vehicleId = @vehicleId AND geofenceId = @geofenceId ORDER BY alertId DESC)
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Alert inserted successfully.'

	BEGIN TRANSACTION
	BEGIN TRY
	IF NOT EXISTS(SELECT TOP 1 type FROM Alerts where vehicleId = @vehicleId AND geofenceId = @geofenceId ORDER BY alertId DESC)
	BEGIN
		INSERT INTO [dbo].[Alerts] ([vehicleId],[geofenceId],[severity],[type],[description],[updatedAt],[tripId])
     VALUES(@vehicleId,@geofenceId,1,@type,@description,@updatedAt, @tripId)
	END
	ELSE IF EXISTS(SELECT TOP 1 type FROM Alerts where vehicleId = @vehicleId AND geofenceId = @geofenceId ORDER BY alertId DESC) AND @lastType != @type
	BEGIN
		INSERT INTO [dbo].[Alerts] ([vehicleId],[geofenceId],[severity],[type],[description],[updatedAt],[tripId])
     VALUES(@vehicleId,@geofenceId,1,@type,@description,@updatedAt, @tripId)
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Alert type already exists.'
	END
	
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while inserting alert.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END

GO
/****** Object:  StoredProcedure [dbo].[uspInsertVehicleData]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertVehicleData]
@serialNumber varchar(100)
,@uploadDate DATETIME
,@parametersData varchar(max)
,@latitude DECIMAL(11,8)
,@longitude DECIMAL(11,8)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Data updated successfully.'
	declare @vehicleId int = (SELECT TOP 1 id FROM dbo.Vehicles WHERE deviceSerialNumber=@serialNumber AND isActive =1 and isDeleted = 0)
	

	BEGIN TRANSACTION
	BEGIN TRY
	SELECT * FROM dbo.Vehicles WHERE deviceSerialNumber=@serialNumber AND isActive =1 and isDeleted = 0
	IF EXISTS(SELECT 1 FROM dbo.VehicleData(nolock) WHERE vehicleId = @vehicleId)
	BEGIN
	    UPDATE VehicleData SET parametersData = @parametersData,latitude = @latitude,longitude = @longitude, uploadDate = @uploadDate, updatedDate = GETDATE() where vehicleId = @vehicleId;
	END
	ELSE IF NOT EXISTS(SELECT 1 FROM dbo.VehicleData(nolock) WHERE vehicleId = @vehicleId)
	BEGIN
		INSERT INTO VehicleData(vehicleId, parametersData, uploadDate, latitude, longitude, createdDate) VALUES(@vehicleId, @parametersData, @uploadDate, @latitude, @longitude,  GETDATE())
		SET @l_ResultMessage = N'Data inserted successfully.'
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicles not exist for serialNumber.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while inserting Vehicle data.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
/****** Object:  StoredProcedure [dbo].[uspUnassociateDeviceFromVehicle]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUnassociateDeviceFromVehicle] 
(  
@vehicleId int,
@tenantId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Device unassociated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	declare @NoDeviceId int = (SELECT TOP 1 id FROM dbo.Device WHERE deviceSerialNumber='NoDevice' AND tenantId = @tenantId AND isActive =1 and isDeleted = 0)
	IF EXISTS(SELECT deviceId FROM dbo.Vehicles where id = @vehicleId AND deviceId != @NoDeviceId AND tenantId = @tenantId )
	BEGIN
		--// added bellow 2 lins to delete trips & vehicle Data on device unassociation. because alway will get new trips on each time simulator starts 
		delete from Trip where vehicleId = @vehicleId;
		delete from VehicleData where vehicleId = @vehicleId;
		delete from Alerts where vehicleId = @vehicleId;
		--/////////
		UPDATE Vehicles SET deviceId = @NoDeviceId, deviceSerialNumber = 'NoDevice' WHERE id = @vehicleId;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicle not associated with Device.'
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while unassociate fleet owner & vehicle.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END

GO
/****** Object:  StoredProcedure [dbo].[uspUnassociateFleetFromUser]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[uspUnassociateFleetFromUser] 
(  
@userId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet unassociated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	--declare @role varchar(100) = (SELECT TOP 1 role FROM dbo.Role WHERE id = @roleId AND isActive = 1 and isDeleted = 0)
	declare @fleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)

	IF EXISTS(SELECT * FROM dbo.FleetOwnerMapping where userId = @userId AND fleetId != @fleetId)
	BEGIN
		DELETE FROM FleetOwnerMapping WHERE userId = @userId AND fleetId != @fleetId;
		--DELETE FROM Users WHERE id = @id;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'User not associated with any fleet.'
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while unassociate fleet.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END












GO
/****** Object:  StoredProcedure [dbo].[uspUnassociateUserFromFleet]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[uspUnassociateUserFromFleet] 
(  
@fleetId int
)  
AS  
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet owner & vehicle unassociated successfully.'
	declare @unassignedFleetId int = (SELECT TOP 1 id FROM dbo.Fleet WHERE name='Unassigned' AND isActive =1 and isDeleted = 0)
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.FleetOwnerMapping where fleetId = @fleetId)
	BEGIN
		DELETE FROM FleetOwnerMapping WHERE fleetId = @fleetId;
		IF EXISTS(SELECT 1 FROM dbo.FleetVehicleMapping where fleetId = @fleetId)
		BEGIN
			UPDATE [dbo].[FleetVehicleMapping] SET [fleetId] = @unassignedFleetId WHERE fleetId=@fleetId;

			--DELETE FROM FleetVehicleMapping WHERE fleetId = @fleetId;
		END
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Fleet not associated with user.'
	END

	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while unassociate fleet owner & vehicle.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END


GO
/****** Object:  StoredProcedure [dbo].[uspUnassociateVehiclesFromGeofence]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspUnassociateVehiclesFromGeofence]
@fleetId Int,
@geofenceId Int,
@vehicleIds varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicles unassociated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM GeofenceVehicleMapping(nolock) WHERE geofenceId = @geofenceId AND vehicleId in (SELECT CAST(Item AS int) FROM [dbo].[SplitString](@vehicleIds,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0) AND isActive = 1)
	BEGIN
		DELETE FROM GeofenceVehicleMapping WHERE geofenceId = @geofenceId AND vehicleId in (SELECT CAST(Item AS int) FROM [dbo].[SplitString](@vehicleIds,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0);
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicles not associated with geofence.'
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while unassociate vehicles from geofence.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspUpdateFleet]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateFleet]
@id INT
,@name varchar(max)
,@description varchar(max)
,@tenantId int
,@timeZoneId int
,@metric int
,@speedLimit int
,@updatedBy varchar(100)  	
,@fleetOwnerList varchar(100)
,@fleetVeicleList varchar(100)
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Fleet updated successfully.'

	BEGIN TRANSACTION
	BEGIN TRY

	--IF EXISTS(SELECT 1 FROM dbo.Fleet(nolock) WHERE id = @id AND isDeleted = 0 and tenantId = @tenantId)
	--BEGIN
	--	SET @l_ResultMessage = N'Fleet Name already exists.'
	--END
	--ELSE
	BEGIN
		UPDATE Fleet SET name=RTRIM(LTRIM(@name)), description=@description, tenantId=@tenantId, timeZoneId=@timeZoneId, metric=@metric, speedLimit=@speedLimit, updatedBy=@updatedBy, updatedDate=GETDATE() WHERE id = @id;
		SET @l_Id = @id
		
		Delete from FleetOwnerMapping where fleetId = @id;
		Delete from FleetVehicleMapping where fleetId = @id;
		
		INSERT INTO [dbo].[FleetOwnerMapping]([fleetId],[userId],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy])
		SELECT @l_Id,CAST(Item AS int),1,0,GETDATE(),GETDATE(),@updatedBy,@updatedBy FROM [dbo].[SplitString](@fleetOwnerList,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0
		
		IF @fleetVeicleList IS NOT NULL AND LEN(@fleetVeicleList) > 0
		INSERT INTO [dbo].[FleetVehicleMapping]
		SELECT @l_Id,CAST(Item AS int),1,0,GETDATE(),GETDATE(),@updatedBy,@updatedBy FROM [dbo].[SplitString](@fleetVeicleList,',') WHERE CAST(Item AS int) IS NOT NULL AND CAST(Item AS int) > 0

	END

	END TRY
	BEGIN CATCH		
		SET @l_ResultMessage = N'Error occurred while updating Fleet.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateGeofence]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspUpdateGeofence]
@id int
,@geofenceTypeId Int
,@fleetId Int
,@latitude DECIMAL(11,8)
,@longitude DECIMAL(11,8)
,@name varchar(100)
,@radius varchar(100)
,@updatedBy varchar(100)  
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_ResultMessage VARCHAR(500) = N'Geofence updated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Geofence(nolock) WHERE id = @id AND fleetId = @fleetId AND isActive = 1)
	BEGIN
		UPDATE Geofence SET geofenceTypeId = @geofenceTypeId, latitude = @latitude, longitude = @longitude, name = @name, radius=@radius, updatedBy = @updatedBy WHERE id = @id AND fleetId = @fleetId AND isActive = 1 ;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Geofence not available.'		
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while updating geofence.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END

GO
/****** Object:  StoredProcedure [dbo].[uspUpdateTrip]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateTrip]
@id Int
,@vehicleId Int
,@partition varchar(100)
,@startTime DATETIME
,@endTime DATETIME
,@totalDistance varchar(100)
,@status TinyInt
,@isDeleted TinyInt
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Trip updated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Trip(nolock) WHERE id = @id AND vehicleId = @vehicleId AND status = 1)
	BEGIN
		UPDATE Trip SET partition=@partition, endTime=@endTime, totalDistance=@totalDistance, isDeleted=@isDeleted, status=@status WHERE id = @id AND vehicleId = @vehicleId AND status = 1;
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Trip not exists.'
	END
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while updating trip.'
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END


GO
/****** Object:  StoredProcedure [dbo].[uspUpdateUser]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateUser]
@id INT
,@firstName varchar(100)
,@lastName varchar(100)
,@roleId int
,@tenantId int
,@mobileNo varchar(100)
,@updatedBy varchar(100)  	
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'User Updated successfully.'
	
	BEGIN TRANSACTION
	BEGIN TRY
	IF EXISTS(SELECT 1 FROM dbo.Users(nolock) WHERE id = @id AND isActive = 0)
	BEGIN
		SET @l_ResultMessage = N'User Inactive.'
	END
	ELSE
	BEGIN
		UPDATE Users SET firstName=@firstName, lastName=@lastName, roleId=@roleId, tenantId=@tenantId, mobileNo=@mobileNo, updatedBy=@updatedBy, updatedDate=GETDATE() WHERE id = @id;
		SET @l_Id = @id
	END

	END TRY
	BEGIN CATCH	
		print 'in sp 5';
		SET @l_ResultMessage = N'Error occurred while updating User.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	print 'in sp 6';
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@id AS VARCHAR(100)) + '"}'
	SELECT @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
END
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateVehicle]    Script Date: 23-09-2021 12:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateVehicle]
@deviceSerialNumber varchar(100),
@id int
,@fleetId int
,@deviceId int
,@name varchar(100)
,@driverUserId int
,@tenantId int
,@vin varchar(100)
,@odometer int

,@passengersCount int
,@registrationNo varchar(100)
,@make varchar(100)
,@model varchar(100)
,@manufacturingYear int
,@manufacturingCountry varchar(100)
,@updatedBy varchar(100)  	
AS
DECLARE @ResultVal VARCHAR(500)
BEGIN
	SET NOCOUNT ON;
	DECLARE @l_Id INT = 0
	DECLARE @l_ResultMessage VARCHAR(500) = N'Vehicle updated successfully.'

	BEGIN TRANSACTION
	BEGIN TRY
	declare @unassignedDriverId int = (SELECT TOP 1 id FROM dbo.Users WHERE userName='unassigned@unassigned.com' AND isActive =1 and isDeleted = 0)
	--IF EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE id != @id AND driverUserId = @driverUserId AND driverUserId != @unassignedDriverId AND isActive = 1)
	IF  @driverUserId != @unassignedDriverId AND  EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE id != @id AND driverUserId = @driverUserId AND isActive = 1)
	BEGIN
		SET @l_ResultMessage = N'Driver already exists.'
	END
	ELSE IF EXISTS(SELECT 1 FROM dbo.Vehicles(nolock) WHERE id=@id AND isActive = 1)
	BEGIN
		UPDATE [dbo].[Vehicles] SET [deviceId] = @deviceId, [deviceSerialNumber] = @deviceSerialNumber, [name] = @name,[driverUserId] = @driverUserId,[vin] = @vin,[odometer] = @odometer,[passengersCount] = @passengersCount,[registrationNo] = @registrationNo,[make] = @make,[model] = @model,[manufacturingYear] = @manufacturingYear,[manufacturingCountry] = @manufacturingCountry,[updatedDate] = GETDATE(),[updatedBy] = @updatedBy 
		WHERE id=@id
		
		Delete from FleetVehicleMapping where vehicleId = @id
		
		
		INSERT INTO [dbo].[FleetVehicleMapping]
        ([fleetId],[vehicleId],[isActive],[isDeleted],[createdDate],[updatedDate],[createdBy],[updatedBy])
		VALUES(@fleetId,@id,1,0,GETDATE(),GETDATE(),@updatedBy,@updatedBy)
		
		SET @l_Id = @id
	END
	ELSE
	BEGIN
		SET @l_ResultMessage = N'Vehicle not exists.'
	END
	
	END TRY
	BEGIN CATCH	
		SET @l_ResultMessage = N'Error occurred while updating Vehicle.'
		SET @l_Id = -1		
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION;  		
	END CATCH
	print 'in sp 6';
	
	SET @ResultVal ='{"status":"' + @l_ResultMessage + '","Id": "' + CAST(@l_Id AS VARCHAR(100)) + '"}'
	select @ResultVal
	IF @@TRANCOUNT > 0  			
        COMMIT TRANSACTION	
	
END
GO
ALTER DATABASE [testteg-fleettracker] SET  READ_WRITE 
GO
