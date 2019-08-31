-- A group of queries that can be run against the GnG database

-- Query 1: Find all the donors who have donated more than $10000
SELECT Donor FROM Donations WHERE Amount > 10000;

-- Query 2: Find the names of the staff members that work on event 1
SELECT Name FROM Staff Where StaffID = (SELECT StaffID FROM WorkOn Where EventsID = 1);

-- Query 3: Find the cost of all the purchases
SELECT SUM(Price) From Purchases

-- Query 4: Find the unqiue amounts donated by donors, who donated to campaigns
SELECT amount FROM Donations CROSS JOIN AreFundedBy WHERE Donations.Donor = AreFundedBy.Donor GROUP BY amount
HAVING COUNT(amount)> 1;

-- Query 5: Find the total amount of donations made towards the rent
SELECT COUNT(*) FROM IsPaidBy CROSS JOIN Donations WHERE IsPaidBy.Donor = Donations.Donor AND IsPaidBy.DateReceived = Donations.DateReceived;
 
 -- Query 6: Find the sum of all staff salaries
 SELECT SUM(Salary) FROM STAFF;

 -- Query 7: Find the amount of paid employees
 SELECT COUNT(Salary) FROM STAFF WHERE Salary > 0;

 -- Query 8: Return the dates that phase updates to Campaign 1 were pushed to the website
 SELECT PushDate FROM WebsitePushLog where CampaignID = 1;

 -- Query 9: Find the name of the member that supports the most campaigns
 SELECT Name FROM Members WHERE MemberID = 
 (SELECT MemberID FROM Support GROUP BY MemberID ORDER BY COUNT(*) DESC LIMIT 1);

-- Query 10: Find how many volunteers there are
SELECT COUNT(*) FROM Staff WHERE Salary = 0;

-- Query 11: Give the title and price of all the purchases made for campaigns 1 and 2
SELECT Title,Price From Purchases WHERE CampaignID = 1 or CampaignID = 2;

-- Query 12: Give the names of all the events and all the campaigns:
SELECT Title FROM Events UNION ALL Select Title From Campaigns;

-- Query 13: Give the start and end dates of each campaign:
SElECT