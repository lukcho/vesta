<%@ page import="vesta.parametros.UnidadEjecutora; vesta.proyectos.Categoria; vesta.proyectos.MarcoLogico" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!marcoLogicoInstance}">
    <elm:notFound elem="MarcoLogico" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">

        <div class="alert alert-info">
            <strong>Total componente:</strong> <g:formatNumber number="${totComp}" type="currency"/>
            <strong>T. otros componentes:</strong> <g:formatNumber number="${totOtros}" type="currency"/><br/>
            <strong>T. financiamiento:</strong> <g:formatNumber number="${totFin}" type="currency"/>
            <strong>Sin asignar:</strong> <g:formatNumber number="${totFin - (totComp + totOtros)}" type="currency"/>
        </div>

        <g:form class="form-horizontal" name="frmActividad" role="form" action="save_actividad_ajax" method="POST">
            <g:hiddenField name="id" value="${marcoLogicoInstance?.id}"/>
            <g:hiddenField name="proyecto.id" value="${marcoLogicoInstance.proyectoId}"/>
            <g:hiddenField name="tipoElemento.id" value="${marcoLogicoInstance.tipoElementoId}"/>
            <g:hiddenField name="marcoLogico.id" value="${marcoLogicoInstance.marcoLogicoId}"/>

            <div class="form-group keeptogether ${hasErrors(bean: marcoLogicoInstance, field: 'responsable', 'error')} ">
                <span class="grupo">
                    <label for="responsable" class="col-md-2 control-label">
                        Responsable
                    </label>

                    <div class="col-md-7">
                        <g:select id="responsable" name="responsable.id" from="${UnidadEjecutora.list([sort: 'nombre'])}"
                                  optionKey="id" value="${marcoLogicoInstance?.responsable?.id}"
                                  class="many-to-one form-control input-sm" noSelection="['null': '']"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: marcoLogicoInstance, field: 'categoria', 'error')} ">
                <span class="grupo">
                    <label for="categoria" class="col-md-2 control-label">
                        Categoría
                    </label>

                    <div class="col-md-7">
                        <g:select id="categoria" name="categoria.id" from="${Categoria.list([sort: 'descripcion'])}"
                                  optionKey="id" optionValue="descripcion"
                                  value="${marcoLogicoInstance?.categoria?.id}"
                                  class="many-to-one form-control input-sm" noSelection="['null': '']"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: marcoLogicoInstance, field: 'objeto', 'error')} ">
                <span class="grupo">
                    <label for="objeto" class="col-md-2 control-label">
                        Objeto
                    </label>

                    <div class="col-md-10">
                        <g:textArea name="objeto" cols="40" rows="5" maxlength="1023" class="form-control input-sm" value="${marcoLogicoInstance?.objeto}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: marcoLogicoInstance, field: 'monto', 'error')} required">
                <span class="grupo">
                    <label for="monto" class="col-md-2 control-label">
                        Monto
                    </label>

                    <div class="col-md-4">
                        <div class="input-group input-group-sm">
                            <g:textField name="monto" value="${fieldValue(bean: marcoLogicoInstance, field: 'monto')}"
                                         class="number money form-control input-sm  required" required="" tdnMax="${totFin - (totComp + totOtros)}"/>
                            <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                        </div>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: marcoLogicoInstance, field: 'fechaInicio', 'error')} ">
                <span class="grupo">
                    <label for="fechaInicio" class="col-md-2 control-label">
                        Fecha Inicio
                    </label>

                    <div class="col-md-5">
                        <elm:datepicker name="fechaInicio" class="datepicker form-control input-sm" value="${marcoLogicoInstance?.fechaInicio}" default="none" noSelection="['': '']"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: marcoLogicoInstance, field: 'fechaFin', 'error')} ">
                <span class="grupo">
                    <label for="fechaFin" class="col-md-2 control-label">
                        Fecha Fin
                    </label>

                    <div class="col-md-5">
                        <elm:datepicker name="fechaFin" class="datepicker form-control input-sm" value="${marcoLogicoInstance?.fechaFin}" default="none" noSelection="['': '']"/>
                    </div>
                </span>
            </div>
        </g:form>
    </div>
    <script type="text/javascript">
        var validator = $("#frmActividad").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
label.remove();
            }

        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormActividad("${show}");
                return false;
            }
            return true;
        });
    </script>
</g:else>