Function Create-PieChart() {
    param([String]$FileName)
    param([HashTable]$Measurements)
              
    [void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms.DataVisualization")
       
    $Chart = New-object System.Windows.Forms.DataVisualization.Charting.Chart 
    $Chart.Width = 400
    $Chart.Height = 400
    $Chart.Left = 20
    $Chart.Top = 20
 
    $ChartArea = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
    $Chart.ChartAreas.Add($ChartArea) 
    [void]$Chart.Series.Add("Data")
 
    
    foreach ($item in $Measurements) {
        $datapoint = new-object System.Windows.Forms.DataVisualization.Charting.DataPoint(0, $item.Value)
        $datapoint.AxisLabel = $item.Name + $item.Value
        $Chart.Series["Data"].Points.Add($datapoint)
    }
 
    $Chart.Series["Data"].ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Pie
    $Chart.Series["Data"]["PieLabelStyle"] = "Outside" 
    $Chart.Series["Data"]["PieLineColor"] = "Black" 
    $Chart.Series["Data"]["PieDrawingStyle"] = "Concave" 
    ($Chart.Series["Data"].Points.FindMaxByValue())["Exploded"] = $true
 
    $Title = new-object System.Windows.Forms.DataVisualization.Charting.Title 
    $Chart.Titles.Add($Title) 
    $Chart.Titles[0].Text = "Porcentajes de Líneas de Código, Comentadas y Vacías."
 
    #Save the chart to a file
    $Chart.SaveImage($FileName + ".png","png")
}