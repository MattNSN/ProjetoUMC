<%-- 
    Document   : cadastro-usuario
    Created on : 26 de nov. de 2025, 11:35:27
    Author     :
--%>

<%@page import="com.sistemalogistica.model.DAO.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SEGURANÇA NA VIEW: Se não for ADMIN, redireciona para o Dashboard
    Usuario uLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (uLogado == null || !"ADMIN".equalsIgnoreCase(uLogado.getPerfil())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Usuário - LOG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <jsp:include page="includes/header.jsp"/>
</head>

<body class="log-theme-body">
    <jsp:include page="includes/sidebar.jsp">
        <jsp:param name="page" value="cadastro-usuario" />
    </jsp:include>

    <main class="main-content p-4">
        <h2 class="mb-4 text-white"><i class="bi bi-person-plus-fill"></i> Cadastro de Usuários</h2>
        
        <% if("sucesso".equals(request.getParameter("msg"))) { %>
            <div class="alert alert-success">Usuário cadastrado com sucesso!</div>
        <% } %>
        
        <% if("emailDuplicado".equals(request.getParameter("erro"))) { %>
            <div class="alert alert-danger">Erro: Este e-mail já está cadastrado no sistema.</div>
        <% } %>

        <div class="log-card p-4 shadow-lg" style="max-width: 800px;">
            <form method="POST" action="cadastrarUsuario">
                
                <div class="mb-3">
                    <label class="form-label text-log-gray">Nome Completo</label>
                    <input type="text" class="form-control" name="nome" required placeholder="Ex: João da Silva">
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label text-log-gray">E-mail (Login)</label>
                        <input type="email" class="form-control" name="email" required placeholder="usuario@log.com">
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label text-log-gray">Perfil de Acesso</label>
                        <select class="form-select" name="perfil" required>
                            <option value="OPERADOR" selected>Operador (Padrão)</option>
                            <option value="ADMIN">Administrador (Acesso Total)</option>
                        </select>
                        <div class="form-text text-white-50">
                            * Administradores podem criar outros usuários.
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label text-log-gray">Senha Inicial</label>
                    <input type="password" class="form-control" name="senha" required placeholder="******">
                </div>

                <button type="submit" class="btn btn-warning w-100 fw-bold">
                    <i class="bi bi-save"></i> Salvar Novo Usuário
                </button>
                
            </form>
        </div>
    </main>
    
    <jsp:include page="includes/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>