/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sistemalogistica.config;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * Filtro de Segurança para validar sessão
 */
@WebFilter("/*")
public class SecurityFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        String uri = request.getRequestURI();
        HttpSession session = request.getSession(false);
        boolean logado = (session != null && session.getAttribute("usuarioLogado") != null);
        
        // Páginas liberadas sem login (login, css, js, images)
        boolean urlLiberada = uri.endsWith("login.jsp") || 
                              uri.endsWith("auth") || 
                              uri.contains("/css/") || 
                              uri.contains("/js/") || 
                              uri.contains("/images/");

        if (logado || urlLiberada) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    public void init(FilterConfig fConfig) throws ServletException {}
    public void destroy() {}
}