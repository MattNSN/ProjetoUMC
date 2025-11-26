package com.sistemalogistica.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe para gerenciar a conexão com o banco de dados MySQL.
 */
public class ConectaDB {

    // URL de conexão (Ajuste 'logistica' para o nome do seu DB real, se diferente)
    private static final String URL = "jdbc:mysql://localhost:3306/logistica"; 
    private static final String USUARIO = "root";
    private static final String SENHA = "";

    /**
     * Retorna uma nova conexão com o banco de dados.
     * @return Objeto Connection.
     * @throws ClassNotFoundException se o driver não for encontrado.
     * @throws SQLException se houver erro na conexão.
     */
    public static Connection conectar() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        try {
            // Carrega o driver
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            
            // Cria a conexão
            conn = DriverManager.getConnection(URL, USUARIO, SENHA);
            
            System.out.println("Conexão com o banco de dados estabelecida com sucesso.");

        } catch (ClassNotFoundException e) {
            System.out.println("Erro: Driver JDBC não encontrado.");
            throw e;
        } catch (SQLException e) {
            System.out.println("Erro de Conexão com o DB: " + e.getMessage());
            throw e;
        }
        return conn;
    }
}