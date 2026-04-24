# 📘 Documentação Técnica Detalhada - YouTube Browser

Este documento descreve a arquitetura, lógica de funcionamento e especificações técnicas do projeto **YouTube Browser**.

---

## 🏗️ 1. Arquitetura do Sistema

O app segue o padrão declarativo do **SwiftUI**, utilizando uma arquitetura baseada em estados para gerenciar a navegação sem a necessidade de controladores de visualização complexos.

### 🧩 Componentes Principais:
*   **ContentView.swift**: O orquestrador da interface. Gerencia a lógica de troca de telas e entrada de dados.
*   **WebView.swift**: Ponte entre o framework `WebKit` (imperativo) e o `SwiftUI` (declarativo), utilizando `NSViewRepresentable`.

---

## ⚙️ 2. Gerenciamento de Estados (@State)

A reatividade do app é controlada por três variáveis principais:
1.  `searchText`: Armazena o termo bruto digitado.
2.  `isSearching`: Define o estado da UI. `false` renderiza a **VStack de Busca**; `true` renderiza o **WebView**.
3.  `currentURL`: Objeto `URL` opcional que alimenta o navegador após o processamento.

---

## 🛣️ 3. Lógica de Navegação e Fluxo de Dados

Diferente de apps que usam `NavigationStack` (exclusivo para macOS 13+), este projeto utiliza um **ZStack Condicional** para garantir compatibilidade com o **macOS 12 (Monterey)**.

### Fluxo da Função `startSearch()`:
1.  **Sanitização**: O texto passa por `.trimmingCharacters(in: .whitespaces)` para evitar buscas vazias.
2.  **Percent Encoding**: Utiliza `.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)` para converter caracteres especiais (ex: `ç`, `ã`, espaços) em códigos hexadecimais válidos para URLs.
3.  **Transição**: A variável `isSearching` é alterada dentro de um bloco `withAnimation(.spring())`, criando um efeito de transição suave entre a Home e os resultados.

---

## 🛠️ 4. Especificações de Ambiente (Build)

*   **IDE**: Xcode 14.x
*   **Deployment Target**: macOS 12.0+
*   **SDK**: macOS SDK 13.x (compatível com runtime 12.x)
*   **Language**: Swift 5.7

---

## 🐞 5. Guia de Solução de Problemas (Troubleshooting)

### Erros de Log no Console (XPC Connection)
É comum visualizar erros como `[client] XPC message reply connection invalidated`. 
*   **Causa**: O `WKWebView` roda em um processo separado. O sistema operacional emite esses logs ao gerenciar a memória desses processos.
*   **Solução**: Se o app não travar, ignore. Para limpar o console, adicione `OS_ACTIVITY_MODE = disable` nas variáveis de ambiente do esquema de execução (**Edit Scheme**).

### Permissões de Sandbox
Se a página do YouTube não carregar ou exibir erro de conexão:
*   Verifique se o **App Sandbox** está ativo.
*   Certifique-se de que a permissão **Outgoing Connections (Client)** está marcada. Sem isso, o processo XPC de rede será bloqueado pelo kernel do macOS.

---

## 🎨 6. Design System e Interface

*   **Efeitos Visuais**: Uso de `LinearGradient` para bordas de campos de texto e `shadow` com opacidade para profundidade.
*   **Tipografia**: Fontes com design `.rounded` para uma aparência amigável e moderna.
*   **Toolbar**: Implementação de `ToolbarItem` com posicionamento `.principal` para centralização de títulos customizados.

---

## 📅 7. Histórico e Propriedade
*   **Desenvolvedor**: Daniel dos santos Araújo
*   **Versão do Documento**: 1.0
*   **Última Atualização**: 24 de Abril de 2026


