package vesta.reportes

import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.IndexedColors
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.xssf.usermodel.XSSFCell
import org.apache.poi.xssf.usermodel.XSSFColor
import org.apache.poi.xssf.usermodel.XSSFRow
import org.apache.poi.xssf.usermodel.XSSFSheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import vesta.parametros.poaPac.Anio
import vesta.parametros.poaPac.Fuente
import vesta.parametros.poaPac.Presupuesto
import vesta.poa.Asignacion

class Reportes5Controller {

//    def index() {}

    def reporteRecursosPdf() {

        def data = recursosNoPermanentes_funcion()
        return [anio: data.anio, data: data.data, anios: data.anios, totales: data.totales]
    }


    def recursosNoPermanentes_funcion() {
        def strAnio = new Date().format('yyyy')
        def anio = Anio.findByAnio(strAnio)

        def data = []
        def anios = []
        def partidas = Presupuesto.findAllByNumeroLike('%0000', [sort: 'numero'])
        def fuentes = Fuente.list([sort: 'codigo'])

        def totales = [:]
        totales.resta = 0

        partidas.each { partida ->
            fuentes.each { fuente ->
                def m = [:]
                m.fuente = fuente
                def numero = partida.numero?.replaceAll("0", "")
                m.partida = partida
                m.valores = [:]
                def asignaciones = Asignacion.withCriteria {
                    presupuesto {
                        like("numero", numero + "%")
                    }
                    eq("fuente", fuente)
                }
                asignaciones.each { asg ->
//                m.asignacion = asg
                    def anioAsg = asg.anio
                    def fuenteAsg = asg.fuente
                    if (anioAsg.anio.toInteger() <= anio.anio.toInteger()) {
                        if (!m.valores[anioAsg.anio]) {
                            m.valores[anioAsg.anio] = 0
                            if (!anios.contains(anioAsg.anio)) {
                                anios += anioAsg.anio
                                totales[anioAsg.anio] = 0
                            }
                        }
                        m.valores[anioAsg.anio] += asg.priorizado
                        totales[anioAsg.anio] += asg.priorizado
                        totales.resta += asg.priorizado
                    }
                }
                data += m
            }
        }
//        println("data " + data)
//        println("totales " + totales)
//        totales.each {
//            println("g " + it.key + " "+ g.formatNumber(number: it.value, maxFractionDigits: 2, minFractionDigits: 2))
//        }
        anios = anios.sort()
        return [anio: anio, data: data, anios: anios, totales: totales]
    }

    def reporteRecursosExcel() {
        def data = recursosNoPermanentes_funcion()
        def anio = data.anio
        def totales = data.totales

        def iniRow = 1
        def iniCol = 1

        def curRow = iniRow
        def curCol = iniCol

        try {

            XSSFWorkbook wb = new XSSFWorkbook()
            XSSFSheet sheet = wb.createSheet("Reporte de recursos no permanentes")

            def estilos = ReportesNuevosExcelController.getEstilos(wb)
            CellStyle styleHeader = estilos.styleHeader
            CellStyle styleNumber = estilos.styleNumber
            CellStyle styleTabla = estilos.styleTabla
            CellStyle styleFooter = estilos.styleFooter
            CellStyle styleFooterCenter = estilos.styleFooterCenter

            def titulo = "PROFORMA PRESUPUESTARIA DE RECURSOS NO PERMANENTES"
            def subtitulo = "GRUPO DE GASTO - EN DÓLARES"
            curRow = ReportesNuevosExcelController.setTitulos(sheet, estilos, iniRow, iniCol, titulo, subtitulo)

            def nrowHeader1 = curRow
            def nrowHeader2 = curRow + 1
            XSSFRow rowHeader = sheet.createRow((short) curRow)
            curRow++
            XSSFCell cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("GRUPO PRESUPUESTARIO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)


            XSSFRow rowHeader2 = sheet.createRow((short) curRow)
            curRow++
            XSSFCell cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("GRUPO DE GASTO")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 9000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 9000)

            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("FUENTE")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 7000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 7000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("PRESUPUESTO CODIFICADO AÑO ${anio.anio.toInteger() - 1}")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 8000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 8000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("PROFORMA AÑO ${anio.anio}")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 6000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("PARTICIPACIÓN % ")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 4000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 4000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("VARIACIÓN")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 4000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("ABSOLUTA")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 4000)
            curCol++

            cellHeader = rowHeader.createCell((short) curCol)
            cellHeader.setCellValue("")
            cellHeader.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 4000)

            cellHeader2 = rowHeader2.createCell((short) curCol)
            cellHeader2.setCellValue("%")
            cellHeader2.setCellStyle(styleHeader)
            sheet.setColumnWidth(curCol, 4000)
            curCol++
//            curRow++

            def totalCols = curCol
            ReportesNuevosExcelController.joinTitulos(sheet, iniRow, iniCol, totalCols)

            (0..5).each { n ->
                sheet.addMergedRegion(new CellRangeAddress(
                        nrowHeader1, //first row (0-based)
                        nrowHeader2, //last row  (0-based)
                        iniCol + n, //first column (0-based)
                        iniCol + n   //last column  (0-based)
                ))
            }
            sheet.addMergedRegion(new CellRangeAddress(
                    nrowHeader1, //first row (0-based)
                    nrowHeader1, //last row  (0-based)
                    iniCol + 6, //first column (0-based)
                    iniCol + 7   //last column  (0-based)
            ))

            def total = 0
//            println("data " + data)

            data.data.each { v ->

                def anterior = v.valores["" + (anio.anio.toInteger() - 1)] ?: 0
                def actual = v.valores[anio.anio] ?: 0

                def totalActual = totales[anio.anio] ?: 0
                def totalResta = totales.resta

                def porcentaje1 = (actual * 100) / totalActual
                def resta = actual - anterior
                def porcentaje2 = (resta * 100) / totalResta


                curCol = iniCol
                XSSFRow tableRow = sheet.createRow((short) curRow)

                def tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(v.partida.numero.replaceAll("0", ""))
                tableCell.setCellStyle(styleTabla)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(v.partida.descripcion)
                tableCell.setCellStyle(styleTabla)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(v.fuente.descripcion)
                tableCell.setCellStyle(styleTabla)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(anterior)
                tableCell.setCellStyle(styleNumber)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(actual)
                tableCell.setCellStyle(styleNumber)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(porcentaje1)
                tableCell.setCellStyle(styleNumber)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(resta)
                tableCell.setCellStyle(styleNumber)
                curCol++
                tableCell = tableRow.createCell(curCol)
                tableCell.setCellValue(porcentaje2)
                tableCell.setCellStyle(styleNumber)
                curCol++

                curRow++
            }


            curCol = iniCol
            XSSFRow totalRow = sheet.createRow((short) curRow)
            XSSFCell cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue("TOTAL")
            cellFooter.setCellStyle(styleFooterCenter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue("")
            cellFooter.setCellStyle(styleFooterCenter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue("")
            cellFooter.setCellStyle(styleFooterCenter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue(totales["" + (anio.anio.toInteger() - 1)] ?: 0)
            cellFooter.setCellStyle(styleFooter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue(totales[anio.anio])
            cellFooter.setCellStyle(styleFooter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue(100)
            cellFooter.setCellStyle(styleFooter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue(totales.resta)
            cellFooter.setCellStyle(styleFooter)

            cellFooter = totalRow.createCell((short) curCol)
            curCol++
            cellFooter.setCellValue(100)
            cellFooter.setCellStyle(styleFooter)

            sheet.addMergedRegion(new CellRangeAddress(
                    curRow, //first row (0-based)
                    curRow, //last row  (0-based)
                    iniCol, //first column (0-based)
                    iniCol + 2 //last column  (0-based)
            ))

            def output = response.getOutputStream()
            def header = "attachment; filename=" + "reporte_recursos_noPermanentes.xlsx"
            response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            response.setHeader("Content-Disposition", header)
            wb.write(output)
            output.flush()

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}