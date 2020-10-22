$location = "D:\Share"
$folders = Get-ChildItem -Path $location -Recurse -Directory
 
$array = @()
 
foreach ($folder in $folders){
	$foldername = $folder.FullName
 
	# Find files in sub-folders
	$files = Get-ChildItem $foldername -Attributes !Directory
 
	# Calculate size in MB for files
	$size = $Null
	$files | ForEach-Object -Process {
		$size += $_.Length
	}
 
	$sizeinmb = [math]::Round(($size / 1mb), 1)
 
	# Add pscustomobjects to array
	$array += [pscustomobject]@{
		Folder = $foldername
		Count = $files.count
		'Size(MB)' = $sizeinmb
	}
}
 
$array = $array | sort-object 'Size(MB)' -Descending
# Generate Report Results in your Documents Folder
$array|Export-Csv -Path file_report.csv -NoTypeInformation
