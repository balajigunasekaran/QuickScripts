param(
    [Parameter(Mandatory = $true)][string]$path
)

$projectFiles = Get-ChildItem $path -Filter *.csproj -Recurse
    
$projectFiles | ForEach-Object {
    $projectFile = $_ | Select-Object -ExpandProperty FullName
    $projectName = $_ | Select-Object -ExpandProperty BaseName
    $projectXml = [xml](Get-Content $projectFile)

    $projectReferences = $projectXml | Select-Xml '//ProjectReference' | Select-Object -ExpandProperty Node

    if ($projectReferences.Count -gt 0) {
        $projectReferences | ForEach-Object {
            "[" + $projectName + "] -> [" + $_.Include + "]"
        }    
    }
    else {
        "[" + $projectName + "]"
    }
    "=============================================================================================="
}
