
<%@ page import="vesta.poa.Componente" %>

<g:if test="${!componenteInstance}">
    <elm:notFound elem="Componente" genero="o" />
</g:if>
<g:else>

    <g:if test="${componenteInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${componenteInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>