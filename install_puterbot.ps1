# PowerShell script to pull puterbot and install

Push-Location

# Run a command and ensure it did not fail
function RunAndCheck {
    Param
    (
        [Parameter(Mandatory = $true)] [string] $Command,
        [Parameter(Mandatory = $true)] [string] $Desc
    )

    Invoke-Expression $Command
    if ($LastExitCode) {
        Write-Output "Failed: $Desc : $LastExitCode"
        Pop-Location
        exit
    }

    Write-Output "Success: $Desc"
}

RunAndCheck "git clone https://github.com/MLDSAI/puterbot.git" "clone git repo"

Set-Location .\puterbot

RunAndCheck "python -m venv .venv" "create python virtual environment"
RunAndCheck ".venv\Scripts\Activate.ps1" "enable python virtual environment"
RunAndCheck "pip install wheel" "pip install wheel"
RunAndCheck "pip install -r requirements.txt" "pip install -r requirements.txt"
RunAndCheck "pip install -e ." "pip install -e ."
RunAndCheck "alembic upgrade head" "alembic upgrade head"
RunAndCheck "pytest" "run puterbot tests"

Pop-Location
