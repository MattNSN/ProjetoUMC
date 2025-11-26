/**
 * LOG - Soluções Rápidas
 * Scripts JavaScript para funcionalidades do sistema
 * Versão 1.1 - Validação de Placa removida (usando validação nativa HTML5)
 */

// Função para habilitar/desabilitar inputs com checkbox N/A
function toggleInput(inputId, disable) {
    const input = document.getElementById(inputId);
    if (input) {
        input.disabled = disable;
        if (disable) {
            input.value = '';
        }
    }
}

// Função para imprimir o formulário
function imprimirFormulario() {
    window.print();
}

// Validação do formulário de checklist
document.addEventListener('DOMContentLoaded', function() {
    // É recomendado adicionar o id="checklistForm" na sua tag <form> no JSP.
    const checklistForm = document.querySelector('form[action="salvarChecklist"]'); 
    
    if (checklistForm) {
        checklistForm.addEventListener('submit', function(e) {
            // Se o navegador detectar um erro de 'pattern' (placa) ou 'required',
            // ele deve bloquear o submit ANTES deste código ser executado.
            
            // Validações customizadas (Remetente e NF/DI)
            const remetente = this.querySelector('input[name="remetente"]').value;
            const nfDi = this.querySelector('input[name="nfDi"]').value;

            if (!remetente || remetente.trim() === '') {
                e.preventDefault();
                alert('Por favor, informe o Remetente/Destinatário');
                return;
            }
            
            if (!nfDi || nfDi.trim() === '') {
                e.preventDefault();
                alert('Por favor, informe a NF / DI');
                return;
            }
            
            // Se chegou até aqui, os campos obrigatórios estão OK e o HTML5
            // já validou os padrões (Placa, etc.).
            
            // *ATENÇÃO*: Como a lógica de persistência é feita via Servlet,
            // vamos APENAS remover o 'e.preventDefault()' e deixar o formulário
            // seguir para o 'salvarChecklist'.
            
            // e.preventDefault(); // Comente ou remova esta linha!
            
            // Nota: Se você mantiver o alert de sucesso aqui, ele será exibido
            // ANTES da submissão para a Servlet. É melhor o sucesso ser exibido
            // pela Servlet (como implementamos antes).

            // Código de teste (REMOVER EM PRODUÇÃO)
            // alert('Formulário VALIDADO e enviado para a Servlet!'); 
            
        });
    }
    
    // Listener para radio buttons de temperatura
    const tempRadios = document.querySelectorAll('input[name="temperatura"]');
    const temperaturaOutro = document.querySelector('input[name="temperaturaOutro"]');

    tempRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            if (temperaturaOutro) {
                // A tag 'outros' precisa ter o 'value="Outras"' para ser detectada aqui, 
                // ou apenas usar o 'name="temperaturaOutro"'
                temperaturaOutro.disabled = this.value !== 'Outras';
                if (this.value !== 'Outras') {
                    temperaturaOutro.value = '';
                }
            }
        });
    });
    
    // Adicionar comportamento responsivo para sidebar em mobile (MANTIDO)
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    
    if (sidebar && window.innerWidth <= 768) {
        // Adicionar lógica para menu mobile se necessário
    }
});

// Função para formatar data para exibição (MANTIDO)
function formatarData(data) {
    const d = new Date(data);
    const dia = String(d.getDate()).padStart(2, '0');
    const mes = String(d.getMonth() + 1).padStart(2, '0');
    const ano = d.getFullYear();
    const hora = String(d.getHours()).padStart(2, '0');
    const minuto = String(d.getMinutes()).padStart(2, '0');
    
    return `${dia}/${mes}/${ano} ${hora}:${minuto}`;
}

// Função para busca dinâmica (MANTIDO)
function buscarRegistros() {
    const termo = document.querySelector('input[placeholder*="buscar"]');
    if (termo && termo.value.trim() !== '') {
        console.log('Buscando por: ' + termo.value);
        // Implementar lógica de busca aqui
    }
}

// Função para confirmar ações (MANTIDO)
function confirmarAcao(mensagem) {
    return confirm(mensagem);
}

// Função para destacar campos obrigatórios vazios (MANTIDO)
function validarCamposObrigatorios(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;
    
    const camposObrigatorios = form.querySelectorAll('[required]');
    let valid = true;
    
    camposObrigatorios.forEach(campo => {
        if (!campo.value || campo.value.trim() === '') {
            campo.classList.add('is-invalid');
            valid = false;
        } else {
            campo.classList.remove('is-invalid');
        }
    });
    
    return valid;
}

// Função para limpar formulário (MANTIDO)
function limparFormulario(formId) {
    const form = document.getElementById(formId);
    if (form && confirmarAcao('Deseja realmente limpar todos os campos?')) {
        form.reset();
        // Resetar campos desabilitados
        const inputs = form.querySelectorAll('input[type="text"], input[type="date"], input[type="datetime-local"], textarea');
        inputs.forEach(input => {
            input.disabled = false;
        });
    }
}

// Auto-save do formulário (opcional - MANTIDO)
function autoSaveFormulario(formId) {
    const form = document.getElementById(formId);
    if (!form) return;
    
    const inputs = form.querySelectorAll('input, textarea, select');
    
    inputs.forEach(input => {
        input.addEventListener('change', function() {
            const key = `autosave_${formId}_${this.name}`;
            localStorage.setItem(key, this.value);
            console.log('Auto-save: ' + this.name);
        });
    });
}

// Restaurar formulário do localStorage (MANTIDO)
function restaurarFormulario(formId) {
    const form = document.getElementById(formId);
    if (!form) return;
    
    const inputs = form.querySelectorAll('input, textarea, select');
    
    inputs.forEach(input => {
        const key = `autosave_${formId}_${input.name}`;
        const savedValue = localStorage.getItem(key);
        
        if (savedValue) {
            input.value = savedValue;
        }
    });
}

// Limpar auto-save (MANTIDO)
function limparAutoSave(formId) {
    const keys = Object.keys(localStorage);
    keys.forEach(key => {
        if (key.startsWith(`autosave_${formId}_`)) {
            localStorage.removeItem(key);
        }
    });
}


// Tooltip customizado (MANTIDO)
function inicializarTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// Inicializar tooltips quando o DOM estiver pronto (MANTIDO)
document.addEventListener('DOMContentLoaded', inicializarTooltips);

// Exportar funções para uso global (MANTIDO)
window.toggleInput = toggleInput;
window.imprimirFormulario = imprimirFormulario;
window.buscarRegistros = buscarRegistros;
window.confirmarAcao = confirmarAcao;
window.limparFormulario = limparFormulario;
window.formatarData = formatarData;