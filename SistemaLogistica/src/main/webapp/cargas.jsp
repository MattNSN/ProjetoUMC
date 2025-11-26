<%-- 
    Document   : cargas
    Created on : 26 de nov. de 2025, 13:12:02
    Author     :
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    request.setAttribute("pageTitle", "Cargas - LOG - Soluções rápidas");
%>
<jsp:include page="includes/header.jsp" />

<jsp:include page="includes/sidebar.jsp">
    <jsp:param name="page" value="cargas" />
</jsp:include>

<div class="main-content">
    <div class="page-header">
        <img src="${pageContext.request.contextPath}/images/logo.png" 
             alt="LOG - Soluções rápidas" 
             class="page-header-logo">
        <div class="page-header-title">
            <h1>Gerenciamento de Cargas</h1>
            <p>Histórico completo de cargas registradas</p>
        </div>
    </div>
    
    <div class="log-card mb-4">
        <form action="listarCargas" method="GET">
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Data Inicial</label>
                    <input type="date" class="form-control" name="dtIni" value="${filtroDtIni}">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Data Final</label>
                    <input type="date" class="form-control" name="dtFim" value="${filtroDtFim}">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Buscar NF ou Remetente</label>
                    <input type="text" class="form-control" name="q" value="${filtroBusca}" placeholder="Digite para buscar...">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-log-primary w-100">
                        <i class="bi bi-search"></i> Buscar
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    <div class="mb-3 d-flex justify-content-between align-items-center">
        <h2 class="text-log-gray">Cargas Registradas</h2>
        <a href="${pageContext.request.contextPath}/formulario-checklist.jsp" class="btn btn-log-primary">
            <i class="bi bi-plus-circle"></i> Nova Carga
        </a>
    </div>
    
    <div class="row g-3">
        <c:choose>
            <c:when test="${empty checklists}">
                <div class="col-12">
                    <div class="log-card">
                        <p class="text-log-gray-muted mb-0">Nenhuma carga encontrada com os filtros selecionados.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <%-- INÍCIO DO LOOP --%>
                <c:forEach var="checklist" items="${checklists}">
                    <div class="col-12 col-lg-6">
                        <div class="log-card">
                            
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div>
                                    <h3 class="text-log-gray mb-1">${checklist.remetente}</h3>
                                    <p class="text-log-gray-muted mb-1">NF/DI: ${checklist.nfDi}</p>
                                    <p class="text-log-gray-muted" style="font-size: 0.875rem;">
                                        <i class="bi bi-calendar3"></i> 
                                        Criado em: <fmt:formatDate value="${checklist.dataCriacao}" pattern="dd/MM/yyyy HH:mm"/>
                                    </p>
                                </div>
                            </div>
                            
                            <div class="border-top border-log-accent pt-3">
                                <div class="row g-2 mb-2">
                                    <div class="col-6">
                                        <small class="text-log-gray-muted">Quantidade:</small>
                                        <p class="text-log-gray mb-0">${checklist.quantidade}</p>
                                    </div>
                                    <div class="col-6">
                                        <small class="text-log-gray-muted">Peso:</small>
                                        <p class="text-log-gray mb-0">${checklist.peso != null ? checklist.peso : 'N/A'}</p> 
                                    </div>
                                </div>
                                
                                <div class="mt-3 d-flex gap-2">
                                    <a href="visualizarChecklist?id=${checklist.id}" class="btn btn-log-secondary btn-sm">
                                        <i class="bi bi-eye"></i> Visualizar
                                    </a>
                                    
                                    <a href="excluirChecklist?id=${checklist.id}&origem=carga" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('ATENÇÃO: Excluir a Carga apagará também o Recebimento e a Expedição vinculados. Deseja continuar?')">
                                        <i class="bi bi-trash"></i> Excluir
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <%-- FIM DO LOOP --%>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div class="mb-5"></div>
</div>

<jsp:include page="includes/footer.jsp" />