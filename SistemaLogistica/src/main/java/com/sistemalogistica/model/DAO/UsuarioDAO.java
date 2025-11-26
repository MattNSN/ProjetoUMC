/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sistemalogistica.model.DAO;

import com.sistemalogistica.config.ConectaDB;
import com.sistemalogistica.model.DAO.Usuario;
import java.sql.*;

/**
 *
 * @author
 */
public class UsuarioDAO {
    
    public Usuario autenticar(String email, String senhaCriptografada) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
        Usuario usuario = null;
        
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, senhaCriptografada);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getLong("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPerfil(rs.getString("perfil"));
            }
        }
        return usuario;
    }

    // Método para cadastrar novos usuários (Apenas ADMIN usará)
    public void cadastrar(Usuario u) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO usuarios (nome, email, senha, perfil) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, u.getNome());
            stmt.setString(2, u.getEmail());
            stmt.setString(3, u.getSenha()); // Já deve vir criptografada
            stmt.setString(4, u.getPerfil());
            stmt.executeUpdate();
        }
    }
}