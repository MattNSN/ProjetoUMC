package com.sistemalogistica.logistica.controller;

import com.sistemalogistica.model.DAO.ChecklistDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet responsável por buscar um Checklist específico por ID
 * e encaminhá-lo para a tela de visualização de detalhes.
 */
@WebServlet("/visualizarChecklist")
public class VisualizarChecklistServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID não fornecido.");
            return;
        }
        
        try {
            Long id = Long.parseLong(idParam);
            ChecklistDAO dao = new ChecklistDAO();
            
            // Busca no banco
            ChecklistDTO checklist = dao.buscarPorId(id);
            
            if (checklist == null) {
                // Se não achar, erro 404
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Checklist não encontrado no Banco de Dados.");
                return;
            }
            
            // 3. Define o atributo EXATAMENTE como o JSP espera ("checklistDetalhe")
            request.setAttribute("checklistDetalhe", checklist);
            
            // Encaminha
            RequestDispatcher dispatcher = request.getRequestDispatcher("visualizar.jsp");
            dispatcher.forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido.");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Veja no console do NetBeans se aparecer erro aqui
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro de banco: " + e.getMessage());
        }
    }
}