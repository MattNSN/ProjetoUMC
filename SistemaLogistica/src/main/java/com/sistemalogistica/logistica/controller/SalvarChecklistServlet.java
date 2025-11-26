package com.sistemalogistica.logistica.controller;

import com.sistemalogistica.model.DAO.ChecklistDAO;
import com.sistemalogistica.model.DAO.Usuario;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet para processar e salvar os dados do checklist (INSERT Completo).
 */
@WebServlet("/salvarChecklist")
public class SalvarChecklistServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    private String getParameterOrDefault(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value != null ? value.trim() : "";
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            ChecklistDTO checklist = new ChecklistDTO();
            
            // --- 1. DADOS DA CARGA ---
            checklist.setRemetente(getParameterOrDefault(request, "remetente"));
            checklist.setNfDi(getParameterOrDefault(request, "nfDi"));
            checklist.setQuantidade(getParameterOrDefault(request, "quantidade"));
            checklist.setPeso(getParameterOrDefault(request, "peso"));
            
            if (request.getParameterValues("tipoProduto") != null)
                checklist.setTiposProduto(Arrays.asList(request.getParameterValues("tipoProduto")));
            checklist.setTipoProdutoOutro(getParameterOrDefault(request, "tipoProdutoOutro"));
            
            if (request.getParameterValues("tiposVolume") != null)
                checklist.setTiposVolume(Arrays.asList(request.getParameterValues("tiposVolume")));
            checklist.setTipoVolumeOutro(getParameterOrDefault(request, "tipoVolumeOutro"));
            
            checklist.setCtEmitido(getParameterOrDefault(request, "ctEmitido"));
            checklist.setCtNumero(getParameterOrDefault(request, "ctNumero"));
            checklist.setTemperatura(getParameterOrDefault(request, "temperatura"));

            // --- 2. DADOS DO RECEBIMENTO ---
            String recDataStr = getParameterOrDefault(request, "recebimentoDataHora");
            if (!recDataStr.isEmpty()) {
                checklist.setRecebimentoDataHora(DATETIME_FORMAT.parse(recDataStr));
            } else if (!getParameterOrDefault(request, "recColaborador").isEmpty()) {
                 checklist.setRecebimentoDataHora(new Date());
            }

            checklist.setRecebimentoTransportadora(getParameterOrDefault(request, "recebimentoTransportadora"));
            checklist.setRecebimentoMotorista(getParameterOrDefault(request, "recebimentoMotorista"));
            checklist.setRecebimentoPlaca(getParameterOrDefault(request, "recebimentoPlaca"));
            checklist.setRecebimentoFrota(getParameterOrDefault(request, "recebimentoFrota"));
            checklist.setRecIrregularidades(getParameterOrDefault(request, "recIrregularidades"));
            checklist.setRecResultado(getParameterOrDefault(request, "recResultado"));
            checklist.setRecColaborador(getParameterOrDefault(request, "recColaborador"));

            // --- 3. DADOS DA EXPEDIÇÃO ---
            String expDataStr = getParameterOrDefault(request, "expedicaoDataHora");
            if (!expDataStr.isEmpty()) {
                checklist.setExpedicaoDataHora(DATETIME_FORMAT.parse(expDataStr));
            }
            checklist.setExpedicaoTransportadora(getParameterOrDefault(request, "expedicaoTransportadora"));
            checklist.setExpedicaoMotorista(getParameterOrDefault(request, "expedicaoMotorista"));
            checklist.setExpedicaoPlaca(getParameterOrDefault(request, "expedicaoPlaca"));
            checklist.setExpedicaoFrota(getParameterOrDefault(request, "expedicaoFrota"));
            checklist.setExpIrregularidades(getParameterOrDefault(request, "expIrregularidades"));
            checklist.setExpResultado(getParameterOrDefault(request, "expResultado"));
            checklist.setExpColaborador(getParameterOrDefault(request, "expColaborador"));

            // --- 4. VINCULAR AO USUÁRIO LOGADO ---
            // Recupera a sessão atual (não cria nova se não existir)
            HttpSession session = request.getSession(false);
            if (session != null) {
                Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
                if (usuarioLogado != null) {
                    checklist.setUsuarioId(usuarioLogado.getId());
                }
            }

            // SALVAR
            ChecklistDAO dao = new ChecklistDAO();
            dao.salvar(checklist);
            
            response.sendRedirect("dashboard.jsp?msg=completoSalvo");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao salvar checklist: " + e.getMessage());
        }
    }
}