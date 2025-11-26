package com.sistemalogistica.logistica.controller;

import java.util.Date;
import java.util.List;

/**
 * Data Transfer Object para Checklist
 */
public class ChecklistDTO {
    
    // === 1. DADOS DA CARGA ===
    private Long id;
    private Long usuarioId; // Novo campo para vincular ao usuário logado
    private String remetente;
    private String nfDi;
    private String quantidade;
    private String peso;
    private List<String> tiposProduto;
    private String tipoProdutoOutro;
    private List<String> tiposVolume;
    private String tipoVolumeOutro;
    private String ctEmitido;
    private String ctNumero;
    private String temperatura;
    private Date dataCriacao;
    
    // === 2. DADOS DO RECEBIMENTO ===
    private Long recebimentoId;
    private Date recebimentoDataHora;
    private String recebimentoTransportadora;
    private String recebimentoMotorista;
    private String recebimentoPlaca;
    private String recebimentoFrota;
    private String recIrregularidades;
    private String recResultado;
    private String recColaborador;
    
    // === 3. DADOS DA EXPEDIÇÃO ===
    private Long expedicaoId;
    private Date expedicaoDataHora;
    private String expedicaoTransportadora;
    private String expedicaoMotorista;
    private String expedicaoPlaca;
    private String expedicaoFrota;
    private String expIrregularidades;
    private String expResultado;
    private String expColaborador;

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Long getUsuarioId() { return usuarioId; }
    public void setUsuarioId(Long usuarioId) { this.usuarioId = usuarioId; }

    public String getRemetente() { return remetente; }
    public void setRemetente(String remetente) { this.remetente = remetente; }
    public String getNfDi() { return nfDi; }
    public void setNfDi(String nfDi) { this.nfDi = nfDi; }
    public String getQuantidade() { return quantidade; }
    public void setQuantidade(String quantidade) { this.quantidade = quantidade; }
    public String getPeso() { return peso; }
    public void setPeso(String peso) { this.peso = peso; }
    public List<String> getTiposProduto() { return tiposProduto; }
    public void setTiposProduto(List<String> tiposProduto) { this.tiposProduto = tiposProduto; }
    public String getTipoProdutoOutro() { return tipoProdutoOutro; }
    public void setTipoProdutoOutro(String tipoProdutoOutro) { this.tipoProdutoOutro = tipoProdutoOutro; }
    public List<String> getTiposVolume() { return tiposVolume; }
    public void setTiposVolume(List<String> tiposVolume) { this.tiposVolume = tiposVolume; }
    public String getTipoVolumeOutro() { return tipoVolumeOutro; }
    public void setTipoVolumeOutro(String tipoVolumeOutro) { this.tipoVolumeOutro = tipoVolumeOutro; }
    public String getCtEmitido() { return ctEmitido; }
    public void setCtEmitido(String ctEmitido) { this.ctEmitido = ctEmitido; }
    public String getCtNumero() { return ctNumero; }
    public void setCtNumero(String ctNumero) { this.ctNumero = ctNumero; }
    public String getTemperatura() { return temperatura; }
    public void setTemperatura(String temperatura) { this.temperatura = temperatura; }
    public Date getDataCriacao() { return dataCriacao; }
    public void setDataCriacao(Date dataCriacao) { this.dataCriacao = dataCriacao; }

    // Recebimento
    public Long getRecebimentoId() { return recebimentoId; }
    public void setRecebimentoId(Long recebimentoId) { this.recebimentoId = recebimentoId; }
    public Date getRecebimentoDataHora() { return recebimentoDataHora; }
    public void setRecebimentoDataHora(Date recebimentoDataHora) { this.recebimentoDataHora = recebimentoDataHora; }
    public String getRecebimentoTransportadora() { return recebimentoTransportadora; }
    public void setRecebimentoTransportadora(String recebimentoTransportadora) { this.recebimentoTransportadora = recebimentoTransportadora; }
    public String getRecebimentoMotorista() { return recebimentoMotorista; }
    public void setRecebimentoMotorista(String recebimentoMotorista) { this.recebimentoMotorista = recebimentoMotorista; }
    public String getRecebimentoPlaca() { return recebimentoPlaca; }
    public void setRecebimentoPlaca(String recebimentoPlaca) { this.recebimentoPlaca = recebimentoPlaca; }
    public String getRecebimentoFrota() { return recebimentoFrota; }
    public void setRecebimentoFrota(String recebimentoFrota) { this.recebimentoFrota = recebimentoFrota; }
    public String getRecIrregularidades() { return recIrregularidades; }
    public void setRecIrregularidades(String recIrregularidades) { this.recIrregularidades = recIrregularidades; }
    public String getRecResultado() { return recResultado; }
    public void setRecResultado(String recResultado) { this.recResultado = recResultado; }
    public String getRecColaborador() { return recColaborador; }
    public void setRecColaborador(String recColaborador) { this.recColaborador = recColaborador; }

    // Expedicao
    public Long getExpedicaoId() { return expedicaoId; }
    public void setExpedicaoId(Long expedicaoId) { this.expedicaoId = expedicaoId; }
    public Date getExpedicaoDataHora() { return expedicaoDataHora; }
    public void setExpedicaoDataHora(Date expedicaoDataHora) { this.expedicaoDataHora = expedicaoDataHora; }
    public String getExpedicaoTransportadora() { return expedicaoTransportadora; }
    public void setExpedicaoTransportadora(String expedicaoTransportadora) { this.expedicaoTransportadora = expedicaoTransportadora; }
    public String getExpedicaoMotorista() { return expedicaoMotorista; }
    public void setExpedicaoMotorista(String expedicaoMotorista) { this.expedicaoMotorista = expedicaoMotorista; }
    public String getExpedicaoPlaca() { return expedicaoPlaca; }
    public void setExpedicaoPlaca(String expedicaoPlaca) { this.expedicaoPlaca = expedicaoPlaca; }
    public String getExpedicaoFrota() { return expedicaoFrota; }
    public void setExpedicaoFrota(String expedicaoFrota) { this.expedicaoFrota = expedicaoFrota; }
    public String getExpIrregularidades() { return expIrregularidades; }
    public void setExpIrregularidades(String expIrregularidades) { this.expIrregularidades = expIrregularidades; }
    public String getExpResultado() { return expResultado; }
    public void setExpResultado(String expResultado) { this.expResultado = expResultado; }
    public String getExpColaborador() { return expColaborador; }
    public void setExpColaborador(String expColaborador) { this.expColaborador = expColaborador; }
}