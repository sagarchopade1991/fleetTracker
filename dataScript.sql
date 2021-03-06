SET IDENTITY_INSERT [dbo].[Tenant] ON 

INSERT [dbo].[Tenant] ([id], [tenant], [description], [isActive], [isDeleted], [createdDate], [updatedDate], [createdBy], [updatedBy]) VALUES (1, N'India', N'India has fleet management to track vehicles', 1, 0, CAST(N'2021-07-07T13:19:42.523' AS DateTime), NULL, N'1', NULL)
SET IDENTITY_INSERT [dbo].[Tenant] OFF
GO
SET IDENTITY_INSERT [dbo].[TimeZone] ON 

INSERT [dbo].[TimeZone] ([id], [zoneId], [displayName], [baseUTCOffset], [createdDate], [updatedDate], [createdBy], [updatedBy]) VALUES (1, N'India Standard Time', N'(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi', 330, CAST(N'2021-07-07T13:20:41.430' AS DateTime), NULL, N'1', NULL)
SET IDENTITY_INSERT [dbo].[TimeZone] OFF
GO
SET IDENTITY_INSERT [dbo].[Fleet] ON 

INSERT [dbo].[Fleet] ([id], [name], [description], [tenantId], [timeZoneId], [metric], [speedLimit], [createdDate], [updatedDate], [createdBy], [updatedBy], [isActive], [isDeleted]) VALUES (1, N'Unassigned', N'Unassign Fleet is not assign to any one', 1, 1, 1, 25, CAST(N'2021-07-07T13:21:51.707' AS DateTime), NULL, N'1', NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Fleet] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [role], [description], [isActive], [isDeleted], [createdDate], [updatedDate], [createdBy], [updatedBy]) VALUES (1, N'SuperAdmin', N'SuperAdmin has application access', 1, 0, CAST(N'2021-07-07T13:17:50.447' AS DateTime), CAST(N'2021-07-07T13:17:50.447' AS DateTime), N'1', N'1')
INSERT [dbo].[Role] ([id], [role], [description], [isActive], [isDeleted], [createdDate], [updatedDate], [createdBy], [updatedBy]) VALUES (2, N'FleetOwner', N'FleetOwner has fleet level access', 1, 0, CAST(N'2021-07-07T13:18:39.330' AS DateTime), CAST(N'2021-07-07T13:18:39.330' AS DateTime), N'1', N'1')
INSERT [dbo].[Role] ([id], [role], [description], [isActive], [isDeleted], [createdDate], [updatedDate], [createdBy], [updatedBy]) VALUES (3, N'Driver', N'Driver has fleet level access', 1, 0, CAST(N'2021-07-07T13:19:07.413' AS DateTime), CAST(N'2021-07-07T13:19:07.413' AS DateTime), N'1', N'1')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [firstName], [lastName], [roleId], [tenantId], [mobileNo], [userName], [password], [createdDate], [updatedDate], [createdBy], [updatedBy], [isActive], [isDeleted]) VALUES (1, N'Unassigned', N'Driver', 3, 1, N'1234567890', N'unassigned@unassigned.com', N'$2b$10$EOAJcpk2vFqPkQmGsMvTpeg5m0/iT.L4UVtMt/BVcloTUGdwufCYe', CAST(N'2021-07-15T10:16:31.673' AS DateTime), CAST(N'2021-07-15T10:16:31.673' AS DateTime), N'1', N'1', 1, 0)
INSERT [dbo].[Users] ([id], [firstName], [lastName], [roleId], [tenantId], [mobileNo], [userName], [password], [createdDate], [updatedDate], [createdBy], [updatedBy], [isActive], [isDeleted]) VALUES (2, N'Shane', N'Miller', 1, 1, N'9056372828', N'superadmin@quest-global.com', N'$2b$10$RmM/JjByM/pkmPJqdgMeaOwHtLCGqLVWsUWeuxJckkNx/QxsQH.we', CAST(N'2021-08-09T07:50:14.690' AS DateTime), CAST(N'2021-09-08T03:43:46.510' AS DateTime), N'1', N'1', 1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Device] ON 

INSERT [dbo].[Device] ([id], [deviceSerialNumber], [tenantId], [deviceType], [isActive], [isDeleted], [createdDate], [updatedDate], [createdBy], [updatedBy], [IMEINumber]) VALUES (1, N'NoDevice', 1, 0, 1, 0, CAST(N'2021-07-08T07:49:46.467' AS DateTime), CAST(N'2021-07-08T07:49:46.467' AS DateTime), N'1', N'1', NULL)
SET IDENTITY_INSERT [dbo].[Device] OFF
GO
SET IDENTITY_INSERT [dbo].[GeofenceType] ON 

INSERT [dbo].[GeofenceType] ([id], [name], [createdDate], [updatedDate], [createdBy], [updatedBy], [isActive], [isDeleted]) VALUES (1, N'Circle', CAST(N'2021-07-14T06:17:00.793' AS DateTime), CAST(N'2021-07-14T06:17:00.793' AS DateTime), N'1', N'1', 1, 0)
SET IDENTITY_INSERT [dbo].[GeofenceType] OFF
GO
