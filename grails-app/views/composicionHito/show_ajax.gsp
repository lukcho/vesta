
<%@ page import="vesta.hitos.ComposicionHito" %>

<g:if test="${!composicionHitoInstance}">
    <elm:notFound elem="ComposicionHito" genero="o" />
</g:if>
<g:else>

    <g:if test="${composicionHitoInstance?.hito}">
        <div class="row">
            <div class="col-md-2 show-label">
                Hito
            </div>
            
            <div class="col-md-3">
                ${composicionHitoInstance?.hito?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${composicionHitoInstance?.marcoLogico}">
        <div class="row">
            <div class="col-md-2 show-label">
                Marco Logico
            </div>
            
            <div class="col-md-3">
                ${composicionHitoInstance?.marcoLogico?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${composicionHitoInstance?.proyecto}">
        <div class="row">
            <div class="col-md-2 show-label">
                Proyecto
            </div>
            
            <div class="col-md-3">
                ${composicionHitoInstance?.proyecto?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${composicionHitoInstance?.proceso}">
        <div class="row">
            <div class="col-md-2 show-label">
                Proceso
            </div>
            
            <div class="col-md-3">
                ${composicionHitoInstance?.proceso?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${composicionHitoInstance?.fecha}">
        <div class="row">
            <div class="col-md-2 show-label">
                Fecha
            </div>
            
            <div class="col-md-3">
                <g:formatDate date="${composicionHitoInstance?.fecha}" format="dd-MM-yyyy" />
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${composicionHitoInstance?.avanceFinanciero}">
        <div class="row">
            <div class="col-md-2 show-label">
                Avance Financiero
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${composicionHitoInstance}" field="avanceFinanciero"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${composicionHitoInstance?.avanceFisico}">
        <div class="row">
            <div class="col-md-2 show-label">
                Avance Fisico
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${composicionHitoInstance}" field="avanceFisico"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>