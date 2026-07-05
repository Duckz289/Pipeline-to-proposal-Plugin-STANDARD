param(
  [Parameter(Mandatory = $true)]
  [string]$Version
)

$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$pluginRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$parentRoot = Split-Path -Parent $pluginRoot
$zipPath = Join-Path $parentRoot ("Pipeline-to-proposal-v{0}.zip" -f $Version)
$pluginPath = Join-Path $parentRoot ("Pipeline-to-proposal-v{0}.plugin" -f $Version)

function New-ReleaseArchive([string]$destination) {
  if (Test-Path -LiteralPath $destination) {
    Remove-Item -LiteralPath $destination -Force
  }

  $fileStream = [System.IO.File]::Open($destination, [System.IO.FileMode]::CreateNew)
  try {
    $archive = New-Object System.IO.Compression.ZipArchive($fileStream, [System.IO.Compression.ZipArchiveMode]::Create, $false)
    try {
      $files = Get-ChildItem -LiteralPath $pluginRoot -Recurse -File
      foreach ($file in $files) {
        $relativePath = $file.FullName.Substring($pluginRoot.Length).TrimStart('\')
        $entryName = ($relativePath -replace '\\', '/')
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
          $archive,
          $file.FullName,
          $entryName,
          [System.IO.Compression.CompressionLevel]::Optimal
        ) | Out-Null
      }
    } finally {
      $archive.Dispose()
    }
  } finally {
    $fileStream.Dispose()
  }
}

New-ReleaseArchive -destination $zipPath
New-ReleaseArchive -destination $pluginPath

[pscustomobject]@{
  Zip = $zipPath
  Plugin = $pluginPath
}
