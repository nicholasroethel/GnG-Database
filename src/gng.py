#!/usr/bin/env python3

import psycopg2

def purchaseItem(cursor): #puchase an item for a campaign

	cursor.execute("""
		SELECT * 
		FROM Purchases
		""")
	print("The original purchases before insertion:")
	result = cursor.fetchall()
	for row in result:
		print("Title: %s, Purchase ID: %s, Price: %s, Campaign ID: %s"%row)

	print("Please enter the purhcase title as a string (ex: glue):")
	title = input()

	print("Please enter the purchase id as an integer (ex: 7):")
	pid = input()

	print("Please enter the price as an integer (ex: 5):")
	price = input()

	print("Please enter the ID of the campaign it is being purchased for (Ex 4):")
	cid = input()

	try:
		cursor.execute("INSERT INTO Purchases VALUES(%s, %s, %s, %s) ", [title, pid, price, cid])
	except:
		print("Invalid input. Input has been rejected.")

def purchaseHistory(cursor): #view the purchase history for a specific campaign or for all campaigns
	print("Would you like to view purchases for all campaigns or for one specific campaign?")
	print("Please enter either 'all' or 'one'")
	choice = input()

	if(choice == "all"):
		cursor.execute("""
			SELECT *
			FROM Purchases
			""")
		result = cursor.fetchall()
		print("The purchases for all campaigns:")
		for row in result:
			print("Title: %s, Purchase ID: %s, Price: %s, Campaign ID: %s"%row)

	elif(choice == "one"):
		print("Please enter the ID of the campaign that you would like to see the purchases of (ex: 1): ")
		cid = input()

		cursor.execute("""
			SELECT *
			FROM Purchases
			WHERE CampaignID= %s
			"""%cid)

		print("The purchases for this campaign:")
		result = cursor.fetchall()
		for row in result:
			print("Title: %s, Purchase ID: %s, Price: %s, Campaign ID: %s"%row)


	else:
		print("Invalid command - please try again")
		return

def memberBurnout(cursor): #view or edit member burnout notes and information

	print("List of the current member statuses:")

	cursor.execute("""
		SELECT * 
		FROM Members
		""")

	result = cursor.fetchall()
	for row in result:
		print("Name: %s, Member ID %s, Note: %s"%row)

	print("Please enter the id of the member you would like to examine (ex: 1)")
	sid = input()

	cursor.execute("""
		SELECT COUNT(*)
		FROM Support
		WHERE MemberID= %s
		"""%sid)

	print("The amount of campaigns this member is heling with:")
	result = cursor.fetchone()
	print("%s"%result)

	print("Would you like to change the note for this member?")
	print("Enter 'yes' or 'no:'")
	option = input()
	if(option == "yes"):
		print("Are they burnt out?")
		print("Please enter 'yes' or 'no'")
		note = input()
		if(note == "yes"):
			cursor.execute("""
				UPDATE Members
				Set Note = 'Burnt Out'
				WHERE MemberID= %s;
				"""%(sid))

		elif(note == "no"):
			cursor.execute("""
				UPDATE Members
				Set Note = 'Not Burnt Out'
				WHERE MemberID= %s;
				"""%(sid))
		else:
			print("Invalid command - please try again")
			return


		cursor.execute("""
			SELECT * 
			FROM Members
			""")

		print("Member statuses after the update")
		result = cursor.fetchall()
		for row in result:
			print("Name: %s, Member ID %s, Note: %s"%row)

	elif(option == "no"):
		return
	else:
		print("Invalid command - please try again")
		return

def staffBurnout(cursor): #view or edit staff burnout notes and information

	print("List of the current staff statuses:")

	cursor.execute("""
		SELECT * 
		FROM Staff
		""")

	result = cursor.fetchall()
	for row in result:
		print("ID: %s, Salary: %s, Name: %s, Events Attended: %s, Longtime Member: %s, Notes: %s"%row)

	print("Please enter the id of the staff member you would like to examine (ex: 1)")
	sid = input()

	cursor.execute("""
		SELECT COUNT(*)
		FROM WorkOn
		WHERE StaffID= %s
		"""%sid)

	print("The amount of events worked by this staff:")
	result = cursor.fetchone()
	print("%s"%result)

	print("Would you like to change the note for this staff member?")
	print("Enter 'yes' or 'no:'")
	option = input()
	if(option == "yes"):
		print("Are they burnt out?")
		print("Please enter 'yes' or 'no'")
		note = input()
		if(note == "yes"):
			cursor.execute("""
				UPDATE Staff
				Set Notes = 'Burnt Out'
				WHERE StaffID= %s;
				"""%(sid))

		elif(note == "no"):
			cursor.execute("""
				UPDATE Staff
				Set Notes = 'Not Burnt Out'
				WHERE StaffID= %s;
				"""%(sid))
		else:
			print("Invalid command - please try again")
			return


		cursor.execute("""
			SELECT * 
			FROM Staff
			""")
		print("The staff statuses after the update")
		result = cursor.fetchall()
		for row in result:
			print("ID: %s, Salary: %s, Name: %s, Events Attended: %s, Longtime Member: %s, Notes: %s"%row)

		
	elif(option == "no"):
		return
	else:
		print("Invalid command - please try again")
		return



def viewFunds(cursor): #allows the user to view funds

	print("Print would you like to view the incoming or outgoing funds?")
	print("Enter 'incoming' to view incoming funds and 'outgoing' to view outgoing funds")

	#bar chart section inspired by https://alexwlchan.net/2018/05/ascii-bar-charts/

	option = input()
	if(option == "incoming"):
		cursor.execute("""
			SELECT Donor, Amount
			FROM Donations
			""")
		donations = cursor.fetchall()
		maxval = max(amount for _, amount in donations) #gets maximum value from list
		inc = maxval/ 25 #gets the incerement
		longestname = max(len(name) for name, _ in donations) #gets the length of the longest name

		for name, amount in donations: # iterates through the donations
		    chunks, rem = divmod(int(amount*8/inc), 8)
		    bar = '█'*chunks
		    if rem > 0:
		        bar += chr(ord('█') + (8-rem))
		    bar = bar or  '▏'
		    print(f'{name.rjust(longestname)} ▏ {amount:#4d} {bar}')

	if(option == "outgoing"):
		cursor.execute("""
			SELECT Address, Rent
			FROM Buildings
			""")
		rents = cursor.fetchall()
		maxval = max(amount for _, amount in rents) #gets maximum value from list
		inc = maxval/ 25 #gets the incerement
		longestaddress = max(len(address) for address, _ in rents) #gets the length of the longest address

		print("The outgoing funds for the rent are:")
		for address, amount in rents: # iterates through the rents
		    chunks, rem = divmod(int(amount*8/inc), 8)
		    bar = '█'*chunks
		    if rem > 0:
		        bar += chr(ord('█') + (8-rem))
		    bar = bar or  '▏'
		    print(f'{address.rjust(longestaddress)} ▏ {amount:#4d} {bar}')

		cursor.execute("""
			SELECT Title, Budget
			FROM Campaigns
			""")
		camps = cursor.fetchall()
		maxval = max(amount for _, amount in camps) #gets maximum value from list
		inc = maxval/ 25 #gets the incerement
		longesttitle = max(len(title) for title, _ in camps) #gets the length of the longest title

		print("The outgoing funds for campaigns are:")
		for title, amount in camps: # iterates through the campaigns
		    chunks, rem = divmod(int(amount*8/inc), 8)
		    bar = '█'*chunks
		    if rem > 0:
		        bar += chr(ord('█') + (8-rem))
		    bar = bar or  '▏'
		    print(f'{title.rjust(longesttitle)} ▏ {amount:#4d} {bar}')


		cursor.execute("""
			SELECT Name, Salary
			FROM Staff
			""")
		staff = cursor.fetchall()
		maxval = max(amount for _, amount in staff) #gets maximum value from list
		inc = maxval/ 25 #gets the incerement
		longestname = max(len(name) for name, _ in staff) #gets the length of the longest name

		print("The outgoing funds for the staff salaries are:")
		for name, amount in staff: # iterates through the campaigns
		    chunks, rem = divmod(int(amount*8/inc), 8)
		    bar = '█'*chunks
		    if rem > 0:
		        bar += chr(ord('█') + (8-rem))
		    bar = bar or  '▏'
		    print(f'{name.rjust(longestname)} ▏ {amount:#4d} {bar}')
		    

def pushCampaign(cursor): #allows user to push a campaign to the website

	print("Please enter the push date as a string (ex: 'Jan. 27 2019'):")
	pdate = input()

	print("Please enter the campaign phase number as an integer (ex: 2):")
	pnum = input()

	print("Please enter the push id as an integer (ex: 3):")
	pid = input()

	print("Please enter the campaign id as an integer (ex: 1):")
	cid = input()

	try:
		cursor.execute("INSERT INTO WebsitePushLog VALUES(%s, %s, %s, %s) ", [pdate, pnum, pid, cid])
	except:
		print("Invalid input. Input has been rejected.")


def assignStaff(cursor): #allows user to assign a staff member to an event


	print("Please enter the id of the staff member you would like to assign:")
	sid = input()

	print("Please enter the id of the event you would like to assign them to:")
	eid = input()

	try:
		cursor.execute("INSERT INTO WorkOn VALUES(%s, %s) ", [sid, eid])
	except:
		print("Invalid input. Input has been rejected.")



def campaignStatus(cursor): #prints the relevant information of a given campaign

	print("Please enter the campaign id you would like the status of:")
	cid = input()

	cursor.execute("""
		SELECT Title
		FROM Campaigns
		WHERE CampaignID = %s
		"""%cid)

	print("The name of this campaign is:")
	result = cursor.fetchall()
	for row in result:
		print("%s"%row)

	cursor.execute("""
		SELECT Title
		FROM Events
		WHERE CampaignID = %s
		"""%cid)

	print("The names of the events associated with this campaign are:")
	result = cursor.fetchall()
	for row in result:
		print("%s"%row)

	cursor.execute("""
		SELECT PhaseNumber 
		FROM WebsitePushLog
		WHERE CampaignID = %s
		"""%cid)

	print("The phases of this campaign that have been pushed to the website are:")
	result = cursor.fetchall()
	for row in result:
		print("%s"%row)


def insertCampaign(cursor): #allows the user to insert a campaign
	
	print("Please enter the campaign id in integer format (ex: 5)")
	cid = input()

	print("Please enter the time frame as a string (ex: Jan. 27 2019 - Jan 29. 2019)")
	tf = input()
	
	print("Please enter the campaign title as a string (ex: green dash)")
	ct = input()

	print("Please enter the budget as an integer (ex: 100)")
	budget = input()

	try:
		cursor.execute("INSERT INTO Campaigns VALUES(%s, %s, %s, %s) ", [cid, tf, ct, budget])
	except:
		print("Invalid input. Input has been rejected.")

def insertEvent(cursor): #allows the user to insert an event
	
	print("Please enter the event title as a string (ex: green dash)")
	et = input()

	print("Please enter the time frame as a string (ex: Jan. 27 2019 - Jan 29. 2019)")
	tf = input()
	
	print("Please enter the event id in integer format (ex: 5)")
	eid = input()

	print("Please enter the location as a string (ex: 2500 6th Street, New York, New York)")
	loc = input()

	print("Please enter the id of the campaign associated with this event as an integer (ex: 5)")
	cid = input()


	try:
		cursor.execute("INSERT INTO Events VALUES(%s, %s, %s, %s, %s) ", [et, tf, eid, loc, cid])
	except:
		print("Invalid input. Input has been rejected.")

def insertStaff(cursor): #allows the user to insert staff
	
	print("Please enter the staff id in integer format (ex: 5)")
	sid = input()

	print("Please enter the salary as an integer (if the staff is a volunteer, please enter 0)")
	salary = input()
	
	print("Please enter the staff name as a string (ex: Bob)")
	sname = input()

	if salary == "0":

		print("Please enter the events attended as an integer (ex: 6)")
		ea = input()

		print("Please enter wether or not they have attended 3 or more events by either entering 'TRUE' or 'FALSE'")
		islong = input()

		try:
			cursor.execute("INSERT INTO Staff VALUES(%s, %s, %s, %s, %s) ", [sid, salary, sname, ea, islong])
		except:
			print("Invalid input. Input has been rejected.")

	else:
		try:
			cursor.execute("INSERT INTO Staff VALUES(%s, %s, %s) ", [sid, salary, sname])
		except:
			print("Invalid input. Input has been rejected.")




def main():
	dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='benue', password='e2=EA*mI8e')
	cursor = dbconn.cursor()

	print("Welcome to the GNG Database")
	print("Please enter the desired command")
	print("If you would like to see the commands list enter 'help'")
	command = "start"

	while(command != "end"): #command loop
		command = input ("Desired Command: ") 
		if(command == "help"):
			#For Phase 1
			print("To see the list of query commands and what they do enter 'queries'")
			#For Phase 2
			print("To insert a campaign enter 'insert-campaign'")
			print("To insert a staff member or volunteer enter 'insert-staff'")
			print("To insert an event enter 'insert-event'")
			print("To see the status of a campaign enter 'campaign-status'")
			print("To assign a staff member to an event enter 'assign-staff'")
			print("To push a campaign phase to the website enter 'push-campaign'")
			#For Phase 3
			print("To view incoming or outgoing funds enter 'view-funds'")
			#For Phase 4
			print("To view or add burnout notes for staff enter 'staff-burnout'")
			print("To view or add burnout notes for staff enter 'member-burnout'")
			#For Phase 5 (Bonus Functions)
			print("To view purchase history for campaigns enter 'purchase-history'")
			print("To puchase an item for a campaign enter 'purchase-item'")
			#To terminate the program
			print("To end the program enter 'end'")

		#Queries for phase 1
		elif(command == "queries"):
			print("'query-1' will return all the donors who have donated more than $10000")
			print("'query-2' will return the names of the staff members that work on event 1")
			print("'query-3' will return the cost of all the purchases")
			print("'query-4' will return the amount of the biggest donation")
			print("'query-5' will return the total amount of donations made towards the rent")
			print("'query-6' will return the sum of all staff salaries")
			print("'query-7' will return the amount of paid employees")
			print("'query-8' will return the dates that phase updates to campaign 1 were pushed to the website")
			print("'query-9' will return the name of the member that supports the most campaigns")
			print("'query-10' will return how many volunteers there are")
			print("'query-11' will return the title and price of all the purchases made for campaigns 1 and 2")
			print("'query-12' will return the names of all the events and all the campaigns")
		elif(command == "query-1"):
			print("All the donors who have donated more than $10000:")
			cursor.execute("""
				SELECT donor 
				FROM donations 
				WHERE amount > 10000;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-2"):
			print("All the names of the staff members that work on event 1:")
			cursor.execute("""
				SELECT Name 
				FROM Staff Where 
				StaffID = (SELECT StaffID FROM WorkOn Where EventsID = 1);
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s" %row)
		elif(command == "query-3"):
			print("The cost of all the purchases")
			cursor.execute("""
				SELECT SUM(Price) 
				FROM Purchases;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-4"):
			print("The amount of the biggest donation")
			cursor.execute("""
				SELECT amount 
				FROM Donations CROSS JOIN AreFundedBy 
				WHERE Donations.Donor = AreFundedBy.Donor 
				GROUP BY amount 
				HAVING COUNT(amount)> 1;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-5"):
			print("The total amount of donations made towards the rent:")
			cursor.execute("""
				SELECT COUNT(*) 
				FROM IsPaidBy CROSS JOIN Donations 
				WHERE IsPaidBy.Donor = Donations.Donor AND IsPaidBy.DateReceived = Donations.DateReceived;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-6"):
			print("The total amount of donations made towards the rent:")
			cursor.execute("""
				SELECT SUM(Salary) 
				FROM STAFF;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-7"):
			print("The amount of paid employees:")
			cursor.execute("""
				SELECT COUNT(Salary) 
				FROM STAFF 
				WHERE Salary > 0;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-8"):
			print("The dates that phase updates to campaign 1 were pushed to the website:")
			cursor.execute("""
				SELECT PushDate 
				FROM WebsitePushLog 
				WHERE CampaignID = 1;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-9"):
			print("The name of the member that supports the most campaigns:")
			cursor.execute("""
				SELECT Name 
				FROM Members 
				WHERE MemberID = (SELECT MemberID FROM Support GROUP BY MemberID ORDER BY COUNT(*) DESC LIMIT 1);
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-10"):
			print("The number of volunteers:")
			cursor.execute("""
				SELECT COUNT(*) 
				FROM Staff 
				WHERE Salary = 0;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)
		elif(command == "query-11"):
			print("The title and price of all the purchases made for campaigns 1 and 2:")
			cursor.execute("""
				SELECT Title,Price
				FROM Purchases 
				WHERE CampaignID = 1 or CampaignID = 2;
			""")
			result = cursor.fetchall()
			for row in result:
				print("Title: %s, Price: %s"%row)
		elif(command == "query-12"):
			print("The names of all the events and all the campaigns:")
			cursor.execute("""
				SELECT Title 
				FROM Events UNION ALL Select Title From Campaigns;
			""")
			result = cursor.fetchall()
			for row in result:
				print("%s"%row)

		#For setting up a campaign in phase 2
		elif(command == "insert-campaign"): #To insert a campaign
			cursor.execute("""
				SELECT * 
				FROM Campaigns
			""")
			print("The campaigns before the insertion in the database are:")
			result = cursor.fetchall()
			for row in result:
				print("ID: %d, Date Range: %s, Title: %s, Budget: %s"%row)
			insertCampaign(cursor)
			cursor.execute("""
				SELECT * 
				FROM Campaigns
			""")
			print("The campaigns now in the database are:")
			result = cursor.fetchall()
			for row in result:
				print("ID: %d, Date Range: %s, Title: %s, Budget: %s"%row)

		elif(command == "insert-staff"): #To insert a staff or volunteer
			cursor.execute("""
				SELECT * 
				FROM Staff
			""")
			print("The staff before the insert in the database are:")
			result = cursor.fetchall()
			for row in result:
				print("ID: %s, Salary: %s, Name: %s, Events Attended: %s, Longtime Member: %s, Notes: %s"%row)
			insertStaff(cursor)
			cursor.execute("""
				SELECT * 
				FROM Staff
			""")
			print("The staff now in the database are:")
			result = cursor.fetchall()
			for row in result:
				print("ID: %s, Salary: %s, Name: %s, Events Attended: %s, Longtime Member: %s, Notes: %s"%row)

		elif(command == "insert-event"): #To insert an event
			cursor.execute("""
				SELECT * 
				FROM Events
			""")
			print("The events before the insert in the database are:")
			result = cursor.fetchall()
			for row in result:
				print("Title: %s, Date Range: %s, ID: %s, Location: %s, Associated Campaign ID: %s"%row)

			insertEvent(cursor)
			cursor.execute("""
				SELECT * 
				FROM Events
			""")
			print("The events now in the database are:")
			result = cursor.fetchall()
			for row in result:
				print("Title: %s, Date Range: %s, ID: %s, Location: %s, Associated Campaign ID: %s"%row)

		elif(command == "campaign-status"): #To get the status of a campaign
			campaignStatus(cursor)

		elif(command == "assign-staff"): #To assign a staff to an event
			cursor.execute("""
				SELECT * 
				FROM WorkOn
			""")
			print("The Staff IDs and the IDs of the Events they work on before the insertion:")
			result = cursor.fetchall()
			for row in result:
				print("Staff ID: %s, Event ID: %s"%row)
			assignStaff(cursor)
			cursor.execute("""
				SELECT * 
				FROM WorkOn
			""")
			print("The updated Staff IDs and the IDs of the Events they work on:")
			result = cursor.fetchall()
			for row in result:
				print("Staff ID: %s, Event ID: %s"%row)

		elif(command == "push-campaign"): #To push a campaign phase to the website
			cursor.execute("""
				SELECT * 
				FROM WebsitePushLog
			""")
			print("The website push log history before the insertion:")
			result = cursor.fetchall()
			for row in result:
				print("Push Date: %s, Phase Number: %s, Push ID: %s, CampaignID: %s"%row)
			pushCampaign(cursor)
			cursor.execute("""
				SELECT * 
				FROM WebsitePushLog
			""")
			print("The website push log history after the insertion:")
			result = cursor.fetchall()
			for row in result:
				print("Push Date: %s, Phase Number: %s, Push ID: %s, CampaignID: %s"%row)

		#To track funds for phase 3
		elif(command == "view-funds"):
			viewFunds(cursor)

		#To view burnout information for phase 4
		elif(command == "staff-burnout"):
			staffBurnout(cursor)
		elif(command == "member-burnout"):
			memberBurnout(cursor)

		#For purchases for phase 5
		elif(command == "purchase-history"):
			purchaseHistory(cursor)

		elif(command == "purchase-item"):
			purchaseItem(cursor)
			cursor.execute("""
				SELECT * 
				FROM Purchases
			""")
			print("The updated purchases:")
			result = cursor.fetchall()
			for row in result:
				print("Title: %s, Purchase ID: %s, Price: %s, Campaign ID: %s"%row)

		else:
			print("Please enter a valid command. To see a list of valid commands type 'help'")



	cursor.close()
	dbconn.close()
	
if __name__ == "__main__": 
	main()