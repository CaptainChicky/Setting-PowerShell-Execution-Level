# Disclaimer
this is a useless project i spent 2-3 hours making when i was first learning powershell
Made by Captain Chicky 2020
***;-; please at least credit me on this or something when sharing this i spent 2 hours creating this useless script ;-;***

# What this is
This sets the execution policy of PowerShell, which basically means it tells powershell what level of security it should have
regarding the ps1 scripts(and possibly other extensions like .psc1 etc) that it is told to run.

# Overview-short
tl;dr Before starting to use my script, either click on the batch file, or open admin PS and type in "Set-ExecutionPolicy RemoteSigned". Close powershell. Now you can use the script.

# Overview-long
PowerShell by default will have the execution policy set to: Restricted. This means that my .ps1 scripts will ****not**** run. 
So in order to start, you have two options, depending on your paranoia level:

1. """""Unsafe""""" option: 
Click on the batch script I have provided, follow the instructions given.

2. """""Safe""""" option: 
First run PowerShell as administrator, and type in "Set-ExecutionPolicy RemoteSigned". When prompted, type "Y".
This should have set your execution policy to RemoteSigned, but just to be safe, type in "Get-ExecutionPolicy" to check. 
Once you have verified that you have set the execution policy to RemoteSigned, you can then run my script(which hopefully will
be signed in the future lol but probs not tbh) in the future to change the execution policy to anything you want easily.

PLEASE DO NOTE that if you ever set the policy back to Restricted(or perhaps AllSigned), then you would have to use the batch script,
or manally change the execution policy via PowerShell with administrator privelleges again.
