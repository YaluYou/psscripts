# param([string] $solutionpath)

Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'



Function Get-ProjectFiles([string] $path){
    if([string]:: IsNullOrEmpty($path)){
        $path = Get-Location
    }

    Get-Childitem -Path $path -Include *.csproj -Recurse
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