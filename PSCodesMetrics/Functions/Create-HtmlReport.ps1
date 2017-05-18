function Create-HtmlReport() {
     param([PSObject]$Parameters)

$HTMLHeader = @"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>

    <title>Métricas Básicas - Equipo de Desarrolo de Gabriel Duarte</title>
    <style type="text/css">
        <!-- body {
            font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
        }

        #report {
            width: 835px;
        }

        table {
            border-collapse: collapse;
            border: none;
            font: 10pt Verdana, Geneva, Arial, Helvetica, sans-serif;
            color: black;
            margin-bottom: 10px;
        }

        table td {
            font-size: 12px;
            padding-left: 0px;
            padding-right: 20px;
            text-align: left;
        }

        table th {
            font-size: 12px;
            font-weight: bold;
            padding-left: 0px;
            padding-right: 20px;
            text-align: left;
        }

        h2 {
            clear: both;
            font-size: 130%;
        }

        h3 {
            clear: both;
            font-size: 115%;
            margin-left: 20px;
            margin-top: 30px;
        }

        p {
            margin-left: 20px;
            font-size: 12px;
        }

        table.list {
            float: left;
        }

        table.list td:nth-child(1) {
            font-weight: bold;
            border-right: 1px grey solid;
            text-align: right;
        }

        table.list td:nth-child(2) {
            padding-left: 7px;
        }

        table tr:nth-child(even) td:nth-child(even) {
            background: #CCCCCC;
        }

        table tr:nth-child(odd) td:nth-child(odd) {
            background: #F2F2F2;
        }

        table tr:nth-child(even) td:nth-child(odd) {
            background: #DDDDDD;
        }

        table tr:nth-child(odd) td:nth-child(even) {
            background: #E5E5E5;
        }

        div.column {
            width: 320px;
            float: left;
        }

        div.first {
            padding-right: 20px;
            border-right: 1px grey solid;
        }

        div.second {
            margin-left: 30px;
        }

        table {
            margin-left: 20px;
        }

        -->
    </style>
</head>

<body>
"@

$HTMLMiddle = @"
<hr noshade size=3 width="100%">

<div id="report" ">
        <p><h2>Métricas $Parameters.ProjectName</p></h2>
       
        <h3>Información</h3>
        <table class="list ">
        <tr>
            <td>Fecha y hora del reporte</td>
            <td colspan=2>$Parameters.DatetimeReport</td>
        </tr>
        <tr>
            <td>Computadora</td>
            <td colspan=2>$Parameters.ComputersName</td>
        </tr>
        <tr>
            <td>Directorio analizado</td>
            <td colspan=2>$Parameters.Directory</td>
        </tr>
        <tr>
            <td>Total archivos procesados</td>
            <td>$Parameters.FilesProcessed</td>
        </tr>
        </table>
       
        <h3>Medidas</h3>
        <table class="list ">
        <tr>
            <td>Medida</td>
            <td>Cantidad</td>
            <td>Porcentaje</td>
        </tr>
        <tr>
            <td>Total líneas</td>
            <td>$Parameters.TotalLines</td>
            <td>100%</td>
        </tr>
        <tr>
            <td>Líneas código</td>
            <td>$Parameters.CodeLines</td>
            <td>$Parameters.PercentageCodeLines</td>
        </tr>
        <tr>
            <td>Líneas comentadas</td>
            <td>$Parameters.CommentLines</td>
            <td>$Parameters.PercentageCommentLines</td>
        </tr>
        <tr>
            <td>Líneas vacías</td>
            <td>$Parameters.BlankLines</td>
            <td>$Parameters.PercentageBlankLines</td>
        </tr>
        </table>
       
        <IMG SRC="'$Parameters.DateTimeReport + '-chart-' + $Parameters.ProjectsName + '.png'" ALT="Gráfico $Parameters.ProjectName">

"@ 

$HTMLEnd=@"
</div>
</body>
</html>
"@

$HTMLmessage = $HTMLHeader + $HTMLMiddle + $HTMLEnd

$HTMLmessage | Out-File ((Get-Location).Path + "\$Parameters.DateTimeReport" + "-Reporte-" + $Parameters.ProjectsName + ".html") -Force

}