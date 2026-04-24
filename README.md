#  # 📺 YouTube Browser

Um navegador minimalista e dedicado para YouTube, desenvolvido nativamente para macOS utilizando **SwiftUI**.

---

## 📝 Descrição do Projeto
O **YouTube Browser** é uma aplicação desktop projetada para oferecer uma experiência de visualização limpa e direta. Ele remove a complexidade de um navegador comum, focando exclusivamente na busca e reprodução de conteúdos do YouTube diretamente em uma janela dedicada.

## ✨ Funcionalidades Principais
*   **Interface Dual-State**: Alterna de forma fluida entre um portal de busca estilizado e o navegador de vídeos.
*   **Busca Inteligente**: Processamento de texto com suporte a caracteres especiais e espaços via URL Encoding.
*   **Experiência Nativa**: UI construída com componentes Apple, garantindo performance e baixo consumo de recursos.
*   **Compatibilidade**: Desenvolvido para funcionar perfeitamente a partir do macOS 12 Monterey.

---

## 🛠️ Detalhes da Implementação

### 1. Gerenciamento de Fluxo
O arquivo principal `ContentView.swift` utiliza `@State` para controlar a interface de forma reativa:
- `searchText`: Captura a entrada do usuário em tempo real.
- `isSearching`: Gatilho booleano que alterna entre a Home e o Webview.
- `currentURL`: Armazena o objeto URL devidamente formatado para o YouTube.

### 2. Tratamento de URLs
O app garante que termos de busca com espaços ou símbolos não quebrem o sistema:
```swift
if let encoded = cleaned.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
    let urlString = "https://youtube.com\(encoded)"
}
```

### 3. Interface e Estilo (SwiftUI)
- **Barra de Ferramentas**: Título dinâmico e botão de retorno encapsulados em uma `Toolbar`.
- **Design System**: Uso de fontes arredondadas, sombras (`shadow`) e bordas com gradiente para um visual moderno.
- **Animações**: Transições suaves entre telas utilizando o modificador `withAnimation(.spring())`.

---

## 🚀 Requisitos e Configuração

### Ambientes de Desenvolvimento
*   **IDE:** Xcode 14.x
*   **Sistema Operacional:** macOS 12.0 (Monterey) ou superior
*   **Linguagem:** Swift 5.7+

### Configuração de Segurança (Importante)
Para que o navegador consiga carregar o site do YouTube, é obrigatório habilitar o acesso à internet:
1.  No Xcode, selecione o ícone azul do projeto no topo da barra lateral.
2.  Clique no Target **YouTube Browser**.
3.  Vá na aba **Signing & Capabilities**.
4.  Localize a seção **App Sandbox**.
5.  Ative a permissão **Outgoing Connections (Client)**.

---

## 📂 Estrutura do Código
- `ContentView.swift`: Gerencia a lógica principal e a interface visual.
- `WebView.swift`: Componente que integra o `WKWebView` (WebKit) ao SwiftUI.

---

## ✍️ Créditos
*   **Desenvolvedor:** Daniel dos santos Araújo
*   **Data de Criação:** Abril de 2026

---
*Nota: Este projeto é uma ferramenta de produtividade pessoal desenvolvida em ambiente de estudo.*

