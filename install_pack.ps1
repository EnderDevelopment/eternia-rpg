param(
    [string]$GameDir = "",
    [string]$Output = "mods"
)

$ErrorActionPreference = "Stop"
$api = "https://api.modrinth.com/v2"
$config = Get-Content -Raw -Encoding UTF8 "pack.json" | ConvertFrom-Json
$target = if ($GameDir) { Join-Path $GameDir "mods" } else { $Output }
New-Item -ItemType Directory -Force -Path $target | Out-Null
$gameVersions = [Uri]::EscapeDataString((ConvertTo-Json -Compress @($config.minecraft)))
$loaders = [Uri]::EscapeDataString((ConvertTo-Json -Compress @($config.loader)))
$failed = @()

foreach ($project in $config.projects) {
    try {
        $url = "$api/project/$project/version?game_versions=$gameVersions&loaders=$loaders&limit=1"
        $versions = Invoke-RestMethod -Uri $url -Headers @{ "User-Agent" = "reinos-desempenho-pack/1.0" }
        if ($versions.Count -eq 0) { throw "no compatible release" }
        $file = $versions[0].files | Where-Object { $_.primary } | Select-Object -First 1
        if (-not $file) { $file = $versions[0].files[0] }
        $destination = Join-Path $target $file.filename
        Write-Host "Downloading $project $($versions[0].version_number) -> $($file.filename)"
        Invoke-WebRequest -Uri $file.url -OutFile $destination -Headers @{ "User-Agent" = "reinos-desempenho-pack/1.0" }
    } catch {
        $failed += "${project}: $($_.Exception.Message)"
    }
}

if ($failed.Count -gt 0) {
    Write-Error ("Some projects could not be installed:`n" + ($failed -join "`n"))
    exit 1
}
Write-Host "`nInstalled $($config.projects.Count) mods into $target"
