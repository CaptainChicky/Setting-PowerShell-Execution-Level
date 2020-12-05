# Disclaimer!
<sub>🤡🤡🤡 at the top instead of the end since this is less important than the malware disclaimers 🤡🤡🤡<sub>
  
I spent 2-3 hours making when I was first learning powershell 🙄. Yes, this is useless, I know 😑. 
  
# What is this?
Let me start this off with some credits!!! Why? Because I spent so much time making this, and I want to feel like that I have *at least* accomplished something. 😒 so yes, that's why I've implemented an actual license this time since I don't feel like letting you guys recklessly copy this without crediting me 😫. 😥 **So pleaseeeeeeee \`(\*>﹏<\*)′ at least credit me on this or something when sharing this... I spent 2 hours creating this useless script 😭😭😭**

***Credits!***: Made by Captain Chicky 2020

This is a script that sets the execution policy of PowerShell aka it tells PowerShell what level of security it should have regarding the ps1 scripts(and possibly other extensions like .psc1 etc.) that it is told to run.

# Requirements to use...
PowerShell(no duh), and since there is still a little bit of MS-DOS batch programming, Windows Command Prompt(cmd.exe) is a optional feature to include.

# How to use the script - short
Before starting to use my script, either click on the batch file, or open administrator PowerShell and type in "Set-ExecutionPolicy RemoteSigned". Close PowerShell. Now you can use the script.

# How to use the script - long
PowerShell by default will have the execution policy set to: Restricted. This means that my .ps1 scripts will ****not**** run. 
So in order to start, you have two options, depending on your paranoia level:

  1) """""Unsafe""""" *cough* *cough* option: 
  
Click on the batch script I have provided, follow the instructions given.

  2) """""Safe""""" *cough* *cough* option: 
  
First run PowerShell as administrator, and type in "Set-ExecutionPolicy RemoteSigned". When prompted, type "Y". This should have set your execution policy to RemoteSigned, but just to be safe, type in "Get-ExecutionPolicy" to check. Once you have verified that you have set the execution policy to RemoteSigned, you can then run my script(which hopefully will be signed in the future lol, so it can be ran with the more secure AllSigned execution level, but probably not tbh) in the future to change the execution policy to anything you want easily.

**PLEASE DO NOTE** that if you ever set the policy back to Restricted(or perhaps AllSigned), then you would have to use the batch script, or manally change the execution policy via PowerShell with administrator privelleges again.
