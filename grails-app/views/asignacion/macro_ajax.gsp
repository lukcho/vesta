<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/06/15
  Time: 03:30 PM
--%>

<g:select from="${macro}" optionValue="descripcion" optionKey="id" id="mac${params.mod}" name="mac_name${params.mod}" noSelection="['-1': 'Seleccione...']"
          style="width: 100%" class="form-control input-sm"/>

<script>
    $("#mac${params.mod}").change(function () {
        $("#tdActividad${params.mod}").html(spinner);
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'actividad_ajax',controller: 'asignacion')}",
            data    : {
                id   : $(this).val(),
                anio : $("#anio").val(),
                mod: "${params.mod}"
            },
            success : function (msg) {
                $("#tdActividad${params.mod}").html(msg);
                $("#tdTarea${params.mod}").html("");
            }
        });
    })

</script>