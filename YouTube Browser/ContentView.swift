//
//  ContentView.swift
//  YouTube Browser
//
//  Created by Daniel dos santos Araújo on 4/23/26.
//

import SwiftUI

/// Estrutura principal da interface do usuário.
struct ContentView: View {
    
    // MARK: - Propriedades de Estado
    
    /// Armazena o texto digitado pelo usuário no campo de busca.
    @State private var searchText = ""
    
    /// Controla a alternância entre a tela de início (false) e o navegador (true).
    @State private var isSearching = false
    
    /// Armazena a URL formatada e pronta para ser carregada no WebView.
    @State private var currentURL: URL? = nil
    
    // MARK: - Interface Principal
    
    var body: some View {
        // O ZStack permite sobrepor as telas no mesmo espaço da janela.
        ZStack {
            
            // Verificação lógica: Se estiver buscando e a URL for válida, mostra o navegador.
            if isSearching, let url = currentURL {
                
                // TELA 2: O Navegador (Exibição do Conteúdo Web)
                WebView(url: url)
                    .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
                    .toolbar {
                        // Botão para retornar à tela inicial, resetando os estados.
                        ToolbarItem(placement: .navigation) {
                            Button(action: {
                                isSearching = false
                                searchText = ""
                            }) {
                                HStack {
                                    Image(systemName: "house.fill")
                                    Text("Início")
                                }
                            }
                        }
                        // Título dinâmico que muda conforme o termo buscado.
                        customToolbarTitle(title: searchText.isEmpty ? "YouTube" : "Busca: \(searchText)")
                    }
                
            } else {
                
                // TELA 1: Portal de Início (Interface de Boas-vindas e Busca)
                VStack(spacing: 35) {
                    Spacer()
                    
                    // Elemento Visual: Ícone do YouTube estilizado com SFSymbols e sombra.
                    Image(systemName: "play.rectangle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .foregroundColor(.red)
                        .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    // Textos de apresentação do aplicativo.
                    VStack(spacing: 8) {
                        Text("YouTube Browser")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                        
                        Text("Sua janela dedicada para vídeos")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    
                    // MARK: - Campo de Busca Estilizado
                    TextField("O que vamos assistir hoje?", text: $searchText)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .textFieldStyle(.plain)
                        .padding(.vertical, 14)
                        .padding(.leading, 45) // Espaçamento para o ícone da lupa
                        .padding(.trailing, 14)
                        .background(
                            // Fundo que se adapta ao sistema (Claro/Escuro) com bordas arredondadas.
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(NSColor.controlBackgroundColor))
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                        )
                        .overlay(
                            // Borda decorativa com gradiente sutil.
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(LinearGradient(colors: [.red.opacity(0.5), .clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                        )
                        .overlay(
                            // Ícone de lupa posicionado visualmente dentro do TextField.
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.red)
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.leading, 15)
                                Spacer()
                            }
                        )
                        .frame(width: 520)
                        // Dispara a lógica de busca ao pressionar a tecla Enter.
                        .onSubmit { startSearch() }
                    
                    // Indicador visual de comando de teclado.
                    HStack(spacing: 4) {
                        Image(systemName: "keyboard")
                        Text("Pressione Enter para buscar")
                    }
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.secondary.opacity(0.7))
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .frame(width: 650, height: 450)
                .toolbar {
                    // Título padrão da janela inicial.
                    customToolbarTitle(title: "YouTube Browser")
                }
            }
        }
    }
    
    // MARK: - Funções Auxiliares
    
    /// Cria um componente de título estilizado para a Toolbar do macOS.
    /// - Parameter title: O texto a ser exibido no título.
    func customToolbarTitle(title: String) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            HStack(spacing: 8) {
                Image(systemName: "play.tv.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 13, weight: .bold))
                
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Capsule().fill(Color.primary.opacity(0.06)))
        }
    }
    
    /// Lógica que processa o texto, gera a URL do YouTube e ativa a navegação.
    func startSearch() {
        // Remove espaços extras antes e depois do texto.
        let cleaned = searchText.trimmingCharacters(in: .whitespaces)
        
        if !cleaned.isEmpty {
            // Codifica o texto para o formato de URL (ex: transforma espaços em %20).
            if let encoded = cleaned.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let urlString = "https://www.youtube.com/results?search_query=\(encoded)"
                
                // Converte a string final em um objeto URL válido.
                if let newURL = URL(string: urlString) {
                    self.currentURL = newURL
                    // Ativa a tela do navegador com uma animação de mola (Spring).
                    withAnimation(.spring()) {
                        self.isSearching = true
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
