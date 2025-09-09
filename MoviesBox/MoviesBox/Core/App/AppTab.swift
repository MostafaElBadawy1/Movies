//
//  AppTab.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 08/09/2025.
//

import SwiftUI

// MARK: - Routing
enum AppTab: Hashable {
    case home, favorites
}

enum Route: Hashable {
    case details(movieId: Int)
}


final class Router: ObservableObject {
    @Published var selectedTab: AppTab = .home
    @Published var homePath = NavigationPath()
    @Published var favoritesPath = NavigationPath()
    
    // Push route on the current (or provided) tab
    func push(_ route: Route, on tab: AppTab? = nil) {
        let tabToUse = tab ?? selectedTab
        switch tabToUse {
            case .home: homePath.append(route)
            case .favorites: favoritesPath.append(route)
        }
    }
    
    
    func pop(on tab: AppTab? = nil) {
        let tabToUse = tab ?? selectedTab
        switch tabToUse {
            case .home: if !homePath.isEmpty { homePath.removeLast() }
            case .favorites: if !favoritesPath.isEmpty { favoritesPath.removeLast() }
        }
    }
    
    
    func popToRoot(on tab: AppTab? = nil) {
        let tabToUse = tab ?? selectedTab
        switch tabToUse {
            case .home: homePath = .init()
            case .favorites: favoritesPath = .init()
        }
    }
}
