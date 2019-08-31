-- Drop if existing

DROP TABLE IF EXISTS STAFF CASCADE;
DROP TABLE IF EXISTS Donations CASCADE;
DROP TABLE IF EXISTS Buildings CASCADE;
DROP TABLE IF EXISTS Campaigns CASCADE;
DROP TABLE IF EXISTS Events CASCADE;
DROP TABLE IF EXISTS WebsitePushLog CASCADE;
DROP TABLE IF EXISTS Members CASCADE;
DROP TABLE IF EXISTS Purchases CASCADE;
DROP TABLE IF EXISTS PayFor CASCADE;
DROP TABLE IF EXISTS IsPaidBy CASCADE;
DROP TABLE IF EXISTS AreFundedBy CASCADE;
DROP TABLE IF EXISTS WorkOn CASCADE;
DROP TABLE IF EXISTS Support CASCADE;

CREATE TABLE Staff(
	StaffID integer PRIMARY KEY NOT NULL,
	Salary integer CHECK (Salary >0 OR (isLongtime = NULL AND EventsAttended = NULL)),
	Name varchar(255),
	EventsAttended integer,
	isLongTime boolean CHECK (isLongTime = TRUE OR EventsAttended<3),
	Notes varchar(255) DEFAULT NULL
);

CREATE TABLE Donations(
	Amount integer CHECK (Amount>0),
	Donor varchar(255) NOT NULL,
	DateReceived varchar(255) NOT NULL,
	PRIMARY KEY(Donor, DateReceived)
);

CREATE TABLE Buildings(
	Address varchar(255)  NOT NULL,
	Landlord varchar(255),
	Rent integer,
	PRIMARY KEY(Address)
);

CREATE TABLE Campaigns(
	CampaignID integer PRIMARY KEY NOT NULL, 
	TimeFrame varchar(255),
	Title varchar(255),
	Budget integer Check (Budget>0)
);

CREATE TABLE Events(
	Title varchar(255),
	TimeFrame varchar(255), 
	EventsID integer PRIMARY KEY NOT NULL,
	Location varchar(255),
	CampaignID integer,
	FOREIGN KEY(CampaignID) references Campaigns(CampaignID)
);

CREATE TABLE WebsitePushLog(
	PushDate varchar(255),
	PhaseNumber integer,
	PushID integer PRIMARY KEY NOT NULL,
	CampaignID integer,
	FOREIGN KEY(CampaignID) references Campaigns(CampaignID)
);

CREATE TABLE Members(
	Name varchar(255),
	MemberID integer PRIMARY KEY NOT NULL,
	Note varchar(255) DEFAULT NULL
);


CREATE TABLE Purchases(
	Title varchar(255),
	PurchaseID integer PRIMARY KEY NOT NULL, 
	Price integer,
	CampaignID integer,
	FOREIGN KEY(CampaignID) references Campaigns(CampaignID)
);

CREATE TABLE PayFor(
	StaffID integer,
	Donor varchar(255),
	DateReceived varchar(255),	
	PRIMARY KEY(StaffID, Donor, DateReceived),
	FOREIGN KEY(StaffID) references Staff(StaffID),
	FOREIGN KEY(Donor, DateReceived) references Donations(Donor, DateReceived)
);

CREATE TABLE IsPaidBy(
	Address varchar(255),
	Donor varchar(255),
	DateReceived varchar(255),
	PRIMARY KEY(Address, Donor, DateReceived),
	FOREIGN KEY(Address) references Buildings(Address),
	FOREIGN KEY(Donor, DateReceived) references Donations(Donor, DateReceived)
);

CREATE TABLE AreFundedBy(
	CampaignID integer,
	Donor varchar(255),
	DateReceived varchar(255),
	PRIMARY KEY(CampaignID, Donor, DateReceived),
	FOREIGN KEY(CampaignID) references Campaigns(CampaignID),
	FOREIGN KEY(Donor, DateReceived) references Donations(Donor, DateReceived)

);

CREATE TABLE WorkOn(
	EventsID integer,
	StaffID integer,
	PRIMARY KEY(EventsID, StaffID),
	FOREIGN KEY(EventsID) references Events(EventsID),
	FOREIGN KEY(StaffID) references Staff(StaffID)
);

CREATE TABLE Support(
	MemberID integer,
	CampaignID integer,
	PRIMARY KEY(MemberID, CampaignID),
	FOREIGN KEY(MemberID) references Members(MemberID),
	FOREIGN KEY(CampaignID) references Campaigns(CampaignID)
);

