# PowerShell-PSCodeMetrics
Módulo para obtener métricas básicas de código.

## Estadísticas del Código Desarrollado para Proyectos de Software
**Versión 1.0**
Proyecto powershell para obtener estadísticas del código desarrollado para proyectos de softwares.

**Entrada:** Ruta directorio a analizar.

**Condiciones Entrada:**
* Se analizarán los ficheros dentro del directorio y sus subdirectorios.
* Se analizarán solo los siguientes tipos de ficheros: .cs, .ps, .ts, .html, .js
* Se reconocerán como comentarios los que inicien con: //, /*, *, #, <!--
* Se reconocerán como comentarios las líneas que finalicen con: */, /!-->
* Se reconocerán como comentarios las líneas que inicien con: --


**Salida:** Un archivo CSV con la cantidad de líneas de código, líneas en blanco, líneas con comentarios, relación entre líneas de código y líneas en blanco, agrupadas por tipos de archivos.

**Condiciones Salida:**
* El archivo CSV se almacenará en el mismo directorio que se analiza.
* El nombre del archivo salida tendrá la siguiente sintáxis: yyyy-MM-dd HH:mm [name directory] statistics.csv

**Mejoras a futuro:**
* Se debe permitir seleccionar la carpeta a analizar.
* Se debe validar la carpeta a analizar antes de continuar.
* Se debe presentar por aparte en el reporte los comentarios que se encuentran en la misma línea de código.
* Se debe presentar el reporte en formato HTML.

## Ejemplo del reporte
	////////////////////////////////////////////////////////////////////////////////////////

	========================================================================================
	REPORTE ANÁLISIS DIRECTORIO: D:\GD\GitHub
	========================================================================================

	Fecha y hora del reporte: 05/17/2017 10:14:52
	Ficheros procesados: 114
	Inicio proceso: 05/17/2017 10:14:43
	Fin proceso: 05/17/2017 10:14:52
	Tiempo empleado por el proceso: 00:00:09.0825049

	----------------------------------------------------------------------------------------

	ESTADISTICAS - Cantidad de Líneas.
	----------------------------------------------------------------------------------------

	 Total: 4491

	 Código: 3250
	 Vacías: 713
	 Comentadas: 551 (Incluidos los comentarios que están en la misma línea del código.)


	ESTADISTICAS - Porcentaje con respecto al Total.
	----------------------------------------------------------------------------------------

	 % Código: 72,37 %
	 % Vacío: 15,88 %
	 % Comentadas: 12,27 %


	ESTADISTICAS - Porcentaje con respecto al 72,37 % de Líneas de Código.
	----------------------------------------------------------------------------------------

	 % Vacías: 21,94 %
	 % Comentadas: 16,95 %


	\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
