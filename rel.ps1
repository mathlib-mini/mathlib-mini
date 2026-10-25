#Requires -Version 7.3

<#
Run the repository release-validation sequence.
It does not build or publish a local Python package.

.\rel.ps1
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Section,

        [Parameter(Mandatory = $true)]
        [string]$Command,

        [Parameter(Mandatory = $true)]
        [scriptblock]$Script,

        [int[]]$AllowedExitCodes = @(0)
    )

    Write-Host ""
    Write-Host "============================================================"
    Write-Host $Section
    Write-Host "============================================================"
    Write-Host $Command

    $allowsNonzeroExit = @(
        $AllowedExitCodes | Where-Object { $_ -ne 0 }
    ).Count -gt 0

    if (-not $allowsNonzeroExit) {
        # WHY: Preserve normal fail-fast behavior for strict steps.
        & $Script
        return
    }

    $oldNativeErrorPreference = $PSNativeCommandUseErrorActionPreference
    $exitCode = 0

    try {
        # WHY: Explicitly advisory steps may report findings without stopping
        # the release-validation sequence.
        $PSNativeCommandUseErrorActionPreference = $false

        & $Script
        $exitCode = $LASTEXITCODE
    }
    finally {
        $PSNativeCommandUseErrorActionPreference = $oldNativeErrorPreference
    }

    if ($exitCode -notin $AllowedExitCodes) {
        throw "$Section failed with exit code $exitCode."
    }

    if ($exitCode -ne 0) {
        Write-Host ""
        Write-Host "Command reported findings with allowed exit code $exitCode."
        Write-Host "Release validation will continue."
    }
}

# ============================================================
# === A) Update environment ===
# ============================================================

Invoke-Step "A0) Update elan" "elan self update" {
    elan self update
    elan --version
}

Invoke-Step "A1) Update Lean dependencies" "lake update" {
    lake update
}

Invoke-Step "A2) Lean and lake versions" "lean --version; lake --version" {
    lean --version
    lake --version
}

# ============================================================
# === B) MathlibMini: build, tests, lint ===
# ============================================================

Invoke-Step "B1) Build MathlibMini" "lake build --wfail" {
    lake build --wfail
}

Invoke-Step "B2) Run MathlibMini tests" "lake test" {
    lake test
}

Invoke-Step "B3) Run MathlibMini linter" "lake lint" {
    lake lint
}

# ============================================================
# === C) Compatibility with Mathlib ===
# ============================================================
# The compatibility package is a separate Lake package in compatibility/.
# It requires Mathlib and MathlibMini, and builds the bridge theorems.

Invoke-Step `
    "C1) Update compatibility dependencies" `
    "cd compatibility; lake update" {
    Push-Location (Join-Path $PSScriptRoot "compatibility")
    try {
        lake update
    }
    finally {
        Pop-Location
    }
}

Invoke-Step `
    "C2) Build compatibility package" `
    "cd compatibility; lake build --wfail" {
    Push-Location (Join-Path $PSScriptRoot "compatibility")
    try {
        lake build --wfail
    }
    finally {
        Pop-Location
    }
}

Invoke-Step `
    "C3) Run compatibility tests" `
    "cd compatibility; lake test" {
    Push-Location (Join-Path $PSScriptRoot "compatibility")
    try {
        lake test
    }
    finally {
        Pop-Location
    }
}

# ============================================================
# === D) Final repository status ===
# ============================================================

Invoke-Step "D1) Stage final generated artifacts" "git add -A" {
    git add -A
}

Invoke-Step "D2) Show repository status" "git status --short" {
    git status --short
}

Write-Host ""
Write-Host "============================================================"
Write-Host "Repository validation completed successfully."
Write-Host "============================================================"
