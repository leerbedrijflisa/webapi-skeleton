param (
	[string]$project,
	[string]$solution
)

# If no project name was specified, ask for a project name.
if (!$project) {
	$project = Read-Host "What is name of the project (e.g. Lisa.Skeleton.Api)?"
}

# If no solution name was specified, use the project name for the solution.
if (!$solution) {
	$solution = $project
}

# Change the namespace setting in the project file and rename the project file.
(Get-Content Lisa.Skeleton.Api\Lisa.Skeleton.Api.xproj).
	Replace("Lisa.Skeleton.Api", $project) |
	Set-Content "Lisa.Skeleton.Api\$project.xproj"

# Change the solution name, project name, and project folder in the solution file and rename the solution file.
(Get-Content Lisa.Skeleton.Api.sln).
	Replace("Lisa.Skeleton.Api", $project) |
	Set-Content "$solution.sln"

# Rename the project folder.	
Rename-Item -Path ".\Lisa.Skeleton.Api" -NewName ".\$project"

# Remove the original solution file.
Remove-Item -Path "Lisa.Skeleton.Api.sln"

# Remove the original project file.
Remove-Item -Path "$project\Lisa.Skeleton.Api.xproj"

# Remove this script, since we don't need it anymore.
Remove-Item -Path "init.ps1"