<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 20/01/15
  Time: 03:57 PM
--%>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.js')}"></script>
<link href="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.min.css')}" rel="stylesheet">

<g:select name="asg" from="${asgs}" optionKey="id" id="asignacion" optionValue='${{
    "Responsable: " + it.unidad + ", Partida: " + it.presupuesto.numero + ", Monto: " + g.formatNumber(number: it.priorizado, type: "currency")
}}' noSelection="['-1': 'Seleccione..']" class="form-control input-sm"/>
<script>
    $("#asignacion").change(function () {
        var max = getMaximo($("#asignacion").val(),0);
        $("#max").text(number_format(max, 2, '.', ','))
    });
</script>