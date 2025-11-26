<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sistemalogistica.model.DAO.ChecklistDAO" %>
<%
    request.setAttribute("pageTitle", "Dashboard - LOG - Soluções rápidas");

    // LÓGICA PARA BUSCAR TOTAIS
    int totalRecebimentos = 0;
    int totalExpedicoes = 0;
    
    try {
        ChecklistDAO dao = new ChecklistDAO();
        totalRecebimentos = dao.contarRecebimentosHoje();
        totalExpedicoes = dao.contarExpedicoesHoje();
    } catch (Exception e) {
        e.printStackTrace();
        // Opcional: Tratar erro (ex: deixar 0)
    }
%>
<jsp:include page="includes/header.jsp" />

<jsp:include page="includes/sidebar.jsp">
    <jsp:param name="page" value="dashboard" />
</jsp:include>

<div class="main-content">
    <!-- Page Header -->
    <div class="page-header">
        <img src="${pageContext.request.contextPath}/images/logo.png" 
             alt="LOG - Soluções rápidas" 
             class="page-header-logo">
        <div class="page-header-title">
            <h1>Log - Logística</h1>
            <p>Visão geral das operações de recebimento e expedição</p>
        </div>
    </div>
    
    <!-- Mensagens de Feedback -->
    <% if("completoSalvo".equals(request.getParameter("msg"))) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> Checklist salvo com sucesso!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    <% if("alteracaoSalva".equals(request.getParameter("msg"))) { %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <i class="bi bi-pencil-square me-2"></i> Alterações salvas com sucesso!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>
    
    <!-- Métricas Principais -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-md-6 col-lg-3">
            <div class="log-card metric-card">
                <div class="metric-info">
                    <p>Recebimentos (Total)</p>
                    <!-- Valor Dinâmico -->
                    <div class="metric-value"><%= totalRecebimentos %></div>
                    <div class="metric-trend trend-up">
                        <small>Registrados</small>
                    </div>
                </div>
                <i class="bi bi-box-seam metric-icon"></i>
            </div>
        </div>
        
        <div class="col-12 col-md-6 col-lg-3">
            <div class="log-card metric-card">
                <div class="metric-info">
                    <p>Expedições (Total)</p>
                    <!-- Valor Dinâmico -->
                    <div class="metric-value"><%= totalExpedicoes %></div>
                    <div class="metric-trend trend-up">
                        <small>Registrados</small>
                    </div>
                </div>
                <i class="bi bi-truck metric-icon"></i>
            </div>
        </div>
    </div>
    
    <!-- Atalhos Rápidos (Opcional, para preencher espaço) -->
    <div class="row g-3">
        <div class="col-12">
            <div class="log-card">
                <h5 class="text-log-gray mb-3">Acesso Rápido</h5>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="formulario-checklist.jsp" class="btn btn-log-primary">
                        <i class="bi bi-plus-lg"></i> Novo Checklist
                    </a>
                    <a href="listarRecebimentos" class="btn btn-log-secondary">
                        <i class="bi bi-list-ul"></i> Ver Recebimentos
                    </a>
                    <a href="listarExpedicoes" class="btn btn-log-secondary">
                        <i class="bi bi-list-ul"></i> Ver Expedições
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />