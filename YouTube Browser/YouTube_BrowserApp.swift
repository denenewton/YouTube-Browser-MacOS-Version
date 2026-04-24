//
//  YouTube_BrowserApp.swift
//  YouTube Browser
//
//  Created by Daniel dos santos Araújo on 4/23/26.
//

import SwiftUI

@main
struct YouTube_BrowserApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Isso esconde o título mas mantém os botões de fechar
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified(showsTitle: true))
    }
}
