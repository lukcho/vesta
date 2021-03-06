<g:each in="${asignaciones}" var="asg">
    <g:set var="objTitle" value="${asg.tarea.actividad.macroActividad.objetivoGastoCorriente.descripcion}"/>
    <g:set var="obj" value="${objTitle.size() > 80 ? objTitle[0..79] + '…' : objTitle}"/>
    <tr data-res="${asg?.unidad?.id}" data-asi="${asg?.actividad}" data-par="${asg?.presupuesto?.numero + " - " + asg?.presupuesto?.descripcion}"
        data-parId="${asg?.presupuesto?.id}" data-fue="${asg?.fuente?.id}" data-val="${asg?.planificado}" data-id="${asg?.id}" data-obj="${asg?.tarea?.actividad?.macroActividad?.objetivoGastoCorriente?.id}"
        data-mac="${asg?.tarea?.actividad?.macroActividad?.id}" data-act="${asg?.tarea?.actividad?.id}" data-tar="${asg?.tarea?.id}">

        <td style="width: 200px">${asg?.unidad?.nombre}</td>
        <td style="width: 200px" title="${objTitle}">${obj}</td>
        <td style="width: 150px">${asg?.tarea?.actividad?.macroActividad?.descripcion}</td>
        <td style="width: 150px">${asg?.tarea?.actividad?.descripcion}</td>
        <g:if test="${asg?.tarea?.descripcion}">
            %{--<td style="width: 100px">${asg?.tarea?.descripcion?.size() > 70 ? asg?.tarea?.descripcion?.substring(0,70) : asg?.tarea?.descripcion}</td> --}%
            <td style="width: 100px">${asg?.tarea?.descripcion?.size() < 70 ?: asg?.tarea?.descripcion?.substring(0,70)}</td>
        </g:if>
        <g:else>
            <td></td>
        </g:else>
        %{--<td style="width: 250px">${asg?.actividad}</td>--}%
        <td style="width: 80px;">${asg?.presupuesto?.numero}</td>
        <td style="width: 100px;">${asg?.presupuesto?.descripcion}</td>
        <td style="width: 80px">${asg?.fuente?.codigo}</td>
        %{--<td style="width: 100px">${asg?.planificado}</td>--}%
        <td style="width: 100px"><g:formatNumber number="${asg?.planificado.toDouble()}"
                                                 format="###,##0"
                                                 minFractionDigits="2" maxFractionDigits="2"/></td>
        <td style="width: 100px;">
            <g:if test="${anio?.estadoGp == 0}">
                <div class="btn-group btn-group-xs" role="group">
                    <a href="#" id="btnEditar" class="btn btn-success editar_ajax" title="Editar" iden="${asg.id}"><i class="fa fa-pencil"></i>
                    </a>
                    <a href="#" id="btnBorrar" class="btn btn-danger borrar_ajax" title="Borrar" iden="${asg.id}" nom="${asg?.presupuesto?.descripcion}"><i class="fa fa-trash"></i>
                    </a>
                </div>
            </g:if>
        </td>
    </tr>
</g:each>

<script>



    $(".borrar_ajax").click(function () {
        var idBorrar = $(this).attr("iden");
        var nombreBorrar = $(this).attr("nom");
        var objetivo = $("#objetivo").val();
        var unidad = $("#idResponsable").val();
        bootbox.confirm("<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'>" +
                "</i>Está seguro que desea borrar la asignación: " + nombreBorrar + "<br/>" +
                "se borrará además la programación de esta asignación <br/>" +
                "¿Proceder con el borrado?", function (result) {
            if (result) {
                openLoader();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'asignacion', action:'delete_ajax')}?id=" + idBorrar,
                    success : function (msg) {
                        closeLoader();
                        var parts = msg.split("*");
                        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                        if (parts[0] == "SUCCESS") {
                            cargarDetalles(objetivo, unidad);
                            totales(objetivo, unidad);
                        }
                    }
                });
            }
        })
    });

    $(".editar_ajax").click(function () {

//        cargarActividadesTareas($("#mac").val(), false);

        $("#btnVerTodos").removeClass('show').addClass('hide');
        $("#divColor1").removeClass("hide").addClass("show");
        $("#divColor2").removeClass("hide").addClass("show");
        var idEditar = $(this).attr("iden");
        $("#guardarEditar").addClass('show');
        $("#cancelarEditar").addClass('show');
        $("#btnGuardar").removeClass('show').addClass('hide');
        $("#anio").prop('disabled', true);
        $("#mac").prop('disabled', true);
        $("#crearActividad").removeClass('hide').addClass('show');
        $("#crearTarea").removeClass('hide').addClass('show');

        var responsableEditar = $(this).parents("tr").attr("data-res");
        var asignacionEditar = $(this).parents("tr").attr("data-asi");
        var fuenteEditar = $(this).parents("tr").attr("data-fue");
        var valorEditar = $(this).parents("tr").attr("data-val");
        var partidaEditar = $(this).parents("tr").attr("data-par");
        var partidaId = $(this).parents("tr").attr("data-parId");
        var asignacionId = $(this).parents("tr").attr("data-id");
        var objetivoId = $(this).parents("tr").attr("data-obj");
        var macroId = $(this).parents("tr").attr("data-mac");
        var actiId = $(this).parents("tr").attr("data-act");
        var tareaId = $(this).parents("tr").attr("data-tar");


        $("#idResponsable").val(responsableEditar);
        $("#asignacion_txt").val(asignacionEditar);
//        $("#prsp_id").val(partidaId);
        $("#prsp_id").val(partidaEditar);
        $("#prsp_hide").val(partidaId);
        $("#bsc-desc-prsp_id").val(partidaEditar);
        $("#valor").val(valorEditar);
        $("#fuente").val(fuenteEditar);
        $("#asignacionId").val(asignacionId);
        $("#objetivo").val(objetivoId).prop('disabled', true);

//       console.log("valf" +  objetivoId)

//        $("#crearTarea").addClass('show');
//        $("#crearActividad").addClass('show');

        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'asignacion', action:'macro_ajax')}",
            data    : {
                objetivo : objetivoId,
                mac      : macroId
            },
            success : function (msg) {
                $("#tdMacro").html(msg);
                $("#mac").prop('disabled', true);

                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'actividad_ajax',controller: 'asignacion')}",
                    data    : {
                        id   : macroId,
                        anio : $("#anio").val(),
                        act  : actiId
                    },
                    success : function (msg) {
                        $("#tdActividad").html(msg);
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'tarea_ajax',controller: 'asignacion')}",
                            data    : {
                                id  : actiId,
                                tar : tareaId
                            },
                            success : function (msg) {
                                $("#tdTarea").html(msg);
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(controller: 'asignacion', action:'totalObjetivo_ajax')}",
                                    data    : {
                                        objetivo : $("#objetivo").val(),
                                        anio     : $("#anio").val()

                                    },
                                    success : function (msg) {
                                        $("#divTotales").html(msg);

                                    }
                                });
                            }
                        });
                    }
                });

            }
        });

    });

</script>

