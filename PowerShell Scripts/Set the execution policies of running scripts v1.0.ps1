<# This will allow this script to run as admin. #>
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
<# Here is the table of all the options of the set-EP command. #>
mode 270
echo "Made by Captain Chicky 2020."
echo "======================================================================================="
echo "======================================================================================="
echo "Here are the following options:"
echo "Set-ExecutionPolicy Restricted   <-- Will not allow any powershell scripts to run.  Only individual commands may be run."
echo "Set-ExecutionPolicy AllSigned    <-- Will allow signed powershell scripts to run."
echo "Set-ExecutionPolicy RemoteSigned <-- Allows unsigned local script and signed remote powershell scripts to run."
echo "Set-ExecutionPolicy Unrestricted <-- Will allow unsigned powershell scripts to run.  Warns before running downloaded scripts."
echo "Set-ExecutionPolicy Bypass       <-- Nothing is blocked and there are no warnings or prompts."
echo "======================================================================================="
echo "======================================================================================="
echo "By default, this script will set the execution policy to: RemoteSigned."

$var = read-host -Prompt "
`nYes --> Enter 'Y' to continune setting the execution policy to: RemoteSigned.
`nQuit--> Enter 'Q' to quit this script, and edit the script to change the default execution policy to something else.
`nPlease select an option"
switch($var){
    Y{
    # HELLO USER! EDIT THE POLICY RIGHT BELOW HERE! CHANGE THE WORDS "RemoteSigned" TO ANY ONE OF THE OPTIONS I HAVE PREVIOUSLY SPECIFIED(ie "Restricted", "AllSigned", "RemoteSigned", "Unrestricted", and "Bypass")!
    Set-ExecutionPolicy RemoteSigned
    echo "=============================================="
    echo "Success. The execution policy has been set to:"
    Get-ExecutionPolicy
    echo "PowerShell will now close in 30 seconds."
    timeout 30
    }
    Q{
    echo "You have chosen to exit."
    timeout 5
    exit
    }
}