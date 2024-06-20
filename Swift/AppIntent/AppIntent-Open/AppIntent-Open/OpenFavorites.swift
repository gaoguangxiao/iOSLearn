//
//  OpenFavorites.swift
//  AppIntent-Open
//
//  Created by 高广校 on 2024/6/19.
//

import Foundation
import AppIntents

struct OpenFavoritesIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Open Favorite Trails"
    
    
    static var description = IntentDescription("Opens the app and goes to your favorite trails.")
    
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        //            navigationModel.selectedCollection = trailManager.favoritesCollection
//        Navigator.shared.openShelf(.currentlyReading)
        return .result()
    }
}

struct FavoritesIntent: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: OpenFavoritesIntent(), phrases: [
            "Open Favorites in \(.applicationName)",
            "Show my favorite \(.applicationName)"
        ],
        shortTitle: "Open Favorites",
        systemImageName: "star.circle")
    }
}
