/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sistemalogistica.logistica.controller;

import com.sistemalogistica.model.DAO.UsuarioDAO;
import com.sistemalogistica.model.DAO.Usuario;
import com.sistemalogistica.util.CriptografiaUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * Servlet responsável por autenticar usuários no login
 */
@WebServlet("/auth")
public class LoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        
        try {
            UsuarioDAO dao = new UsuarioDAO();
            // Criptografa a senha digitada para comparar com o banco
            String senhaHash = CriptografiaUtil.converterParaSha256(senha);
            
            Usuario usuario = dao.autenticar(email, senhaHash);
            
            if (usuario != null) {
                // SUCESSO: Cria a sessão
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogado", usuario);
                response.sendRedirect("dashboard.jsp");
            } else {
                // ERRO: Volta pro login
                request.setAttribute("erro", "E-mail ou senha inválidos");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    // Logout
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}