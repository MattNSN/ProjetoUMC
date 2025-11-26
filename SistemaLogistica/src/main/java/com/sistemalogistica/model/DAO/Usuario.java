/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sistemalogistica.model.DAO;

/**
 *
 * @author
 */
public class Usuario {
    private Long id;
    private String nome;
    private String email;
    private String senha;
    private String perfil; // "ADMIN" ou "OPERADOR"

    // Construtores, Getters e Setters
    public Usuario() {}
    
    public Usuario(String nome, String email, String senha, String perfil) {
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.perfil = perfil;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
    public String getPerfil() { return perfil; }
    public void setPerfil(String perfil) { this.perfil = perfil; }
    
    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.perfil);
    }
}