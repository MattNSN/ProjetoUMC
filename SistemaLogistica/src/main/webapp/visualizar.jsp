<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Mapeia 'checklistDetalhe' (do Servlet) para 'checklist' --%>
<c:set var="checklist" value="${checklistDetalhe}" scope="request" />

<%
    request.setAttribute("pageTitle", "Visualizar Checklist - LOG");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <jsp:include page="includes/header.jsp"/>
</head>

<body class="log-theme-body">
    <jsp:include page="includes/sidebar.jsp"/>

    <main class="main-content p-4">
        <h2 class="mb-4 text-white">👀 Visualização do Check-List (ID: ${checklist.id})</h2>
        <div class="log-card p-4 shadow-lg">
            
            <form> 
                
                <fieldset class="p-3 mb-4 border rounded border-primary-subtle" disabled>
                    <legend class="fw-bold p-1 w-auto fs-5 text-primary">1. Dados da Carga</legend>

                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">Remetente/Destinatário:</label>
                            <input type="text" class="form-control" value="${checklist.remetente}" readonly>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">NF / DI:</label>
                            <input type="text" class="form-control" value="${checklist.nfDi}" readonly>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Quantidade :</label>
                            <input type="text" class="form-control" value="${checklist.quantidade}" readonly>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Peso :</label>
                            <input type="text" class="form-control" value="${checklist.peso}" readonly>
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-2 text-info">Tipo de Produto:</h5>
                    <div class="row g-2">
                        <c:set var="tipos" value="${checklist.tiposProduto}"/>
                        
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${tipos.contains('Farmaceutico')}">checked</c:if>>
                            <label class="form-check-label">Farmacêutico</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${tipos.contains('Quimico')}">checked</c:if>>
                            <label class="form-check-label">Químico</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${tipos.contains('Perigoso')}">checked</c:if>>
                            <label class="form-check-label">Perigoso</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${tipos.contains('Correlato')}">checked</c:if>>
                            <label class="form-check-label">Correlato</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${tipos.contains('Improdutivo')}">checked</c:if>>
                            <label class="form-check-label">Improdutivo</label>
                        </div></div>
                        <div class="col-md-3">
                            <input type="text" class="form-control form-control-sm" value="${checklist.tipoProdutoOutro}" placeholder="Outros...">
                        </div>
                    </div>
                    
                    <h5 class="mt-4 mb-2 text-info">Tipo de Volume:</h5>
                    <div class="row g-2">
                        <c:set var="volumes" value="${checklist.tiposVolume}"/>
                        
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${volumes.contains('Palete')}">checked</c:if>>
                            <label class="form-check-label">Palete</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${volumes.contains('Caixa')}">checked</c:if>>
                            <label class="form-check-label">Caixa</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${volumes.contains('Sacaria')}">checked</c:if>>
                            <label class="form-check-label">Sacaria</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" <c:if test="${volumes.contains('Tambor')}">checked</c:if>>
                            <label class="form-check-label">Tambor</label>
                        </div></div>
                        <div class="col-md-3">
                            <input type="text" class="form-control form-control-sm" value="${checklist.tipoVolumeOutro}" placeholder="Outros...">
                        </div>
                    </div>

                    <h5 class="mt-4 mb-2 text-info">CT-e Emitido:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" <c:if test="${checklist.ctEmitido eq 'Sim'}">checked</c:if>>
                            <label class="form-check-label">Sim</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" <c:if test="${checklist.ctEmitido eq 'Nao'}">checked</c:if>>
                            <label class="form-check-label">Não</label>
                        </div></div>
                        <div class="col-md-4">
                            <input type="text" class="form-control form-control-sm" value="${checklist.ctNumero}" placeholder="Nº do CT-e">
                        </div>
                    </div>

                    <h5 class="mt-4 mb-2 text-info">Temperatura:</h5>
                    <div class="row g-2">
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" <c:if test="${checklist.temperatura eq 'Ambiente'}">checked</c:if>>
                            <label class="form-check-label">Ambiente</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" <c:if test="${checklist.temperatura eq '15 a 30°C'}">checked</c:if>>
                            <label class="form-check-label">15°C a 30°C</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" <c:if test="${checklist.temperatura eq '15 a 25°C'}">checked</c:if>>
                            <label class="form-check-label">15°C a 25°C</label>
                        </div></div>
                        <div class="col-auto"><div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" <c:if test="${checklist.temperatura eq '2 a 8°C'}">checked</c:if>>
                            <label class="form-check-label">2°C a 8°C</label>
                        </div></div>
                    </div>

                </fieldset>
                
                <div class="row g-4">
                    
                    <div class="col-md-6">
                        <fieldset class="p-3 border rounded h-100 border-warning-subtle" disabled>
                            <legend class="fw-bold p-1 w-auto fs-5 text-warning">2. Recebimento</legend>
                            
                            <h6 class="text-success">Data / Hora:</h6>
                            <input type="datetime-local" class="form-control mb-3" 
                                   value="<fmt:formatDate value="${checklist.recebimentoDataHora}" pattern="yyyy-MM-dd'T'HH:mm"/>" readonly>
                            
                            <h6 class="text-warning">Transporte:</h6>
                            <input type="text" class="form-control mb-2" value="${checklist.recebimentoTransportadora}" placeholder="Transportadora" readonly>
                            <input type="text" class="form-control mb-2" value="${checklist.recebimentoMotorista}" placeholder="Motorista" readonly>
                            <input type="text" class="form-control mb-3" value="${checklist.recebimentoPlaca}" placeholder="Placa do Veículo" readonly>

                            <h6 class="text-warning">Frota:</h6>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.recebimentoFrota eq 'Propria'}">checked</c:if>>
                                    <label class="form-check-label">Própria</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.recebimentoFrota eq 'Terceiro'}">checked</c:if>>
                                    <label class="form-check-label">Terceiro</label>
                                </div></div>
                            </div>

                            <h5 class="mt-3 text-danger">Descreva as Irregularidades (Rec.):</h5>
                            <textarea class="form-control mb-3" rows="3" readonly>${checklist.recIrregularidades}</textarea>

                            <h5 class="mt-3 text-success">Resultado da Inspeção (Rec.):</h5>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.recResultado eq 'Indicios'}">checked</c:if>>
                                    <label class="form-check-label">C/ Indícios de Irregularidade</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.recResultado eq 'SemIndicios'}">checked</c:if>>
                                    <label class="form-check-label">S/ Indícios de Irregularidade</label>
                                </div></div>
                            </div>
                            <input type="text" class="form-control" value="${checklist.recColaborador}" placeholder="Colaborador Responsável (assinatura)" readonly>

                        </fieldset>
                    </div>
                    
                    <div class="col-md-6">
                        <fieldset class="p-3 border rounded h-100 border-success-subtle" disabled>
                            <legend class="fw-bold p-1 w-auto fs-5 text-success">3. Expedição</legend>
                            
                            <h6 class="text-success">Data / Hora:</h6>
                            <input type="datetime-local" class="form-control mb-3" 
                                   value="<fmt:formatDate value="${checklist.expedicaoDataHora}" pattern="yyyy-MM-dd'T'HH:mm"/>" readonly>
                            
                            <h6 class="text-success">Transporte:</h6>
                            <input type="text" class="form-control mb-2" value="${checklist.expedicaoTransportadora}" placeholder="Transportadora" readonly>
                            <input type="text" class="form-control mb-2" value="${checklist.expedicaoMotorista}" placeholder="Motorista" readonly>
                            <input type="text" class="form-control mb-3" value="${checklist.expedicaoPlaca}" placeholder="Placa do Veículo" readonly>

                            <h6 class="text-success">Frota:</h6>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.expedicaoFrota eq 'Propria'}">checked</c:if>>
                                    <label class="form-check-label">Própria</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.expedicaoFrota eq 'Terceiro'}">checked</c:if>>
                                    <label class="form-check-label">Terceiro</label>
                                </div></div>
                            </div>

                            <h5 class="mt-3 text-danger">Descreva as Irregularidades (Exp.):</h5>
                            <textarea class="form-control mb-3" rows="3" readonly>${checklist.expIrregularidades}</textarea>

                            <h5 class="mt-3 text-success">Resultado da Inspeção (Exp.):</h5>
                            <div class="row g-2 mb-3">
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.expResultado eq 'Indicios'}">checked</c:if>>
                                    <label class="form-check-label">C/ Indícios de Irregularidade</label>
                                </div></div>
                                <div class="col-auto"><div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" <c:if test="${checklist.expResultado eq 'SemIndicios'}">checked</c:if>>
                                    <label class="form-check-label">S/ Indícios de Irregularidade</label>
                                </div></div>
                            </div>
                            <input type="text" class="form-control" value="${checklist.expColaborador}" placeholder="Colaborador Responsável (assinatura)" readonly>
                            
                        </fieldset>
                    </div>
                    
                </div>
                
                <div class="text-center mt-5 mb-5">
                    <a href="javascript:history.back()" class="btn btn-secondary btn-lg me-3">
                        <i class="bi bi-arrow-left-circle me-2"></i> Voltar
                    </a>
                    <button type="button" onclick="window.print()" class="btn btn-info btn-lg me-3">
                        <i class="bi bi-printer me-2"></i> Imprimir
                    </button>
                    
                    <%-- Botão para Alteração --%>
                    <a href="prepararEdicao?id=${checklist.id}" class="btn btn-warning btn-lg">
                        <i class="bi bi-pencil-square me-2"></i> Alterar
                    </a>
                </div>
                
            </form>
        </div>
    </main>
    
    <jsp:include page="includes/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>