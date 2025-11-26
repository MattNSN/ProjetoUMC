<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Mapeia o objeto vindo do Servlet para facilitar o uso na página --%>
<c:set var="checklist" value="${checklistDetalhe}" scope="request" />

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Check-List (ID: ${checklist.id})</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <jsp:include page="includes/header.jsp"/>
</head>

<body class="log-theme-body">
    <jsp:include page="includes/sidebar.jsp"/>

    <main class="main-content p-4">
        <h2 class="mb-4 text-white">✏️ Alterar Check-List (NF/DI: ${checklist.nfDi})</h2>
        <div class="log-card p-4 shadow-lg">
            
            <%-- 🎯 FORM APONTA PARA O SERVLET DE ALTERAÇÃO (UPDATE) --%>
            <form method="POST" action="alterarChecklist">
                
                <%-- CAMPO ESCONDIDO PARA PASSAR O ID (Fundamental para o UPDATE saber qual registro alterar) --%>
                <input type="hidden" name="id" value="${checklist.id}">
                
                <fieldset class="p-3 mb-4 border rounded border-primary-subtle">
                    <legend class="fw-bold p-1 w-auto fs-5 text">1. Dados da Carga</legend>

                    <div class="row g-3">
                        <div class="col-md-3">
                            <label for="remetente" class="form-label">Remetente/Destinatário:</label>
                            <input type="text" class="form-control" id="remetente" name="remetente" value="${checklist.remetente}" required>
                        </div>
                        <div class="col-md-3">
                            <label for="nfDi" class="form-label">NF / DI:</label>
                            <input type="text" class="form-control" id="nfDi" name="nfDi" value="${checklist.nfDi}" required>
                        </div>
                        <div class="col-md-3">
                            <label for="quantidade" class="form-label">Quantidade :</label>
                            <input type="text" class="form-control" id="quantidade" name="quantidade" value="${checklist.quantidade}">
                        </div>
                        <div class="col-md-3">
                            <label for="peso" class="form-label">Peso :</label>
                            <input type="text" class="form-control" id="peso" name="peso" value="${checklist.peso}">
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-2 text">Tipo de Produto:</h5>
                    <div class="row g-2">
                        <c:set var="tipos" value="${checklist.tiposProduto}"/>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Farmaceutico" <c:if test="${tipos.contains('Farmaceutico')}">checked</c:if>>
                            <label class="form-check-label">Farmacêutico</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Quimico" <c:if test="${tipos.contains('Quimico')}">checked</c:if>>
                            <label class="form-check-label">Químico</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Perigoso" <c:if test="${tipos.contains('Perigoso')}">checked</c:if>>
                            <label class="form-check-label">Perigoso</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Correlato" <c:if test="${tipos.contains('Correlato')}">checked</c:if>>
                            <label class="form-check-label">Correlato</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tipoProduto" value="Improdutivo" <c:if test="${tipos.contains('Improdutivo')}">checked</c:if>>
                            <label class="form-check-label">Improdutivo</label>
                        </div></div>
                        <div class="col-md-3">
                            <input type="text" class="form-control form-control-sm" name="tipoProdutoOutro" placeholder="Outros..." value="${checklist.tipoProdutoOutro}">
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-2 text">Tipo de Volume:</h5>
                    <div class="row g-2">
                        <c:set var="volumes" value="${checklist.tiposVolume}"/>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Palete" <c:if test="${volumes.contains('Palete')}">checked</c:if>>
                            <label class="form-check-label">Palete</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Caixa" <c:if test="${volumes.contains('Caixa')}">checked</c:if>>
                            <label class="form-check-label">Caixa</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Sacaria" <c:if test="${volumes.contains('Sacaria')}">checked</c:if>>
                            <label class="form-check-label">Sacaria</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" name="tiposVolume" value="Tambor" <c:if test="${volumes.contains('Tambor')}">checked</c:if>>
                            <label class="form-check-label">Tambor</label>
                        </div></div>
                        <div class="col-md-3">
                            <input type="text" class="form-control form-control-sm" name="tipoVolumeOutro" placeholder="Outros..." value="${checklist.tipoVolumeOutro}">
                        </div>
                    </div>

                    <h5 class="mt-4 mb-2 text">CT-e Emitido:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ctEmitido" id="ctSim" value="Sim" <c:if test="${checklist.ctEmitido eq 'Sim'}">checked</c:if> required>
                            <label class="form-check-label" for="ctSim">Sim</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="ctEmitido" id="ctNao" value="Nao" <c:if test="${checklist.ctEmitido eq 'Nao'}">checked</c:if>>
                            <label class="form-check-label" for="ctNao">Não</label>
                        </div></div>
                        <div class="col-md-4">
                            <input type="text" class="form-control form-control-sm" id="ctNumero" name="ctNumero" placeholder="Nº do CT-e" value="${checklist.ctNumero}">
                        </div>
                    </div>

                    <h5 class="mt-4 mb-2 text">Temperatura:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="Ambiente" <c:if test="${checklist.temperatura eq 'Ambiente'}">checked</c:if> required>
                            <label class="form-check-label">Ambiente</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="15 a 30°C" <c:if test="${checklist.temperatura eq '15 a 30°C'}">checked</c:if>>
                            <label class="form-check-label">15°C a 30°C</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="15 a 25°C" <c:if test="${checklist.temperatura eq '15 a 25°C'}">checked</c:if>>
                            <label class="form-check-label">15°C a 25°C</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="temperatura" value="2 a 8°C" <c:if test="${checklist.temperatura eq '2 a 8°C'}">checked</c:if>>
                            <label class="form-check-label">2°C a 8°C</label>
                        </div></div>
                    </div>

                </fieldset>
                
                <div class="row g-4">
                    
                    <div class="col-md-6">
                        <fieldset class="p-3 border rounded h-100 border-warning-subtle">
                            <legend class="fw-bold p-1 w-auto fs-5 text">2. Recebimento</legend>
                            
                            <h6 class="text">Data / Hora:</h6>
                            <input type="datetime-local" class="form-control mb-3" name="recebimentoDataHora"
                                   value="<fmt:formatDate value="${checklist.recebimentoDataHora}" pattern="yyyy-MM-dd'T'HH:mm"/>">
                            
                            <h6 class="text">Transporte:</h6>
                            <input type="text" class="form-control mb-2" name="recebimentoTransportadora" placeholder="Transportadora" value="${checklist.recebimentoTransportadora}">
                            <input type="text" class="form-control mb-2" name="recebimentoMotorista" placeholder="Motorista" value="${checklist.recebimentoMotorista}">
                            <input type="text" class="form-control mb-3" name="recebimentoPlaca" placeholder="Placa do Veículo" value="${checklist.recebimentoPlaca}" pattern="([A-Z]{3}[0-9]{4})|([A-Z]{3}[0-9][A-Z][0-9]{2})" title="Formato de placa inválido. Use ABC-1234 (antigo) ou ABC1D23 (Mercosul)">

                            <h6 class="text">Frota:</h6>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recebimentoFrota" value="Propria" id="recFrotaPropria" <c:if test="${checklist.recebimentoFrota eq 'Propria'}">checked</c:if>>
                                    <label class="form-check-label" for="recFrotaPropria">Própria</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recebimentoFrota" value="Terceiro" id="recFrotaTerceiro" <c:if test="${checklist.recebimentoFrota eq 'Terceiro'}">checked</c:if>>
                                    <label class="form-check-label" for="recFrotaTerceiro">Terceiro</label>
                                </div></div>
                            </div>

                            <h5 class="mt-3 text-white">Descreva as Irregularidades (Rec.):</h5>
                            <textarea class="form-control mb-3" rows="3" name="recIrregularidades">${checklist.recIrregularidades}</textarea>

                            <h5 class="mt-3">Resultado da Inspeção (Rec.):</h5>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recResultado" value="Indicios" id="recIndicios" <c:if test="${checklist.recResultado eq 'Indicios'}">checked</c:if>>
                                    <label class="form-check-label" for="recIndicios">C/ Indícios de Irregularidade</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="recResultado" value="SemIndicios" id="recSemIndicios" <c:if test="${checklist.recResultado eq 'SemIndicios'}">checked</c:if>>
                                    <label class="form-check-label" for="recSemIndicios">S/ Indícios de Irregularidade</label>
                                </div></div>
                            </div>
                            <input type="text" class="form-control" name="recColaborador" placeholder="Colaborador Responsável (assinatura)" value="${checklist.recColaborador}">

                        </fieldset>
                    </div>
                    
                    <div class="col-md-6">
                        <fieldset class="p-3 border rounded h-100 border-success-subtle">
                            <legend class="fw-bold p-1 w-auto fs-5 text">3. Expedição</legend>
                            
                            <h6 class="text">Data / Hora:</h6>
                            <input type="datetime-local" class="form-control mb-3" name="expedicaoDataHora"
                                   value="<fmt:formatDate value="${checklist.expedicaoDataHora}" pattern="yyyy-MM-dd'T'HH:mm"/>">
                            
                            <h6 class="text">Transporte:</h6>
                            <input type="text" class="form-control mb-2" name="expedicaoTransportadora" placeholder="Transportadora" value="${checklist.expedicaoTransportadora}">
                            <input type="text" class="form-control mb-2" name="expedicaoMotorista" placeholder="Motorista" value="${checklist.expedicaoMotorista}">
                            <input type="text" class="form-control mb-3" name="expedicaoPlaca" placeholder="Placa do Veículo" value="${checklist.expedicaoPlaca}" pattern="([A-Z]{3}[0-9]{4})|([A-Z]{3}[0-9][A-Z][0-9]{2})" title="Formato de placa inválido. Use ABC-1234 (antigo) ou ABC1D23 (Mercosul)">

                            <h6 class="text">Frota:</h6>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expedicaoFrota" value="Propria" id="expFrotaPropria" <c:if test="${checklist.expedicaoFrota eq 'Propria'}">checked</c:if>>
                                    <label class="form-check-label" for="expFrotaPropria">Própria</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expedicaoFrota" value="Terceiro" id="expFrotaTerceiro" <c:if test="${checklist.expedicaoFrota eq 'Terceiro'}">checked</c:if>>
                                    <label class="form-check-label" for="expFrotaTerceiro">Terceiro</label>
                                </div></div>
                            </div>

                            <h5 class="mt-3">Descreva as Irregularidades (Exp.):</h5>
                            <textarea class="form-control mb-3" rows="3" name="expIrregularidades">${checklist.expIrregularidades}</textarea>

                            <h5 class="mt-3">Resultado da Inspeção (Exp.):</h5>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expResultado" value="Indicios" id="expIndicios" <c:if test="${checklist.expResultado eq 'Indicios'}">checked</c:if>>
                                    <label class="form-check-label" for="expIndicios">C/ Indícios de Irregularidade</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="expResultado" value="SemIndicios" id="expSemIndicios" <c:if test="${checklist.expResultado eq 'SemIndicios'}">checked</c:if>>
                                    <label class="form-check-label" for="expSemIndicios">S/ Indícios de Irregularidade</label>
                                </div></div>
                            </div>
                            <input type="text" class="form-control" name="expColaborador" placeholder="Colaborador Responsável (assinatura)" value="${checklist.expColaborador}">
                            
                        </fieldset>
                    </div>
                    
                </div>
                
                <div class="text-center mt-5 mb-5">
                    <button type="submit" class="btn btn-warning btn-lg me-3">
                        <i class="bi bi-save me-2"></i> Salvar Alterações
                    </button>
                    <a href="visualizarChecklist?id=${checklist.id}" class="btn btn-secondary btn-lg">
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