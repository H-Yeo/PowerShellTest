# list all the child items of created temp folder

#Verify all DLLs unzipped match "expected" hierarchy

$extractedNugetPath = '.'

cls

foreach( $folderName in (Get-ChildItem -Path $extractedNugetPath -Directory).Name)
{
    # List all Childerns of the Path
    Get-ChildItem -Path $extractedNugetPath\$folderName -Recurse -File 
    $subFiles = Get-ChildItem -Path $extractedNugetPath\$folderName -Recurse -File 
  
    foreach($file in $subFiles)
    {
        if($subFiles[0].Name -like "*.dll" )
        {
            Write-Host $subFiles[0].Name  -ForegroundColor Green
            Write-Host $subFiles[1].Name  -ForegroundColor Green
            if(($folderName -eq 'lib') -or ($folderName -eq 'ref'))
            {
                if($subFiles[2].Name -like "*.dll")
                {
                    Write-Host $subFiles[2].Name  -ForegroundColor Green
                }
                else
                {
                    $subFiles[2].Name
                    Write-Host "Expected file pattern for localization did not match to *.dll" -ForegroundColor Red
                    #Exit -1
                }
            } 
        }
        else
        {
            $subFiles[0].Name
            $subFiles[1].Name
            Write-Host "Expected file pattern did not match to *.dll" -ForegroundColor Red
            #Exit -1
        }
    }
}