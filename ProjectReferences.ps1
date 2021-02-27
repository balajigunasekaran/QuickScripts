Function Get-ProjectReferences ($rootFolder)
{
    $projectFiles = Get-ChildItem $rootFolder -Filter *.csproj -Recurse
    
    $projectFiles | ForEach-Object {
        $projectFile = $_ | Select-Object -ExpandProperty FullName
        $projectName = $_ | Select-Object -ExpandProperty BaseName
        $projectXml = [xml](Get-Content $projectFile)

        $projectReferences = $projectXml | Select-Xml '//ProjectReference' | Select-Object -ExpandProperty Node | Select-Object Include

        $projectReferences | ForEach-Object {
            "[" + $projectName + "] -> [" + $_ + "]"
        }
        "=============================================================================================="
    }
}

Get-ProjectReferences "D:\Source\Git\proarcapi\Source" | Out-File "D:\Source\Git\References.txt"