/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sistemalogistica.logistica.controller;

import com.sistemalogistica.model.DAO.ChecklistDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author
 * 
 * Servlet para listar todas as CARGAS com filtros.
 */
@WebServlet("/listarCargas")
public class ListarCargasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ChecklistDAO dao = new ChecklistDAO();
        
        try {
            // Captura os filtros do formulário
            String dtIni = request.getParameter("dtIni");
            String dtFim = request.getParameter("dtFim");
            String busca = request.getParameter("q");

            // Busca específica de CARGAS
            List<ChecklistDTO> listaChecklists = dao.listarCargas(dtIni, dtFim, busca);
            
            // Mantém filtros na tela
            request.setAttribute("filtroDtIni", dtIni);
            request.setAttribute("filtroDtFim", dtFim);
            request.setAttribute("filtroBusca", busca);
            
            request.setAttribute("checklists", listaChecklists);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("cargas.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Erro ao listar cargas: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dados: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}