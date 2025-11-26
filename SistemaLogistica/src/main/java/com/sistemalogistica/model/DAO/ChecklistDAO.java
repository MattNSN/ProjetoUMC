package com.sistemalogistica.model.DAO;

import com.sistemalogistica.logistica.controller.ChecklistDTO;
import com.sistemalogistica.config.ConectaDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Data Access Object para Checklist.
 * Versão 1.7 - Correção na listagem para incluir Motoristas.
 */
public class ChecklistDAO {

    // --- INSERTS (Inclui usuario_id) ---
    private static final String INSERT_CARGA = "INSERT INTO carga (remetente, nf_di, quantidade, peso, tipos_produto, tipo_produto_outro, tipos_volume, tipo_volume_outro, ct_emitido, ct_numero, temperatura, usuario_id, data_criacao) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
    private static final String INSERT_REC = "INSERT INTO recebimento (carga_id, data_hora, transportadora, motorista, placa, frota, irregularidades, resultado, colaborador, usuario_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String INSERT_EXP = "INSERT INTO expedicao (carga_id, data_hora, transportadora, motorista, placa, frota, irregularidades, resultado, colaborador, usuario_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    // --- UPDATES (Não altera usuario_id para preservar o criador original) ---
    private static final String UPDATE_CARGA = "UPDATE carga SET remetente=?, nf_di=?, quantidade=?, peso=?, tipos_produto=?, tipo_produto_outro=?, tipos_volume=?, tipo_volume_outro=?, ct_emitido=?, ct_numero=?, temperatura=? WHERE id=?";
    private static final String UPDATE_REC = "UPDATE recebimento SET data_hora=?, transportadora=?, motorista=?, placa=?, frota=?, irregularidades=?, resultado=?, colaborador=? WHERE id=?";
    private static final String UPDATE_EXP = "UPDATE expedicao SET data_hora=?, transportadora=?, motorista=?, placa=?, frota=?, irregularidades=?, resultado=?, colaborador=? WHERE id=?";

    // --- SELECTS BASE ---
    private static final String SELECT_BY_ID = 
        "SELECT c.*, " +
        "r.id as rec_id, r.data_hora as rec_data_hora, r.transportadora as rec_transp, r.motorista as rec_moto, r.placa as rec_placa, r.frota as rec_frota, r.irregularidades as rec_irreg, r.resultado as rec_result, r.colaborador as rec_colab, " +
        "e.id as exp_id, e.data_hora as exp_data_hora, e.transportadora as exp_transp, e.motorista as exp_moto, e.placa as exp_placa, e.frota as exp_frota, e.irregularidades as exp_irreg, e.resultado as exp_result, e.colaborador as exp_colab " +
        "FROM carga c " +
        "LEFT JOIN recebimento r ON c.id = r.carga_id " +
        "LEFT JOIN expedicao e ON c.id = e.carga_id " +
        "WHERE c.id = ?";

    private static final String DELETE_SQL = "DELETE FROM carga WHERE id = ?";

    // ==================================================================================
    // MÉTODOS DE LISTAGEM COM FILTROS
    // ==================================================================================

    // 1. Listar APENAS CARGAS (Tabela pai)
    public List<ChecklistDTO> listarCargas(String dataIni, String dataFim, String busca) throws SQLException, ClassNotFoundException {
        StringBuilder sql = new StringBuilder("SELECT * FROM carga WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (dataIni != null && !dataIni.isEmpty()) {
            sql.append(" AND DATE(data_criacao) >= ?");
            params.add(dataIni);
        }
        if (dataFim != null && !dataFim.isEmpty()) {
            sql.append(" AND DATE(data_criacao) <= ?");
            params.add(dataFim);
        }
        if (busca != null && !busca.isEmpty()) {
            sql.append(" AND (nf_di LIKE ? OR remetente LIKE ?)");
            params.add("%" + busca + "%");
            params.add("%" + busca + "%");
        }

        sql.append(" ORDER BY data_criacao DESC");
        return executarQueryListagem(sql.toString(), params, "CARGA");
    }

    // 2. Listar APENAS RECEBIMENTOS (Inner Join)
    public List<ChecklistDTO> listarRecebimentos(String dataIni, String dataFim, String busca) throws SQLException, ClassNotFoundException {
        StringBuilder sql = new StringBuilder(
            "SELECT c.*, r.id as rec_id, r.data_hora as rec_data, r.transportadora as rec_transp, r.motorista as rec_moto, r.placa as rec_placa, r.resultado as rec_result " +
            "FROM carga c INNER JOIN recebimento r ON c.id = r.carga_id WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (dataIni != null && !dataIni.isEmpty()) {
            sql.append(" AND DATE(r.data_hora) >= ?");
            params.add(dataIni);
        }
        if (dataFim != null && !dataFim.isEmpty()) {
            sql.append(" AND DATE(r.data_hora) <= ?");
            params.add(dataFim);
        }
        if (busca != null && !busca.isEmpty()) {
            sql.append(" AND (c.nf_di LIKE ? OR c.remetente LIKE ?)");
            params.add("%" + busca + "%");
            params.add("%" + busca + "%");
        }

        sql.append(" ORDER BY r.data_hora DESC");
        return executarQueryListagem(sql.toString(), params, "RECEBIMENTO");
    }

    // 3. Listar APENAS EXPEDIÇÕES (Inner Join)
    public List<ChecklistDTO> listarExpedicoes(String dataIni, String dataFim, String busca) throws SQLException, ClassNotFoundException {
        StringBuilder sql = new StringBuilder(
            "SELECT c.*, e.id as exp_id, e.data_hora as exp_data, e.transportadora as exp_transp, e.motorista as exp_moto, e.placa as exp_placa, e.resultado as exp_result " +
            "FROM carga c INNER JOIN expedicao e ON c.id = e.carga_id WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (dataIni != null && !dataIni.isEmpty()) {
            sql.append(" AND DATE(e.data_hora) >= ?");
            params.add(dataIni);
        }
        if (dataFim != null && !dataFim.isEmpty()) {
            sql.append(" AND DATE(e.data_hora) <= ?");
            params.add(dataFim);
        }
        if (busca != null && !busca.isEmpty()) {
            sql.append(" AND (c.nf_di LIKE ? OR c.remetente LIKE ?)");
            params.add("%" + busca + "%");
            params.add("%" + busca + "%");
        }

        sql.append(" ORDER BY e.data_hora DESC");
        return executarQueryListagem(sql.toString(), params, "EXPEDICAO");
    }

    // Método auxiliar genérico para preencher a lista
    private List<ChecklistDTO> executarQueryListagem(String sql, List<Object> params, String tipo) throws SQLException, ClassNotFoundException {
        List<ChecklistDTO> lista = new ArrayList<>();
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ChecklistDTO dto = new ChecklistDTO();
                    dto.setId(rs.getLong("id"));
                    dto.setRemetente(rs.getString("remetente"));
                    dto.setNfDi(rs.getString("nf_di"));
                    dto.setQuantidade(rs.getString("quantidade"));
                    dto.setPeso(rs.getString("peso"));
                    dto.setDataCriacao(rs.getTimestamp("data_criacao"));
                    
                    try { dto.setUsuarioId(rs.getLong("usuario_id")); } catch (SQLException ignore) {}

                    if ("RECEBIMENTO".equals(tipo)) {
                        dto.setRecebimentoId(rs.getLong("rec_id"));
                        dto.setRecebimentoDataHora(rs.getTimestamp("rec_data"));
                        dto.setRecebimentoTransportadora(rs.getString("rec_transp"));
                        dto.setRecebimentoMotorista(rs.getString("rec_moto"));
                        dto.setRecebimentoPlaca(rs.getString("rec_placa"));
                        dto.setRecResultado(rs.getString("rec_result"));
                    } else if ("EXPEDICAO".equals(tipo)) {
                        dto.setExpedicaoId(rs.getLong("exp_id"));
                        dto.setExpedicaoDataHora(rs.getTimestamp("exp_data"));
                        dto.setExpedicaoTransportadora(rs.getString("exp_transp"));
                        dto.setExpedicaoMotorista(rs.getString("exp_moto"));
                        dto.setExpedicaoPlaca(rs.getString("exp_placa"));
                        dto.setExpResultado(rs.getString("exp_result"));
                    }
                    lista.add(dto);
                }
            }
        }
        return lista;
    }

    // ==================================================================================
    // MÉTODOS DE PERSISTÊNCIA (CRUD)
    // ==================================================================================

    // Auxiliar: Busca ID existente para evitar duplicidade
    private Long buscarIdExistente(Connection conn, String tabela, Long cargaId) throws SQLException {
        String sql = "SELECT id FROM " + tabela + " WHERE carga_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, cargaId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getLong("id");
            }
        }
        return null;
    }

    public void salvar(ChecklistDTO dto) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConectaDB.conectar();
            conn.setAutoCommit(false);

            // 1. Carga
            stmt = conn.prepareStatement(INSERT_CARGA, Statement.RETURN_GENERATED_KEYS);
            int i = 1;
            stmt.setString(i++, dto.getRemetente());
            stmt.setString(i++, dto.getNfDi());
            stmt.setString(i++, dto.getQuantidade());
            stmt.setString(i++, dto.getPeso());
            stmt.setString(i++, dto.getTiposProduto() != null ? String.join(",", dto.getTiposProduto()) : null);
            stmt.setString(i++, dto.getTipoProdutoOutro());
            stmt.setString(i++, dto.getTiposVolume() != null ? String.join(",", dto.getTiposVolume()) : null);
            stmt.setString(i++, dto.getTipoVolumeOutro());
            stmt.setString(i++, dto.getCtEmitido());
            stmt.setString(i++, dto.getCtNumero());
            stmt.setString(i++, dto.getTemperatura());
            if (dto.getUsuarioId() != null && dto.getUsuarioId() > 0) stmt.setLong(i++, dto.getUsuarioId()); else stmt.setNull(i++, java.sql.Types.BIGINT);
            stmt.executeUpdate();

            rs = stmt.getGeneratedKeys();
            Long cargaId = null;
            if (rs.next()) cargaId = rs.getLong(1);

            // 2. Recebimento
            if (dto.getRecColaborador() != null && !dto.getRecColaborador().trim().isEmpty()) {
                stmt = conn.prepareStatement(INSERT_REC);
                i = 1;
                stmt.setLong(i++, cargaId);
                stmt.setTimestamp(i++, dto.getRecebimentoDataHora() != null ? new java.sql.Timestamp(dto.getRecebimentoDataHora().getTime()) : null);
                stmt.setString(i++, dto.getRecebimentoTransportadora());
                stmt.setString(i++, dto.getRecebimentoMotorista());
                stmt.setString(i++, dto.getRecebimentoPlaca());
                stmt.setString(i++, dto.getRecebimentoFrota());
                stmt.setString(i++, dto.getRecIrregularidades());
                stmt.setString(i++, dto.getRecResultado());
                stmt.setString(i++, dto.getRecColaborador());
                if (dto.getUsuarioId() != null && dto.getUsuarioId() > 0) stmt.setLong(i++, dto.getUsuarioId()); else stmt.setNull(i++, java.sql.Types.BIGINT);
                stmt.executeUpdate();
            }

            // 3. Expedição
            if (dto.getExpColaborador() != null && !dto.getExpColaborador().trim().isEmpty()) {
                stmt = conn.prepareStatement(INSERT_EXP);
                i = 1;
                stmt.setLong(i++, cargaId);
                stmt.setTimestamp(i++, dto.getExpedicaoDataHora() != null ? new java.sql.Timestamp(dto.getExpedicaoDataHora().getTime()) : null);
                stmt.setString(i++, dto.getExpedicaoTransportadora());
                stmt.setString(i++, dto.getExpedicaoMotorista());
                stmt.setString(i++, dto.getExpedicaoPlaca());
                stmt.setString(i++, dto.getExpedicaoFrota());
                stmt.setString(i++, dto.getExpIrregularidades());
                stmt.setString(i++, dto.getExpResultado());
                stmt.setString(i++, dto.getExpColaborador());
                if (dto.getUsuarioId() != null && dto.getUsuarioId() > 0) stmt.setLong(i++, dto.getUsuarioId()); else stmt.setNull(i++, java.sql.Types.BIGINT);
                stmt.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }

    public void atualizar(ChecklistDTO dto) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConectaDB.conectar();
            conn.setAutoCommit(false);

            // 1. Update Carga
            stmt = conn.prepareStatement(UPDATE_CARGA);
            int i = 1;
            stmt.setString(i++, dto.getRemetente());
            stmt.setString(i++, dto.getNfDi());
            stmt.setString(i++, dto.getQuantidade());
            stmt.setString(i++, dto.getPeso());
            stmt.setString(i++, dto.getTiposProduto() != null ? String.join(",", dto.getTiposProduto()) : null);
            stmt.setString(i++, dto.getTipoProdutoOutro());
            stmt.setString(i++, dto.getTiposVolume() != null ? String.join(",", dto.getTiposVolume()) : null);
            stmt.setString(i++, dto.getTipoVolumeOutro());
            stmt.setString(i++, dto.getCtEmitido());
            stmt.setString(i++, dto.getCtNumero());
            stmt.setString(i++, dto.getTemperatura());
            stmt.setLong(i++, dto.getId());
            stmt.executeUpdate();

            // 2. Recebimento (Com blindagem)
            if (dto.getRecebimentoId() == null || dto.getRecebimentoId() == 0) {
                Long idExistente = buscarIdExistente(conn, "recebimento", dto.getId());
                if (idExistente != null) dto.setRecebimentoId(idExistente);
            }

            if (dto.getRecebimentoId() != null && dto.getRecebimentoId() > 0) {
                // UPDATE
                stmt = conn.prepareStatement(UPDATE_REC);
                i = 1;
                stmt.setTimestamp(i++, dto.getRecebimentoDataHora() != null ? new java.sql.Timestamp(dto.getRecebimentoDataHora().getTime()) : null);
                stmt.setString(i++, dto.getRecebimentoTransportadora());
                stmt.setString(i++, dto.getRecebimentoMotorista());
                stmt.setString(i++, dto.getRecebimentoPlaca());
                stmt.setString(i++, dto.getRecebimentoFrota());
                stmt.setString(i++, dto.getRecIrregularidades());
                stmt.setString(i++, dto.getRecResultado());
                stmt.setString(i++, dto.getRecColaborador());
                stmt.setLong(i++, dto.getRecebimentoId());
                stmt.executeUpdate();
            } else if (dto.getRecColaborador() != null && !dto.getRecColaborador().trim().isEmpty()) {
                // INSERT (Novo registro tardio = registra usuario atual)
                stmt = conn.prepareStatement(INSERT_REC);
                i = 1;
                stmt.setLong(i++, dto.getId());
                stmt.setTimestamp(i++, dto.getRecebimentoDataHora() != null ? new java.sql.Timestamp(dto.getRecebimentoDataHora().getTime()) : null);
                stmt.setString(i++, dto.getRecebimentoTransportadora());
                stmt.setString(i++, dto.getRecebimentoMotorista());
                stmt.setString(i++, dto.getRecebimentoPlaca());
                stmt.setString(i++, dto.getRecebimentoFrota());
                stmt.setString(i++, dto.getRecIrregularidades());
                stmt.setString(i++, dto.getRecResultado());
                stmt.setString(i++, dto.getRecColaborador());
                if (dto.getUsuarioId() != null && dto.getUsuarioId() > 0) stmt.setLong(i++, dto.getUsuarioId()); else stmt.setNull(i++, java.sql.Types.BIGINT);
                stmt.executeUpdate();
            }

            // 3. Expedição (Com blindagem)
            if (dto.getExpedicaoId() == null || dto.getExpedicaoId() == 0) {
                Long idExistente = buscarIdExistente(conn, "expedicao", dto.getId());
                if (idExistente != null) dto.setExpedicaoId(idExistente);
            }

            if (dto.getExpedicaoId() != null && dto.getExpedicaoId() > 0) {
                // UPDATE
                stmt = conn.prepareStatement(UPDATE_EXP);
                i = 1;
                stmt.setTimestamp(i++, dto.getExpedicaoDataHora() != null ? new java.sql.Timestamp(dto.getExpedicaoDataHora().getTime()) : null);
                stmt.setString(i++, dto.getExpedicaoTransportadora());
                stmt.setString(i++, dto.getExpedicaoMotorista());
                stmt.setString(i++, dto.getExpedicaoPlaca());
                stmt.setString(i++, dto.getExpedicaoFrota());
                stmt.setString(i++, dto.getExpIrregularidades());
                stmt.setString(i++, dto.getExpResultado());
                stmt.setString(i++, dto.getExpColaborador());
                stmt.setLong(i++, dto.getExpedicaoId());
                stmt.executeUpdate();
            } else if (dto.getExpColaborador() != null && !dto.getExpColaborador().trim().isEmpty()) {
                // INSERT (Novo registro tardio = registra usuario atual)
                stmt = conn.prepareStatement(INSERT_EXP);
                i = 1;
                stmt.setLong(i++, dto.getId());
                stmt.setTimestamp(i++, dto.getExpedicaoDataHora() != null ? new java.sql.Timestamp(dto.getExpedicaoDataHora().getTime()) : null);
                stmt.setString(i++, dto.getExpedicaoTransportadora());
                stmt.setString(i++, dto.getExpedicaoMotorista());
                stmt.setString(i++, dto.getExpedicaoPlaca());
                stmt.setString(i++, dto.getExpedicaoFrota());
                stmt.setString(i++, dto.getExpIrregularidades());
                stmt.setString(i++, dto.getExpResultado());
                stmt.setString(i++, dto.getExpColaborador());
                if (dto.getUsuarioId() != null && dto.getUsuarioId() > 0) stmt.setLong(i++, dto.getUsuarioId()); else stmt.setNull(i++, java.sql.Types.BIGINT);
                stmt.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }

    public ChecklistDTO buscarPorId(Long id) throws SQLException, ClassNotFoundException {
        ChecklistDTO dto = null;
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_ID)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                dto = new ChecklistDTO();
                dto.setId(rs.getLong("id"));
                dto.setUsuarioId(rs.getLong("usuario_id")); 
                dto.setRemetente(rs.getString("remetente"));
                dto.setNfDi(rs.getString("nf_di"));
                dto.setQuantidade(rs.getString("quantidade"));
                dto.setPeso(rs.getString("peso"));
                
                String tp = rs.getString("tipos_produto");
                if(tp != null) dto.setTiposProduto(Arrays.asList(tp.split(",")));
                
                String tv = rs.getString("tipos_volume");
                if(tv != null) dto.setTiposVolume(Arrays.asList(tv.split(",")));
                
                dto.setTipoProdutoOutro(rs.getString("tipo_produto_outro"));
                dto.setTipoVolumeOutro(rs.getString("tipo_volume_outro"));
                dto.setCtEmitido(rs.getString("ct_emitido"));
                dto.setCtNumero(rs.getString("ct_numero"));
                dto.setTemperatura(rs.getString("temperatura"));
                dto.setDataCriacao(rs.getTimestamp("data_criacao"));
                
                dto.setRecebimentoId(rs.getLong("rec_id"));
                dto.setRecebimentoDataHora(rs.getTimestamp("rec_data_hora"));
                dto.setRecebimentoTransportadora(rs.getString("rec_transp"));
                dto.setRecebimentoMotorista(rs.getString("rec_moto"));
                dto.setRecebimentoPlaca(rs.getString("rec_placa"));
                dto.setRecebimentoFrota(rs.getString("rec_frota"));
                dto.setRecIrregularidades(rs.getString("rec_irreg"));
                dto.setRecResultado(rs.getString("rec_result"));
                dto.setRecColaborador(rs.getString("rec_colab"));
                
                dto.setExpedicaoId(rs.getLong("exp_id"));
                dto.setExpedicaoDataHora(rs.getTimestamp("exp_data_hora"));
                dto.setExpedicaoTransportadora(rs.getString("exp_transp"));
                dto.setExpedicaoMotorista(rs.getString("exp_moto"));
                dto.setExpedicaoPlaca(rs.getString("exp_placa"));
                dto.setExpedicaoFrota(rs.getString("exp_frota"));
                dto.setExpIrregularidades(rs.getString("exp_irreg"));
                dto.setExpResultado(rs.getString("exp_result"));
                dto.setExpColaborador(rs.getString("exp_colab"));
            }
        }
        return dto;
    }

    public void excluir(Long id) throws SQLException, ClassNotFoundException {
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(DELETE_SQL)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }

    // ==================================================================================
    // MÉTODOS DE DASHBOARD (Contagens)
    // ==================================================================================

    public int contarRecebimentosHoje() throws SQLException, ClassNotFoundException {
        // Contagem TOTAL de recebimentos (para o dashboard)
        String sql = "SELECT COUNT(*) FROM recebimento";
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public int contarExpedicoesHoje() throws SQLException, ClassNotFoundException {
        // Contagem TOTAL de expedições (para o dashboard)
        String sql = "SELECT COUNT(*) FROM expedicao";
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}