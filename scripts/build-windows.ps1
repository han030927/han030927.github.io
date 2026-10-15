# Run from the repository root after installing Hugo Extended, Go, Node, and pnpm.
$ErrorActionPreference='Stop'
Push-Location (Join-Path $PSScriptRoot '..')
try {
  # Hugo 0.162 can misread pnpm's Windows shim when NODE_PATH appears first.
  # Use the same official CLI entry point with a minimal local shim.
  $cli=(Resolve-Path 'node_modules/@tailwindcss/cli/dist/index.mjs').Path
  $shim='@echo off' + "`n" + 'node "%~dp0\..\@tailwindcss\cli\dist\index.mjs" %*' + "`n"
  [IO.File]::WriteAllText((Join-Path (Get-Location) 'node_modules/.bin/tailwindcss.cmd'), $shim)
  hugo --minify --cleanDestinationDir
  if ($LASTEXITCODE -ne 0) {throw 'Hugo build failed'}
  & ./node_modules/.bin/pagefind.cmd --site public
  if ($LASTEXITCODE -ne 0) {throw 'Search index build failed'}
  New-Item -ItemType File -Force -Path public/.nojekyll | Out-Null
} finally { Pop-Location }
