
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/01/2015 10:42:12
-- Generated from EDMX file: C:\Users\Caleb\Google Drive\Southern\W15\Database\TrainProject\TrainProject\TrainDataModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [TrainDatabase];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_TrainSchedule]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Schedules] DROP CONSTRAINT [FK_TrainSchedule];
GO
IF OBJECT_ID(N'[dbo].[FK_ScheduleStopsAsc]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StopsAscs] DROP CONSTRAINT [FK_ScheduleStopsAsc];
GO
IF OBJECT_ID(N'[dbo].[FK_BookingTypeReservableSpace]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ReservableSpaces] DROP CONSTRAINT [FK_BookingTypeReservableSpace];
GO
IF OBJECT_ID(N'[dbo].[FK_TrainReservableSpace]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ReservableSpaces] DROP CONSTRAINT [FK_TrainReservableSpace];
GO
IF OBJECT_ID(N'[dbo].[FK_StationStopsAsc]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[StopsAscs] DROP CONSTRAINT [FK_StationStopsAsc];
GO
IF OBJECT_ID(N'[dbo].[FK_SegmentStationA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Segments] DROP CONSTRAINT [FK_SegmentStationA];
GO
IF OBJECT_ID(N'[dbo].[FK_SegmentStationB]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Segments] DROP CONSTRAINT [FK_SegmentStationB];
GO
IF OBJECT_ID(N'[dbo].[FK_StationTicketA]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_StationTicketA];
GO
IF OBJECT_ID(N'[dbo].[FK_StationTicketB]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_StationTicketB];
GO
IF OBJECT_ID(N'[dbo].[FK_ScheduleTicket]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_ScheduleTicket];
GO
IF OBJECT_ID(N'[dbo].[FK_CustomerTicket]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_CustomerTicket];
GO
IF OBJECT_ID(N'[dbo].[FK_TicketTicketedSpaceInt]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TicketedSpaceInts] DROP CONSTRAINT [FK_TicketTicketedSpaceInt];
GO
IF OBJECT_ID(N'[dbo].[FK_ReservableSpaceTicketedSpaceInt]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TicketedSpaceInts] DROP CONSTRAINT [FK_ReservableSpaceTicketedSpaceInt];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Trains]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Trains];
GO
IF OBJECT_ID(N'[dbo].[Schedules]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Schedules];
GO
IF OBJECT_ID(N'[dbo].[StopsAscs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[StopsAscs];
GO
IF OBJECT_ID(N'[dbo].[BookingTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BookingTypes];
GO
IF OBJECT_ID(N'[dbo].[ReservableSpaces]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ReservableSpaces];
GO
IF OBJECT_ID(N'[dbo].[Stations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Stations];
GO
IF OBJECT_ID(N'[dbo].[Segments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Segments];
GO
IF OBJECT_ID(N'[dbo].[Tickets]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tickets];
GO
IF OBJECT_ID(N'[dbo].[Customers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customers];
GO
IF OBJECT_ID(N'[dbo].[TicketedSpaceInts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TicketedSpaceInts];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Trains'
CREATE TABLE [dbo].[Trains] (
    [TrainID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Capacity] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Schedules'
CREATE TABLE [dbo].[Schedules] (
    [TrainRouteID] int IDENTITY(1,1) NOT NULL,
    [Train_TrainID] int  NOT NULL
);
GO

-- Creating table 'StopsAscs'
CREATE TABLE [dbo].[StopsAscs] (
    [StopID] int IDENTITY(1,1) NOT NULL,
    [ArrivalTime] nvarchar(max)  NOT NULL,
    [DepartureTime] nvarchar(max)  NOT NULL,
    [Schedule_TrainRouteID] int  NOT NULL,
    [Station_StationID] int  NOT NULL
);
GO

-- Creating table 'BookingTypes'
CREATE TABLE [dbo].[BookingTypes] (
    [TypeID] int IDENTITY(1,1) NOT NULL,
    [BookingDescription] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ReservableSpaces'
CREATE TABLE [dbo].[ReservableSpaces] (
    [CompartmentSeatNumber] int IDENTITY(1,1) NOT NULL,
    [BookingType_TypeID] int  NULL,
    [Train_TrainID] int  NOT NULL
);
GO

-- Creating table 'Stations'
CREATE TABLE [dbo].[Stations] (
    [StationID] int IDENTITY(1,1) NOT NULL,
    [StationName] nvarchar(max)  NOT NULL,
    [City] nvarchar(max)  NOT NULL,
    [Address] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Segments'
CREATE TABLE [dbo].[Segments] (
    [TrackSegmentID] int IDENTITY(1,1) NOT NULL,
    [StationIDA_StationID] int  NOT NULL,
    [StationsIDB_StationID] int  NOT NULL
);
GO

-- Creating table 'Tickets'
CREATE TABLE [dbo].[Tickets] (
    [TicketNumber] int IDENTITY(1,1) NOT NULL,
    [Type] nvarchar(max)  NOT NULL,
    [Date] datetime  NOT NULL,
    [StartStationID_StationID] int  NOT NULL,
    [EndStationID_StationID] int  NOT NULL,
    [TrainRouteID_TrainRouteID] int  NOT NULL,
    [CustomerID_CustomerID] int  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [CustomerID] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [DOB] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'TicketedSpaceInts'
CREATE TABLE [dbo].[TicketedSpaceInts] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Ticket_TicketNumber] int  NOT NULL,
    [ReservableSpace_CompartmentSeatNumber] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [TrainID] in table 'Trains'
ALTER TABLE [dbo].[Trains]
ADD CONSTRAINT [PK_Trains]
    PRIMARY KEY CLUSTERED ([TrainID] ASC);
GO

-- Creating primary key on [TrainRouteID] in table 'Schedules'
ALTER TABLE [dbo].[Schedules]
ADD CONSTRAINT [PK_Schedules]
    PRIMARY KEY CLUSTERED ([TrainRouteID] ASC);
GO

-- Creating primary key on [StopID] in table 'StopsAscs'
ALTER TABLE [dbo].[StopsAscs]
ADD CONSTRAINT [PK_StopsAscs]
    PRIMARY KEY CLUSTERED ([StopID] ASC);
GO

-- Creating primary key on [TypeID] in table 'BookingTypes'
ALTER TABLE [dbo].[BookingTypes]
ADD CONSTRAINT [PK_BookingTypes]
    PRIMARY KEY CLUSTERED ([TypeID] ASC);
GO

-- Creating primary key on [CompartmentSeatNumber] in table 'ReservableSpaces'
ALTER TABLE [dbo].[ReservableSpaces]
ADD CONSTRAINT [PK_ReservableSpaces]
    PRIMARY KEY CLUSTERED ([CompartmentSeatNumber] ASC);
GO

-- Creating primary key on [StationID] in table 'Stations'
ALTER TABLE [dbo].[Stations]
ADD CONSTRAINT [PK_Stations]
    PRIMARY KEY CLUSTERED ([StationID] ASC);
GO

-- Creating primary key on [TrackSegmentID] in table 'Segments'
ALTER TABLE [dbo].[Segments]
ADD CONSTRAINT [PK_Segments]
    PRIMARY KEY CLUSTERED ([TrackSegmentID] ASC);
GO

-- Creating primary key on [TicketNumber] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [PK_Tickets]
    PRIMARY KEY CLUSTERED ([TicketNumber] ASC);
GO

-- Creating primary key on [CustomerID] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([CustomerID] ASC);
GO

-- Creating primary key on [Id] in table 'TicketedSpaceInts'
ALTER TABLE [dbo].[TicketedSpaceInts]
ADD CONSTRAINT [PK_TicketedSpaceInts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Train_TrainID] in table 'Schedules'
ALTER TABLE [dbo].[Schedules]
ADD CONSTRAINT [FK_TrainSchedule]
    FOREIGN KEY ([Train_TrainID])
    REFERENCES [dbo].[Trains]
        ([TrainID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_TrainSchedule'
CREATE INDEX [IX_FK_TrainSchedule]
ON [dbo].[Schedules]
    ([Train_TrainID]);
GO

-- Creating foreign key on [Schedule_TrainRouteID] in table 'StopsAscs'
ALTER TABLE [dbo].[StopsAscs]
ADD CONSTRAINT [FK_ScheduleStopsAsc]
    FOREIGN KEY ([Schedule_TrainRouteID])
    REFERENCES [dbo].[Schedules]
        ([TrainRouteID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ScheduleStopsAsc'
CREATE INDEX [IX_FK_ScheduleStopsAsc]
ON [dbo].[StopsAscs]
    ([Schedule_TrainRouteID]);
GO

-- Creating foreign key on [BookingType_TypeID] in table 'ReservableSpaces'
ALTER TABLE [dbo].[ReservableSpaces]
ADD CONSTRAINT [FK_BookingTypeReservableSpace]
    FOREIGN KEY ([BookingType_TypeID])
    REFERENCES [dbo].[BookingTypes]
        ([TypeID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BookingTypeReservableSpace'
CREATE INDEX [IX_FK_BookingTypeReservableSpace]
ON [dbo].[ReservableSpaces]
    ([BookingType_TypeID]);
GO

-- Creating foreign key on [Train_TrainID] in table 'ReservableSpaces'
ALTER TABLE [dbo].[ReservableSpaces]
ADD CONSTRAINT [FK_TrainReservableSpace]
    FOREIGN KEY ([Train_TrainID])
    REFERENCES [dbo].[Trains]
        ([TrainID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_TrainReservableSpace'
CREATE INDEX [IX_FK_TrainReservableSpace]
ON [dbo].[ReservableSpaces]
    ([Train_TrainID]);
GO

-- Creating foreign key on [Station_StationID] in table 'StopsAscs'
ALTER TABLE [dbo].[StopsAscs]
ADD CONSTRAINT [FK_StationStopsAsc]
    FOREIGN KEY ([Station_StationID])
    REFERENCES [dbo].[Stations]
        ([StationID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_StationStopsAsc'
CREATE INDEX [IX_FK_StationStopsAsc]
ON [dbo].[StopsAscs]
    ([Station_StationID]);
GO

-- Creating foreign key on [StationIDA_StationID] in table 'Segments'
ALTER TABLE [dbo].[Segments]
ADD CONSTRAINT [FK_SegmentStationA]
    FOREIGN KEY ([StationIDA_StationID])
    REFERENCES [dbo].[Stations]
        ([StationID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SegmentStationA'
CREATE INDEX [IX_FK_SegmentStationA]
ON [dbo].[Segments]
    ([StationIDA_StationID]);
GO

-- Creating foreign key on [StationsIDB_StationID] in table 'Segments'
ALTER TABLE [dbo].[Segments]
ADD CONSTRAINT [FK_SegmentStationB]
    FOREIGN KEY ([StationsIDB_StationID])
    REFERENCES [dbo].[Stations]
        ([StationID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SegmentStationB'
CREATE INDEX [IX_FK_SegmentStationB]
ON [dbo].[Segments]
    ([StationsIDB_StationID]);
GO

-- Creating foreign key on [StartStationID_StationID] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [FK_StationTicketA]
    FOREIGN KEY ([StartStationID_StationID])
    REFERENCES [dbo].[Stations]
        ([StationID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_StationTicketA'
CREATE INDEX [IX_FK_StationTicketA]
ON [dbo].[Tickets]
    ([StartStationID_StationID]);
GO

-- Creating foreign key on [EndStationID_StationID] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [FK_StationTicketB]
    FOREIGN KEY ([EndStationID_StationID])
    REFERENCES [dbo].[Stations]
        ([StationID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_StationTicketB'
CREATE INDEX [IX_FK_StationTicketB]
ON [dbo].[Tickets]
    ([EndStationID_StationID]);
GO

-- Creating foreign key on [TrainRouteID_TrainRouteID] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [FK_ScheduleTicket]
    FOREIGN KEY ([TrainRouteID_TrainRouteID])
    REFERENCES [dbo].[Schedules]
        ([TrainRouteID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ScheduleTicket'
CREATE INDEX [IX_FK_ScheduleTicket]
ON [dbo].[Tickets]
    ([TrainRouteID_TrainRouteID]);
GO

-- Creating foreign key on [CustomerID_CustomerID] in table 'Tickets'
ALTER TABLE [dbo].[Tickets]
ADD CONSTRAINT [FK_CustomerTicket]
    FOREIGN KEY ([CustomerID_CustomerID])
    REFERENCES [dbo].[Customers]
        ([CustomerID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CustomerTicket'
CREATE INDEX [IX_FK_CustomerTicket]
ON [dbo].[Tickets]
    ([CustomerID_CustomerID]);
GO

-- Creating foreign key on [Ticket_TicketNumber] in table 'TicketedSpaceInts'
ALTER TABLE [dbo].[TicketedSpaceInts]
ADD CONSTRAINT [FK_TicketTicketedSpaceInt]
    FOREIGN KEY ([Ticket_TicketNumber])
    REFERENCES [dbo].[Tickets]
        ([TicketNumber])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_TicketTicketedSpaceInt'
CREATE INDEX [IX_FK_TicketTicketedSpaceInt]
ON [dbo].[TicketedSpaceInts]
    ([Ticket_TicketNumber]);
GO

-- Creating foreign key on [ReservableSpace_CompartmentSeatNumber] in table 'TicketedSpaceInts'
ALTER TABLE [dbo].[TicketedSpaceInts]
ADD CONSTRAINT [FK_ReservableSpaceTicketedSpaceInt]
    FOREIGN KEY ([ReservableSpace_CompartmentSeatNumber])
    REFERENCES [dbo].[ReservableSpaces]
        ([CompartmentSeatNumber])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ReservableSpaceTicketedSpaceInt'
CREATE INDEX [IX_FK_ReservableSpaceTicketedSpaceInt]
ON [dbo].[TicketedSpaceInts]
    ([ReservableSpace_CompartmentSeatNumber]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------