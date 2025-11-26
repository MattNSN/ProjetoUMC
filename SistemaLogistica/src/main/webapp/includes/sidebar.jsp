<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.sistemalogistica.model.DAO.Usuario"%>
<%
    // Recupera o usuário da sessão para controle de exibição
    Usuario usuarioMenu = (Usuario) session.getAttribute("usuarioLogado");
%>

<%
    String currentPage = request.getParameter("page");
    if (currentPage == null) {
        currentPage = "dashboard";
    }
%>

<div class="sidebar">
    <!-- Logo -->
    <div class="sidebar-logo">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="LOG - Soluções rápidas">
    </div>
    
    <!-- Navegação -->
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" 
           class="nav-button <%= currentPage.equals("dashboard") ? "active" : "" %>" 
           title="Dashboard">
            <i class="bi bi-house-door"></i>
        </a>
        
        <a href="${pageContext.request.contextPath}/formulario-checklist.jsp" 
           class="nav-button <%= currentPage.equals("formulario") ? "active" : "" %>" 
           title="Formulário Checklist">
            <i class="bi bi-clipboard-check"></i>
        </a>
        
        <%-- NOVO: Link para listar TODAS as Cargas --%>
        <a href="${pageContext.request.contextPath}/listarCargas" 
           class="nav-button <%= currentPage.equals("cargas") ? "active" : "" %>" 
           title="Listar Cargas">
            <i class="bi bi-card-list"></i>
        </a>
        
        <%-- Link aponta para o Servlet /listarRecebimentos --%>
        <a href="${pageContext.request.contextPath}/listarRecebimentos" 
           class="nav-button <%= currentPage.equals("recebimento") ? "active" : "" %>" 
           title="Recebimento">
            <i class="bi bi-box-seam"></i>
        </a>
        
        <%-- Link aponta para o Servlet /listarExpedicoes --%>
        <a href="${pageContext.request.contextPath}/listarExpedicoes" 
           class="nav-button <%= currentPage.equals("expedicao") ? "active" : "" %>" 
           title="Expedição">
            <i class="bi bi-truck"></i>
        </a>

        <%-- ========================================================= --%>
        <%-- Link de Cadastro de Usuário (Apenas para ADMIN)          --%>
        <%-- ========================================================= --%>
        <% if (usuarioMenu != null && "ADMIN".equalsIgnoreCase(usuarioMenu.getPerfil())) { %>
            <a href="${pageContext.request.contextPath}/cadastro-usuario.jsp" 
               class="nav-button <%= currentPage.equals("cadastro-usuario") ? "active" : "" %>" 
               title="Cadastrar Usuário">
                <i class="bi bi-person-plus-fill"></i>
            </a>
        <% } %>

    </nav>
    
    <!-- Spacer empurra o conteúdo abaixo para o fundo -->
    <div class="sidebar-spacer"></div>
    
    <!-- Botão de Sair (Logout) -->
    <a href="${pageContext.request.contextPath}/auth" 
       class="nav-button text-danger mb-2" 
       title="Sair do Sistema">
        <i class="bi bi-box-arrow-right"></i>
    </a>

    <!-- Avatar do usuário -->
    <div class="user-avatar" title="Usuário: <%= (usuarioMenu != null) ? usuarioMenu.getNome() : "" %>">
        <i class="bi bi-person"></i>
    </div>
</div>