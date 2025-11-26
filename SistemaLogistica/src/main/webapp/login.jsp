<%-- 
    Document   : login
    Created on : 26 de nov. de 2025, 10:56:45
    Author     :
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Login - LOG Soluções</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <style>
        body { background-color: #0f172a; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .login-card { background: #1e293b; border: 1px solid #334155; color: white; width: 100%; max-width: 400px; padding: 2rem; border-radius: 10px; }
    </style>
</head>
<body>
    <div class="login-card shadow-lg">
        <div class="text-center mb-4">
            <img src="images/logo.png" alt="Logo" height="60">
            <h4 class="mt-3">Acesso Restrito</h4>
        </div>
        
        <% if(request.getAttribute("erro") != null) { %>
            <div class="alert alert-danger p-2 text-center"><%= request.getAttribute("erro") %></div>
        <% } %>

        <form action="auth" method="POST">
            <div class="mb-3">
                <label class="form-label">E-mail</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Senha</label>
                <input type="password" name="senha" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-warning w-100 fw-bold">ENTRAR</button>
        </form>
    </div>
</body>
</html>