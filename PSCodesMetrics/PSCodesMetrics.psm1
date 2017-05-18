<#
	My Function
#>
function Get-Function {

}

#
# CodeMetrics.ps1
#

Clear-Host
$path = 'D:\RutaDirectorio'
#if ( (Test-Path -Path $path) -ne $true )
#{
#    stop
#}
CD $path

$startProcess = [DateTime]::Now


$data = @{}
$data.TotalLines = 0
$data.CodeLines = 0
$data.BlankLines = 0
$data.CommentedLines = 0
$data.PercentageCodeLines = 0.0
$data.PercentageBlankLines = 0.0
$data.PercentageCommentedLines = 0.0
$data.RelationBetweenCommentedAndCodeLines = 0.0
$data.RelationBetweenBlankAndCodeLines = 0.0


$listTypeFiles = @(
    '*.cs',
    '*.ps1',
    '*.js',
    '*.ts',
    '*.html'
)

$files = Get-ChildItem -Path ($listTypeFiles) -Recurse -Force

$IsComment = $false

foreach ($file in $files) {  
    
    $content = Get-Content $file

    foreach ($row in $content) {
        
        $measure = $row | Measure-Object -Word -Line

        $condition1 = ( $measure.Words -le 0 )
        $condition2 = ( $measure.Words -gt 0 )
        $condition3 = ( $row -match '//' )
        $condition4 = ( $row -notmatch '//' )
        $condition5 = ( $row.Trim() -match '^//' )
        $condition6 = ( $row.Trim() -notmatch '^//' )
        $condition7 = ( $row.Trim() -match '^<#' )
        $condition8 = ( $row -match '#>' )

        if ( $condition7 ) {
            $IsComment = $true
        }
        
        if ( $IsComment -eq $false ) {
            
            if ( ($condition2 -and $condition5) -or ($condition2 -and $condition3) ) { 
                $data.CommentedLines += 1
            }
        
            if ( $condition2 -and $condition6 ) {
                $data.CodeLines += 1
            }
        
            if ( $condition1 -and $condition4 ) {
                $data.BlankLines += 1 
            }
        }

        if ( $IsComment -eq $true ) {
            $data.CommentedLines += 1
        }

        if ( $condition8 ) {
            $IsComment = $false
        }

        $data.TotalLines += 1
    }
}

if ( $data.TotalLines -gt 0.0 ) {
    $data.PercentageCodeLines = "{0:P}" -f [decimal]($data.CodeLines / $data.TotalLines)
    $data.PercentageBlankLines = "{0:P}" -f [decimal]($data.BlankLines / $data.TotalLines)
    $data.PercentageCommentedLines = "{0:P}" -f [decimal]($data.CommentedLines / $data.TotalLines)
}

if ( $data.CodeLines -gt 0.0 ) {
    $data.RelationBetweenCommentedAndCodeLines = "{0:P}" -f [decimal]($data.CommentedLines / $data.CodeLines)
    $data.RelationBetweenBlankAndCodeLines = "{0:P}" -f [decimal]($data.BlankLines / $data.CodeLines)
}

$endProcess = [DateTime]::Now

'////////////////////////////////////////////////////////////////////////////////////////'
''
'========================================================================================'
'REPORTE ANÁLISIS DIRECTORIO: ' + $path
'========================================================================================'
''
'Fecha y hora del reporte: ' + [DateTime]::Now
'Ficheros procesados: ' + $files.Count
'Inicio proceso: ' + $startProcess
'Fin proceso: ' + $endProcess
'Tiempo empleado por el proceso: ' + (Get-Date).Subtract($startProcess)
''
'----------------------------------------------------------------------------------------'
''
'ESTADISTICAS - Cantidad de Líneas.'
'----------------------------------------------------------------------------------------'
''
' Total: ' + $data.TotalLines
''
' Código: ' + $data.CodeLines
' Vacías: ' + $data.BlankLines
' Comentadas: ' + $data.CommentedLines + ' (Incluidos los comentarios que están en la misma línea del código.)'
''
''
'ESTADISTICAS - Porcentaje con respecto al Total.'
'----------------------------------------------------------------------------------------'
''
' % Código: ' + $data.PercentageCodeLines
' % Vacío: ' + $data.PercentageBlankLines
' % Comentadas: ' + $data.PercentageCommentedLines
''
''
'ESTADISTICAS - Porcentaje con respecto al ' + $data.PercentageCodeLines + ' de Líneas de Código.'
'----------------------------------------------------------------------------------------'
''
' % Vacías: ' + $data.RelationBetweenBlankAndCodeLines
' % Comentadas: ' + $data.RelationBetweenCommentedAndCodeLines
''
''
'\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'
''
''
''



$projectsName = Get-Location | Split-Path -Leaf;
$dateTimeReport = [DateTime]::Now;
$measurements = @{
    "Codigo"="60%";
    "Comentarios"="20%";
    "Vacio"="20%"
}

Create-PieChart -FileName ((Get-Location).Path + "\" + $dateTimeReport + "-chart-" + "$projectsName") -Mesaurements $measurements

    
$parameters = @{
    ComputersName = 'asdf';
    Directory = Get-Location;
    ProjectName = $projectsName;
    DatetimeReport = $dateTimeReport;
    FilesProcessed = 2330;
    TotalLines = 15342;
    CodeLines = 2342;
    PercentageCodeLines = 23;
    CommentLines = 345;
    PercentageCommentLines = 56;
    BlankLines = 67;
    PercentageBlankLines = 3;
}

Create-HtmlReport -Parameters $parameters

#$ ListOfAttachments += "chart-$projectsName.png"
#S end-MailMessage -from $fromemail -to $users -subject "Systems Report" -Attachments $ListOfAttachments -BodyAsHTML -body $HTMLmessage -priority Normal -smtpServer $server