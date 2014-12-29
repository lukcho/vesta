
<%@ page import="vesta.parametros.TipoParticipacion" %>

<g:if test="${!tipoParticipacionInstance}">
    <elm:notFound elem="TipoParticipacion" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoParticipacionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoParticipacionInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>