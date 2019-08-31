-- Staff Inserts
INSERT INTO Staff VALUES ('1', '100000', 'Nick',NULL,NULL);
INSERT INTO Staff VALUES ('2', '0', 'Geoff','3', TRUE);
INSERT INTO Staff VALUES ('3', '0', 'Dre','2', FALSE);
INSERT INTO Staff VALUES ('4', '500', 'Mark',NULL,NULL);


-- Donation Inserts
INSERT INTO Donations VALUES ('100500','Ally','Jan. 25 2019');
INSERT INTO Donations VALUES ('5000','Rick','Sept. 14 2019');
INSERT INTO Donations VALUES ('1000000','Megan','Jan. 1 2019');

-- Building Inserts
INSERT INTO Buildings VALUES ('1000 Main St.', 'Sergei', '5000');

-- Campaign Inserts
INSERT INTO Campaigns VALUES ('1','Jan. 27 2019 - Jan. 30 2019', 'Green Spirit', 
'8000');
INSERT INTO Campaigns VALUES ('2','Feb. 4 2019 - Feb. 16 2019', 'Mean Green Machines', 
'16000');
INSERT INTO Campaigns VALUES ('3','Oct. 1 2019 - Oct. 11 2019', 'Scream for Green', 
'5000');

-- Events Inserts
INSERT INTO Events VALUES ('Green Dash', 'Jan. 27 2019 - Jan 27. 2019', '1', '2500 6th Street, New York, New York', '1');
INSERT INTO Events VALUES ('Green Gathering', 'Jan. 27 2019 - Jan 29. 2019', '2', '3700 Dash Street, Los Angeles, California', '1');
INSERT INTO Events VALUES ('Go Green', 'Oct. 3 2019 - Oct. 8 2019', '3', '3230 Green Street, Seattle, Washington', '3');

-- Website Push Log Inserts
INSERT INTO WebsitePushLog VALUES ('Jan. 27 2019', '1', '1', '1');
INSERT INTO WebsitePushLog VALUES ('Jan. 29 2019', '2', '2', '1');
INSERT INTO WebsitePushLog VALUES ('Jan. 30 2019', '3', '3', '1');
INSERT INTO WebsitePushLog VALUES ('Feb. 4 2019', '1', '4', '2');
INSERT INTO WebsitePushLog VALUES ('Oct. 7 2019', '1', '5', '3');

-- Member Inserts
INSERT INTO Members VALUES ('Bobby', '1');
INSERT INTO Members VALUES ('Natasha', '2');

-- Puchase Inserts
INSERT INTO Purchases VALUES ('Poster Board','1','5','1');
INSERT INTO Purchases VALUES ('Glue','2','1','1');
INSERT INTO Purchases VALUES ('Markers','3','2','2');
INSERT INTO Purchases VALUES ('Pens','4','3','3');

-- Staff Payment Inserts
INSERT INTO PayFor VALUES ('1','Ally','Jan. 25 2019');
INSERT INTO PayFor VALUES ('4', 'Ally', 'Jan. 25 2019');

-- Building Payment Inserts
INSERT INTO IsPaidBy VALUES ('1000 Main St.','Rick','Sept. 14 2019');

-- Campaign Fund Inserts
INSERT INTO AreFundedBy VALUES('1','Megan','Jan. 1 2019');
INSERT INTO AreFundedBy VALUES('2','Megan','Jan. 1 2019');
INSERT INTO AreFundedBy VALUES('3','Megan','Jan. 1 2019');

-- Work On Inserts
INSERT INTO WorkON VALUES ('1','1');
INSERT INTO WorkON VALUES ('2','2');
INSERT INTO WorkON VALUES ('3','3');
INSERT INTO WorkON VALUES ('3','4');

-- Support Inserts
INSERT INTO Support VALUES ('1','2');
INSERT INTO Support VALUES ('2','1');



