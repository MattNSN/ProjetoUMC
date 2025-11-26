/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sistemalogistica.logistica.controller;

import com.sistemalogistica.model.DAO.Usuario;
import com.sistemalogistica.model.DAO.UsuarioDAO;
import com.sistemalogistica.util.CriptografiaUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *Servlet responsável por cadastrar usuários no sistema
 */
@WebServlet("/cadastrarUsuario")
public class UsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. SEGURANÇA: Verifica se é ADMIN
        HttpSession session = request.getSession(false);
        Usuario usuarioLogado = (session != null) ? (Usuario) session.getAttribute("usuarioLogado") : null;
        
        if (usuarioLogado == null || !"ADMIN".equalsIgnoreCase(usuarioLogado.getPerfil())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Acesso negado. Apenas administradores podem cadastrar usuários.");
            return;
        }

        // 2. Recebe os dados do formulário
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String perfil = request.getParameter("perfil"); // "ADMIN" ou "OPERADOR"

        try {
            Usuario novoUsuario = new Usuario();
            novoUsuario.setNome(nome);
            novoUsuario.setEmail(email);
            // IMPORTANTE: Criptografar a senha antes de salvar
            novoUsuario.setSenha(CriptografiaUtil.converterParaSha256(senha)); 
            novoUsuario.setPerfil(perfil);

            UsuarioDAO dao = new UsuarioDAO();
            dao.cadastrar(novoUsuario);
            
            // Sucesso
            response.sendRedirect("cadastro-usuario.jsp?msg=sucesso");

        } catch (Exception e) {
            e.printStackTrace();
            // Em caso de erro (ex: email duplicado), volta com msg de erro
            response.sendRedirect("cadastro-usuario.jsp?erro=emailDuplicado");
        }
    }
}