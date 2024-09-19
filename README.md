# qrCheckIn
use google charts generated qrcodes to log guests in

## Requirements
MacOSX with QR Journal installed

## Generating codes
Use a mail merge tool to send an email containing the following link (or embeded image) with the {email_address} as a variable:
https://quickchart.io/qr?text={email_address}

## Checking people in
Use QR Journal in URL Watch mode with the "Run AppleScript" option checked. 
Use the QRLog.scpt file from this repo (with your modifications, including the table of emails and names). 

