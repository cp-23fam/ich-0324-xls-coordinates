function SplitCell {
    param(
        [string] $Cell
    )

    if (-not ($Cell -match "^([A-Za-z]+)(\d+)$")) {
        throw "Cellule non valide"
    }

    $index = 0
    for ($i = 0; $i -lt $Cell.Length; $i++) {
        $char = ([int]$Cell[$i]) / 1
        if ($char -lt 65) {
            $index = $i
            break
        }
    }

    $letters = $Cell.Substring(0, $index)
    $numbers = [int]$Cell.Substring($index, $Cell.Length - $index)

    if ($numbers -gt 1048576) {
        throw "Limite de lignes dépassée (1'048'576)"
    }

    return @($letters, $numbers)
}

function StringToNumberTable {
    param(
        [string] $String
    )

    $String = $String.ToUpper()
    
    $table = @()

    for ($i = 0; $i -lt $String.Length; $i++) {
        $table += $String[$i] / 1 - 64
    }
    
    return $table
}

function NumberTableToRow {
    param(
        [System.Collections.ArrayList] $Table
    )
    
    $number = 0;

    for ($i = 0; $i -lt $Table.Count; $i++) {
        $pow = ($Table.Count - $i - 1);

        if ($pow -eq 0) {
            $number += $Table[$i]
        }
        else {
            $number += [Math]::Pow(26, $pow) * $Table[$i]
        }
    }

    if ($number -gt 16384) {
        throw "Limite de colonnes dépassée (16'384 / XFD)"
    }

    return $number
}
function ConvertFrom-XlsCoordinates {
    param(
        [string] $Cell
    )

    [array] $Splited = SplitCell -Cell $Cell
    [array] $Tabled = StringToNumberTable -String $Splited[0]
    [int] $Numbered = NumberTableToRow -Table $Tabled

    [hashtable] $Table = @{
        'Row'    = $Splited[1]
        'Column' = $Numbered
    }

    return $Table
}