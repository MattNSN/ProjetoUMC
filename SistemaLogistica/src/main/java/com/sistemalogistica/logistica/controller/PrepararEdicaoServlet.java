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
 * Servlet responsável por buscar um Checklist específico e encaminhá-lo para o formulario de edicao.
 */
@WebServlet("/prepararEdicao")
public class PrepararEdicaoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do Checklist não fornecido.");
            return;
        }
        
        Long checklistId = null;
        try {
            checklistId = Long.parseLong(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do Checklist em formato inválido.");
            return;
        }
        
        ChecklistDAO dao = new ChecklistDAO();
        
        try {
            // 1. Busca o checklist completo por ID
            ChecklistDTO checklist = dao.buscarPorId(checklistId);
            
            if (checklist == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Checklist não encontrado.");
                return;
            }
            
            // 2. Armazena o DTO no objeto Request
            request.setAttribute("checklistDetalhe", checklist);
            
            // 3. Define o destino: editar.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("editar.jsp");
            
            // 4. Encaminha a requisição
            dispatcher.forward(request, response);
            
        } catch (ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                               "Erro interno: Falha ao carregar o driver do banco de dados.");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                               "Erro de banco de dados ao buscar checklist para edição.");
        }
    }
}