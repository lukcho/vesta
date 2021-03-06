
<%@ page import="vesta.parametros.Entidad" %>

<g:if test="${!entidadInstance}">
    <elm:notFound elem="Entidad" genero="o" />
</g:if>
<g:else>

    <g:if test="${entidadInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 show-label">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.direccion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Direccion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="direccion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.sigla}">
        <div class="row">
            <div class="col-md-2 show-label">
                Sigla
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="sigla"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.objetivo}">
        <div class="row">
            <div class="col-md-2 show-label">
                Objetivo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="objetivo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.telefono}">
        <div class="row">
            <div class="col-md-2 show-label">
                Telefono
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="telefono"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.fax}">
        <div class="row">
            <div class="col-md-2 show-label">
                Fax
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="fax"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.email}">
        <div class="row">
            <div class="col-md-2 show-label">
                Email
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="email"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${entidadInstance?.observaciones}">
        <div class="row">
            <div class="col-md-2 show-label">
                Observaciones
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${entidadInstance}" field="observaciones"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>