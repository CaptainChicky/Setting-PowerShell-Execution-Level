<# This will allow this script to run as admin. #>
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

# Set bigger font
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class ConsoleFont {
    [DllImport("kernel32.dll")] public static extern IntPtr GetStdHandle(int h);
    [DllImport("kernel32.dll")] public static extern bool SetCurrentConsoleFontEx(IntPtr h, bool m, ref CONSOLE_FONT_INFOEX f);
    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct CONSOLE_FONT_INFOEX {
        public uint cbSize; public uint nFont; public short dwFontSizeX; public short dwFontSizeY;
        public int FontFamily; public int FontWeight;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] public string FaceName;
    }
}
"@

$h = [ConsoleFont]::GetStdHandle(-11)
$f = New-Object ConsoleFont+CONSOLE_FONT_INFOEX
$f.cbSize = [System.Runtime.InteropServices.Marshal]::SizeOf($f)
$f.dwFontSizeY = 20  # CHANGE THIS NUMBER (bigger = larger text)
$f.FaceName = "Consolas"
$f.FontFamily = 54
$f.FontWeight = 400
[ConsoleFont]::SetCurrentConsoleFontEx($h, $false, [ref]$f) | Out-Null

# Rest of your script...
mode con: cols=150 lines=30

<# Here is the table of all the options of the set-EP command. #>
Write-Host "Made by Captain Chicky 2026" -ForegroundColor Cyan
Write-Host ("=" * 90) -ForegroundColor Yellow
Write-Host ("=" * 90) -ForegroundColor Yellow
Write-Host "Execution Policy Options:" -ForegroundColor Green
Write-Host "  Restricted   <-- Will not allow any powershell scripts to run.  Only individual commands may be run." -ForegroundColor Gray
Write-Host "  AllSigned    <-- Will allow signed powershell scripts to run." -ForegroundColor Gray
Write-Host "  RemoteSigned <-- Allows unsigned local script and signed remote powershell scripts to run." -ForegroundColor Gray
Write-Host "  Unrestricted <-- Will allow unsigned powershell scripts to run.  Warns before running downloaded scripts." -ForegroundColor Gray
Write-Host "  Bypass       <-- Nothing is blocked and there are no warnings or prompts." -ForegroundColor Gray
Write-Host ("=" * 90) -ForegroundColor Yellow
Write-Host ("=" * 90) -ForegroundColor Yellow

$UserInput = Read-Host -Prompt @"

Choose an execution policy:
  [RT] Restricted                 [AS] AllSigned
  [RS] RemoteSigned (recommended) [UR] Unrestricted 
  [BP] Bypass (not recommended)   [Q] Quit

Enter your choice
"@

# Map choices to policies
$policies = @{
    'RT' = 'Restricted'
    'AS' = 'AllSigned'
    'RS' = 'RemoteSigned'
    'UR' = 'Unrestricted'
    'BP' = 'Bypass'
}

if ($UserInput -eq 'Q') {
    Write-Host "`nExiting..." -ForegroundColor Yellow
    for ($i = 2; $i -gt 0; $i--) {
        $bar = "OOOOO" * $i + "-----" * (2 - $i)
        Write-Host ("`r[$bar] $i seconds...".PadRight(50)) -NoNewline -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
    Write-Host ""
    exit
}

if ($policies.ContainsKey($UserInput)) {
    $policy = $policies[$UserInput]
    
    try {
        Set-ExecutionPolicy $policy -Force
        Write-Host ("`n" + ("=" * 50)) -ForegroundColor Green
        Write-Host "SUCCESS! Execution policy set to: $policy" -ForegroundColor Green
        Write-Host "Current policy: $(Get-ExecutionPolicy)" -ForegroundColor Cyan
        Write-Host ("=" * 50) -ForegroundColor Green
        Write-Host "`nClosing in 10 seconds..." -ForegroundColor Yellow
        for ($i = 10; $i -gt 0; $i--) {
            $bar = "O" * $i + "-" * (10 - $i)
            Write-Host ("`r[$bar] $i seconds...".PadRight(50)) -NoNewline -ForegroundColor Yellow
            Start-Sleep -Seconds 1
        }
        Write-Host ""
    }
    catch {
        Write-Host "`nERROR: Failed to set execution policy" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        for ($i = 5; $i -gt 0; $i--) {
            $bar = "OO" * $i + "--" * (5 - $i)
            Write-Host ("`r[$bar] $i seconds...".PadRight(50)) -NoNewline -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
        Write-Host ""
    }
}
else {
    Write-Host "`nInvalid choice. Exiting..." -ForegroundColor Red
    for ($i = 5; $i -gt 0; $i--) {
        $bar = "OO" * $i + "--" * (5 - $i)
        Write-Host ("`r[$bar] $i seconds...".PadRight(50)) -NoNewline -ForegroundColor Red
        Start-Sleep -Seconds 1
    }
    Write-Host ""
}