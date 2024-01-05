# Load the necessary DLLs
try {
    Add-Type -Path ".\Azure.Core.dll"
} catch {
    $_.Exception.LoaderExceptions | ForEach-Object {
        Write-Host $_.Message
    }
}

try {
    Add-Type -Path ".\zure.Identity.dll"
} catch {
    $_.Exception.LoaderExceptions | ForEach-Object {
        Write-Host $_.Message
    }
}

try {
    Add-Type -Path ".\Microsoft.Data.SqlClient.dll"
} catch {
    $_.Exception.LoaderExceptions | ForEach-Object {
        Write-Host $_.Message
    }
}

try {
    Add-Type -Path ".\Microsoft.Identity.Client.dll"
} catch {
    $_.Exception.LoaderExceptions | ForEach-Object {
        Write-Host $_.Message
    }
}

try {
    Add-Type -Path ".\Microsoft.IdentityModel.Abstractions.dll"
} catch {
    $_.Exception.LoaderExceptions | ForEach-Object {
        Write-Host $_.Message
    }
}

# Configure Connection
$conn = New-Object System.Data.SqlClient.SQLConnection 
$conn.ConnectionString = "Data Source=tcp:localhost;Database=Northwind;Integrated Security=true;Encrypt=false;Max Pool Size=15;"
$conn.Open()

# Check if the connection is open
if ($conn.State -eq 'Open') {
    Write-Host "Connection is open."

    # Perform a query
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "select * from dbo.Categories"

    $reader = $cmd.ExecuteReader()
    while ($reader.Read()) {
        Write-Host $reader.GetValue(0), $reader.GetValue(1), $reader.GetValue(2) # 0 = Category ID, 1 = Category Name, 2 = Description
    }

    $reader.Close()
} else {
    Write-Host "Connection is not open."
}

# Close the connection
$conn.Close()