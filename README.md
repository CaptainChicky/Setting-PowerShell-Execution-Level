# Setting-PowerShell-Execution-Level
an useless project i spent 2-3 hours making when i was first learning powershell

tl;dr Before starting to use my script, either click on the batch file, or open admin PS and type in "Set-ExecutionPolicy RemoteSigned". 
Close powershell. Now you can use the script.
=======================================================================================================

=======================================================================================================

PowerShell by default will have the execution policy set to: Restricted. This means that my .ps1 scripts will *not* run. 
So in order to start, you have two options, depending on your paranoia level:

1. """""Unsafe""""" option: Click on the batch script I have provided, follor the instructions given.

2. """""Safe""""" option: First run PowerShell as administrator, and type in "Set-ExecutionPolicy RemoteSigned". When prompted, type "Y".
This should have set your execution policy to RemoteSigned, but just to be safe, type in "Get-ExecutionPolicy" to check. 
Once you have verified that you have set the execution policy to RemoteSigned, you can then run my script(which hopefully will
be signed in the future lol but probs not tbh) in the future to change the execution policy to anything you want easily.

PLEASE DO NOTE that if you ever set the policy back to Restricted(or perhaps AllSigned), then you would have to use the batch script or
manally change the execution policy via PowerShell with administrator privelleges again.

Made by Captain Chicky 2020
;-; please at least credit me on this on something i spent 2 hours creating this useless script ;-;
