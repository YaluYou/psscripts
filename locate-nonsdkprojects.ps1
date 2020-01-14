# param([string] $solutionpath)

Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

function Get-ProjectFiles([string] $path = (Get-Location)) {
    Get-ChildItem -Path $path -Include *.csproj -Recurse
}

$solutionpath = "c:\Projects\WorkFlowMax\project"

$fileList = Get-ProjectFiles -path $solutionpath


$result = $fileList | % {
    $csproj = [xml] (get-content $_)
    if (Get-Member -InputObject $csproj -Name "xml"){
        return $_.FullName
    }
}
 
Write-Host $result -Separator "`n"
Write-Host "Totale number of projects : $($result.length)"