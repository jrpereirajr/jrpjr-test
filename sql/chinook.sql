-- SQL Schema export
-- Tables created without foreign keys initially
-- Foreign keys added at the end

DROP SCHEMA IF EXISTS chinook CASCADE
GO

CREATE SCHEMA chinook
GO

CREATE TABLE IF NOT EXISTS "chinook"."Album" (
    "AlbumId" INTEGER NOT NULL PRIMARY KEY,
    "Title" NVARCHAR(160) NOT NULL,
    "ArtistId" INTEGER NOT NULL
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Artist" (
    "ArtistId" INTEGER NOT NULL PRIMARY KEY,
    "Name" NVARCHAR(120)
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Customer" (
    "CustomerId" INTEGER NOT NULL PRIMARY KEY,
    "FirstName" NVARCHAR(40) NOT NULL,
    "LastName" NVARCHAR(20) NOT NULL,
    "Company" NVARCHAR(80),
    "Address" NVARCHAR(70),
    "City" NVARCHAR(40),
    "State" NVARCHAR(40),
    "Country" NVARCHAR(40),
    "PostalCode" NVARCHAR(10),
    "Phone" NVARCHAR(24),
    "Fax" NVARCHAR(24),
    "Email" NVARCHAR(60) NOT NULL,
    "SupportRepId" INTEGER
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Employee" (
    "EmployeeId" INTEGER NOT NULL PRIMARY KEY,
    "LastName" NVARCHAR(20) NOT NULL,
    "FirstName" NVARCHAR(20) NOT NULL,
    "Title" NVARCHAR(30),
    "ReportsTo" INTEGER,
    "BirthDate" DATETIME,
    "HireDate" DATETIME,
    "Address" NVARCHAR(70),
    "City" NVARCHAR(40),
    "State" NVARCHAR(40),
    "Country" NVARCHAR(40),
    "PostalCode" NVARCHAR(10),
    "Phone" NVARCHAR(24),
    "Fax" NVARCHAR(24),
    "Email" NVARCHAR(60)
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Genre" (
    "GenreId" INTEGER NOT NULL PRIMARY KEY,
    "Name" NVARCHAR(120)
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Invoice" (
    "InvoiceId" INTEGER NOT NULL PRIMARY KEY,
    "CustomerId" INTEGER NOT NULL,
    "InvoiceDate" DATETIME NOT NULL,
    "BillingAddress" NVARCHAR(70),
    "BillingCity" NVARCHAR(40),
    "BillingState" NVARCHAR(40),
    "BillingCountry" NVARCHAR(40),
    "BillingPostalCode" NVARCHAR(10),
    "Total" NUMERIC(10,2) NOT NULL
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."InvoiceLine" (
    "InvoiceLineId" INTEGER NOT NULL PRIMARY KEY,
    "InvoiceId" INTEGER NOT NULL,
    "TrackId" INTEGER NOT NULL,
    "UnitPrice" NUMERIC(10,2) NOT NULL,
    "Quantity" INTEGER NOT NULL
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."MediaType" (
    "MediaTypeId" INTEGER NOT NULL PRIMARY KEY,
    "Name" NVARCHAR(120)
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Playlist" (
    "PlaylistId" INTEGER NOT NULL PRIMARY KEY,
    "Name" NVARCHAR(120)
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."PlaylistTrack" (
    "PlaylistId" INTEGER NOT NULL,
    "TrackId" INTEGER NOT NULL,
    CONSTRAINT "PK_PlaylistTrack" PRIMARY KEY ("PlaylistId", "TrackId")
)
GO

CREATE TABLE IF NOT EXISTS "chinook"."Track" (
    "TrackId" INTEGER NOT NULL PRIMARY KEY,
    "Name" NVARCHAR(200) NOT NULL,
    "AlbumId" INTEGER,
    "MediaTypeId" INTEGER NOT NULL,
    "GenreId" INTEGER,
    "Composer" NVARCHAR(220),
    "Milliseconds" INTEGER NOT NULL,
    "Bytes" INTEGER,
    "UnitPrice" NUMERIC(10,2) NOT NULL
)
GO


-- Indexes
CREATE INDEX "chinook"."IFK_AlbumArtistId" ON "chinook"."Album" ("ArtistId")
GO
CREATE INDEX "chinook"."IFK_CustomerSupportRepId" ON "chinook"."Customer" ("SupportRepId")
GO
CREATE INDEX "chinook"."IFK_EmployeeReportsTo" ON "chinook"."Employee" ("ReportsTo")
GO
CREATE INDEX "chinook"."IFK_InvoiceCustomerId" ON "chinook"."Invoice" ("CustomerId")
GO
CREATE INDEX "chinook"."IFK_InvoiceLineInvoiceId" ON "chinook"."InvoiceLine" ("InvoiceId")
GO
CREATE INDEX "chinook"."IFK_InvoiceLineTrackId" ON "chinook"."InvoiceLine" ("TrackId")
GO
CREATE INDEX "chinook"."IFK_PlaylistTrackPlaylistId" ON "chinook"."PlaylistTrack" ("PlaylistId")
GO
CREATE INDEX "chinook"."IFK_PlaylistTrackTrackId" ON "chinook"."PlaylistTrack" ("TrackId")
GO
CREATE INDEX "chinook"."IFK_TrackAlbumId" ON "chinook"."Track" ("AlbumId")
GO
CREATE INDEX "chinook"."IFK_TrackGenreId" ON "chinook"."Track" ("GenreId")
GO
CREATE INDEX "chinook"."IFK_TrackMediaTypeId" ON "chinook"."Track" ("MediaTypeId")
GO

-- Triggers

-- Views

-- Adding foreign key constraints
ALTER TABLE "chinook"."Album" ADD FOREIGN KEY ("ArtistId") REFERENCES "chinook"."Artist" ("ArtistId")
GO
ALTER TABLE "chinook"."Customer" ADD FOREIGN KEY ("SupportRepId") REFERENCES "chinook"."Employee" ("EmployeeId")
GO
ALTER TABLE "chinook"."Employee" ADD FOREIGN KEY ("ReportsTo") REFERENCES "chinook"."Employee" ("EmployeeId")
GO
ALTER TABLE "chinook"."Invoice" ADD FOREIGN KEY ("CustomerId") REFERENCES "chinook"."Customer" ("CustomerId")
GO
ALTER TABLE "chinook"."InvoiceLine" ADD FOREIGN KEY ("InvoiceId") REFERENCES "chinook"."Invoice" ("InvoiceId")
GO
ALTER TABLE "chinook"."InvoiceLine" ADD FOREIGN KEY ("TrackId") REFERENCES "chinook"."Track" ("TrackId")
GO
ALTER TABLE "chinook"."PlaylistTrack" ADD FOREIGN KEY ("PlaylistId") REFERENCES "chinook"."Playlist" ("PlaylistId")
GO
ALTER TABLE "chinook"."PlaylistTrack" ADD FOREIGN KEY ("TrackId") REFERENCES "chinook"."Track" ("TrackId")
GO
ALTER TABLE "chinook"."Track" ADD FOREIGN KEY ("AlbumId") REFERENCES "chinook"."Album" ("AlbumId")
GO
ALTER TABLE "chinook"."Track" ADD FOREIGN KEY ("GenreId") REFERENCES "chinook"."Genre" ("GenreId")
GO
ALTER TABLE "chinook"."Track" ADD FOREIGN KEY ("MediaTypeId") REFERENCES "chinook"."MediaType" ("MediaTypeId")
GO

-- Load data
LOAD DATA FROM FILE '/tmp/Artist.csv' INTO "chinook"."Artist" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Album.csv' INTO "chinook"."Album" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Employee.csv' INTO "chinook"."Employee" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Customer.csv' INTO "chinook"."Customer" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Genre.csv' INTO "chinook"."Genre" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Invoice.csv' INTO "chinook"."Invoice" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/MediaType.csv' INTO "chinook"."MediaType" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Track.csv' INTO "chinook"."Track" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/InvoiceLine.csv' INTO "chinook"."InvoiceLine" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/Playlist.csv' INTO "chinook"."Playlist" USING {"from":{"file":{"header":true}}}
GO
LOAD DATA FROM FILE '/tmp/PlaylistTrack.csv' INTO "chinook"."PlaylistTrack" USING {"from":{"file":{"header":true}}}
GO