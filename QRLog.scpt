-- Define constant for error message
property errorMsg : "Please try a different code"

-- Dictionary for lookup
property myTable : {¬
	{key:"email_address", value:"name"}, ¬
	{key:" ", value:errorMsg}}

-- Function to look up a value by key
on lookupValueByKey(tbl, searchKey, errMsg)
	repeat with row in tbl
		if key of row is searchKey then
			return value of row
		end if
	end repeat
	return errMsg
end lookupValueByKey

-- Function to log check-ins
on logCheckin(code)
	set currentDate to current date
	set formattedDate to ((month of currentDate) & " " & (day of currentDate) & ", " & (year of currentDate) & " " & (time string of currentDate)) as string
	set logFilePath to (path to desktop as text) & "qr_checkin_log.txt"
	do shell script "echo " & quoted form of code & " checked in at " & quoted form of formattedDate & " >> " & quoted form of POSIX path of logFilePath
end logCheckin

-- Function to handle scanned codes
on scanned_code(code)
	if code contains "@" then
		-- Handle valid codes
		set result to lookupValueByKey(myTable, code, errorMsg)
		set guestName to result
		
		-- Debug line
		-- display dialog ("Debug: result = " & result) buttons {"Ok"} default button 1
		
		
		if result is errorMsg then
			display dialog errorMsg & " or check-in with your email here." buttons {"Ok"} default button 1
			set dialogResult to display dialog "Please enter your email:" default answer ""
			set guestEmail to text returned of dialogResult
			if guestEmail is not "" then
				scanned_code(guestEmail)
			end if
		else
			display dialog ("Checked In Successfully! 
 Welcome, " & guestName) buttons {"Ok"} default button 1
			-- Optionally close the dialog automatically
			-- do shell script "sleep 2"
			-- tell application "System Events" to keystroke return
			logCheckin(code)
		end if
		
	else
		-- Handle invalid codes
		-- display dialog "Invalid code." buttons {"Ok"} default button 1
		set dialogResult to display dialog errorMsg & " or check-in with your email here:" default answer ""
		set guestEmail to text returned of dialogResult
		if guestEmail is not "" then
			scanned_code(guestEmail)
		end if
	end if
end scanned_code

-- Example usage
scanned_code("")
