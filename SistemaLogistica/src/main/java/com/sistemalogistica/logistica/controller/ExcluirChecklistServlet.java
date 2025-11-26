package com.sistemalogistica.logistica.controller;

import com.sistemalogistica.model.DAO.ChecklistDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet responsável por processar a exclusão de um Checklist por ID.
 */
@WebServlet("/excluirChecklist")
public class ExcluirChecklistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        String origem = request.getParameter("origem"); // Para saber para onde redirecionar (recebimento ou expedicao)
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do Checklist não fornecido para exclusão.");
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
            // 1. Executa a exclusão no banco de dados
            dao.excluir(checklistId);
            
            // 2. Redireciona o usuário para a página de listagem correta
            String destino = "listarRecebimentos";
            if ("expedicao".equalsIgnoreCase(origem)) {
                destino = "listarExpedicoes";
            }
            
            // Redireciona com uma mensagem de sucesso
            response.sendRedirect(destino + "?msg=excluido");
            
        } catch (ClassNotFoundException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                               "Erro interno: Falha ao carregar o driver do banco de dados.");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                               "Erro de banco de dados ao excluir checklist.");
        }
    }
}