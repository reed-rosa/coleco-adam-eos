$ErrorActionPreference = 'Stop'
$rootBuild = Join-Path $PSScriptRoot '..\build_eos_assembleable_source.ps1'
& $rootBuild @args
exit $LASTEXITCODE
