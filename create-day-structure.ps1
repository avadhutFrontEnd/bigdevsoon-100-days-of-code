# create-day-structure.ps1
# Creates folder structure like day-02: assets/fonts, assets/images, design
# Usage: .\create-day-structure.ps1

$structure = @(
    "assets\fonts",
    "assets\images",
    "assets\icons",
    "design"
)

Write-Host "Create day-02 style folder structure" -ForegroundColor Cyan
Write-Host "Structure: assets/fonts, assets/images, assets/icons, design" -ForegroundColor Gray
Write-Host ""

$targetDir = (Read-Host "Enter full path of folder where to create structure (e.g. C:\Projects\day-15 or .\day-15)").Trim()

if ([string]::IsNullOrWhiteSpace($targetDir)) {
    Write-Host "No path entered. Exiting." -ForegroundColor Red
    exit 1
}

# Resolve path: relative paths are relative to current directory
if (-not [System.IO.Path]::IsPathRooted($targetDir)) {
    $targetDir = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $targetDir))
} else {
    $targetDir = [System.IO.Path]::GetFullPath($targetDir)
}

# Normalize: trim trailing slash/backslash
$targetDir = $targetDir.TrimEnd('\', '/')

Write-Host ""
Write-Host "Will create structure under: $targetDir" -ForegroundColor White
$confirm = Read-Host "Proceed? [y/N]"
if ($confirm -notmatch '^[yY]($|[eE][sS])') {
    Write-Host "Cancelled." -ForegroundColor Yellow
    exit 0
}

# Create base folder if it doesn't exist
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Write-Host "Created: $targetDir" -ForegroundColor Green
}

foreach ($rel in $structure) {
    $fullPath = Join-Path $targetDir $rel
    if (Test-Path $fullPath) {
        Write-Host "Exists:  $fullPath" -ForegroundColor Yellow
    } else {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        Write-Host "Created: $fullPath" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done. Folder structure created under: $targetDir" -ForegroundColor Cyan
