//
//  WebView.swift
//  YouTube Browser
//
//  Created by Daniel dos santos Araújo on 4/23/26.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let url: URL
    
    // Cria o visualizador web do macOS
    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsAirPlayForMediaPlayback = true
        
        // Isso ajuda o sistema a priorizar a performance do vídeo
        let webView = WKWebView(frame: .zero, configuration: config)
        
        // Opcional: Melhora a experiência de navegação no Mac
        webView.allowsBackForwardNavigationGestures = true
        
        // --- HABILITA O ZOOM PELO TRACKPAD (Pinch) ---
        webView.allowsMagnification = true
        webView.allowsBackForwardNavigationGestures = true
        
        return webView
    }

    
    // Atualiza o site quando a URL mudar
    func updateNSView(_ nsView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        nsView.load(request)
    }
}

