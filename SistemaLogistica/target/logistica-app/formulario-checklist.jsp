<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Check-List - LOG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <jsp:include page="includes/header.jsp"/>
</head>

<body class="log-theme-body">
    <jsp:include page="includes/sidebar.jsp"/>

    <main class="main-content p-4">
        <h2 class="mb-4 text-white">📋 Check-List de Recebimento e Expedição Completo</h2>
        <div class="log-card p-4 shadow-lg">
            
            <form method="POST" action="salvarChecklist">
                
                <fieldset class="p-3 mb-4 border rounded border-primary-subtle">
                    <legend class="fw-bold p-1 w-auto fs-5 text-primary">1. Dados da Carga</legend>

                    <div class="row g-3">
                        <div class="col-md-3">
                            <label for="remetente" class="form-label">Remetente/Destinatário:</label>
                            <input type="text" class="form-control" id="remetente" name="remetente" required>
                        </div>
                        <div class="col-md-3">
                            <label for="nfDi" class="form-label">NF / DI:</label>
                            <input type="text" class="form-control" id="nfDi" name="nfDi" required>
                        </div>
                        <div class="col-md-3">
                            <label for="quantidade" class="form-label">Quantidade :</label>
                            <input type="text" class="form-control" id="quantidade" name="quantidade">
                        </div>
                        <div class="col-md-3">
                            <label for="peso" class="form-label">Peso :</label>
                            <input type="text" class="form-control" id="peso" name="peso">
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-2 text-info">Tipo de Produto:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Farmaceutico">
                            <label class="form-check-label">Farmacêutico</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Quimico">
                            <label class="form-check-label">Químico</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Perigoso">
                            <label class="form-check-label">Perigoso</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Correlato">
                            <label class="form-check-label">Correlato</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Improdutivo">
                            <label class="form-check-label">Improdutivo</label>
                        </div></div>
                        <div class="col-md-3">
                            <input type="text" class="form-control form-control-sm" name="tipoProdutoOutro" placeholder="Outros...">
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-2 text-info">Tipo de Volume:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Palete">
                            <label class="form-check-label">Palete</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Caixa">
                            <label class="form-check-label">Caixa</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Sacaria">
                            <label class="form-check-label">Sacaria</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Tambor">
                            <label class="form-check-label">Tambor</label>
                        </div></div>
                        <div class="col-md-3">
                            <input type="text" class="form-control form-control-sm" name="tipoVolumeOutro" placeholder="Outros...">
                        </div>
                    </div>

                    <h5 class="mt-4 mb-2 text-info">CT-e Emitido:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ctEmitido" id="ctSim" value="Sim" required>
                            <label class="form-check-label" for="ctSim">Sim</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ctEmitido" id="ctNao" value="Nao">
                            <label class="form-check-label" for="ctNao">Não</label>
                        </div></div>
                        <div class="col-md-4">
                            <input type="text" class="form-control form-control-sm" id="ctNumero" name="ctNumero" placeholder="Nº do CT-e">
                        </div>
                    </div>

                    <h5 class="mt-4 mb-2 text-info">Temperatura:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="Ambiente">
                            <label class="form-check-label">Ambiente</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="15 a 30°C">
                            <label class="form-check-label">15°C a 30°C</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="15 a 25°C">
                            <label class="form-check-label">15°C a 25°C</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="2 a 8°C">
                            <label class="form-check-label">2°C a 8°C</label>
                        </div></div>
                    </div>

                </fieldset>
                
                <div class="row g-4">
                    
                    <div class="col-md-6">
                        <fieldset class="p-3 border rounded h-100 border-warning-subtle">
                            <legend class="fw-bold p-1 w-auto fs-5 text-warning">2. Recebimento</legend>
                            
                            <h6 class="text-success">Data / Hora:</h6>
                            <input type="datetime-local" class="form-control mb-3" name="recebimentoDataHora">
                            
                            <h6 class="text-warning">Transporte:</h6>
                            <input type="text" class="form-control mb-2" name="recebimentoTransportadora" placeholder="Transportadora">
                            <input type="text" class="form-control mb-2" name="recebimentoMotorista" placeholder="Motorista">
                            <input type="text" class="form-control mb-3" name="recebimentoPlaca" placeholder="Placa do Veículo" pattern="([A-Z]{3}[0-9]{4})|([A-Z]{3}[0-9][A-Z][0-9]{2})" title="Formato de placa inválido. Use ABC-1234 (antigo) ou ABC1D23 (Mercosul)">

                            <h6 class="text-warning">Frota:</h6>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recebimentoFrota" value="Propria" id="recFrotaPropria">
                                    <label class="form-check-label" for="recFrotaPropria">Própria</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recebimentoFrota" value="Terceiro" id="recFrotaTerceiro">
                                    <label class="form-check-label" for="recFrotaTerceiro">Terceiro</label>
                                </div></div>
                            </div>

                            <h5 class="mt-3 text-danger">Descreva as Irregularidades (Rec.):</h5>
                            <textarea class="form-control mb-3" rows="3" name="recIrregularidades"></textarea>

                            <h5 class="mt-3 text-success">Resultado da Inspeção (Rec.):</h5>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recResultado" value="Indicios" id="recIndicios">
                                    <label class="form-check-label" for="recIndicios">C/ Indícios de Irregularidade</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recResultado" value="SemIndicios" id="recSemIndicios">
                                    <label class="form-check-label" for="recSemIndicios">S/ Indícios de Irregularidade</label>
                                </div></div>
                            </div>
                            <input type="text" class="form-control" name="recColaborador" placeholder="Colaborador Responsável (assinatura)">

                        </fieldset>
                    </div>
                    
                    <div class="col-md-6">
                        <fieldset class="p-3 border rounded h-100 border-success-subtle">
                            <legend class="fw-bold p-1 w-auto fs-5 text-success">3. Expedição</legend>
                            
                            <h6 class="text-success">Data / Hora:</h6>
                            <input type="datetime-local" class="form-control mb-3" name="expedicaoDataHora">
                            
                            <h6 class="text-success">Transporte:</h6>
                            <input type="text" class="form-control mb-2" name="expedicaoTransportadora" placeholder="Transportadora">
                            <input type="text" class="form-control mb-2" name="expedicaoMotorista" placeholder="Motorista">
                            <input type="text" class="form-control mb-3" name="expedicaoPlaca" placeholder="Placa do Veículo" pattern="([A-Z]{3}[0-9]{4})|([A-Z]{3}[0-9][A-Z][0-9]{2})" title="Formato de placa inválido. Use ABC-1234 (antigo) ou ABC1D23 (Mercosul)">

                            <h6 class="text-success">Frota:</h6>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expedicaoFrota" value="Propria" id="expFrotaPropria">
                                    <label class="form-check-label" for="expFrotaPropria">Própria</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expedicaoFrota" value="Terceiro" id="expFrotaTerceiro">
                                    <label class="form-check-label" for="expFrotaTerceiro">Terceiro</label>
                                </div></div>
                            </div>

                            <h5 class="mt-3 text-danger">Descreva as Irregularidades (Exp.):</h5>
                            <textarea class="form-control mb-3" rows="3" name="expIrregularidades"></textarea>

                            <h5 class="mt-3 text-success">Resultado da Inspeção (Exp.):</h5>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expResultado" value="Indicios" id="expIndicios">
                                    <label class="form-check-label" for="expIndicios">C/ Indícios de Irregularidade</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expResultado" value="SemIndicios" id="expSemIndicios">
                                    <label class="form-check-label" for="expSemIndicios">S/ Indícios de Irregularidade</label>
                                </div></div>
                            </div>
                            <input type="text" class="form-control" name="expColaborador" placeholder="Colaborador Responsável (assinatura)">
                            
                        </fieldset>
                    </div>
                    
                </div>
                
                <div class="text-center mt-5 mb-5">
                    <button type="submit" class="btn btn-warning btn-lg me-3">
                        <i class="bi bi-save me-2"></i> Salvar Check-List Completo
                    </button>
                    <a href="dashboard.jsp" class="btn btn-secondary btn-lg">
                        <i class="bi bi-x-circle me-2"></i> Cancelar
                    </a>
                </div>
                
            </form>
        </div>
    </main>
    
    <jsp:include page="includes/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>