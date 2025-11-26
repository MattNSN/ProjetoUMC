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
 * Servlet responsável por buscar todos os checklists registrados
 * e encaminhá-los para a página de visualização.
 */
@WebServlet("/listarRecebimentos")
public class ListarChecklistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ChecklistDAO dao = new ChecklistDAO();
        
        try {
            // Captura os filtros do formulário
            String dtIni = request.getParameter("dtIni");
            String dtFim = request.getParameter("dtFim");
            String busca = request.getParameter("q");

            // Busca específica de recebimentos (INNER JOIN) com filtros
            List<ChecklistDTO> listaChecklists = dao.listarRecebimentos(dtIni, dtFim, busca);
            
            // Mantém os filtros no form para o usuário ver o que pesquisou
            request.setAttribute("filtroDtIni", dtIni);
            request.setAttribute("filtroDtFim", dtFim);
            request.setAttribute("filtroBusca", busca);
            
            request.setAttribute("checklists", listaChecklists);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("recebimento.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Erro ao listar recebimentos: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dados: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}