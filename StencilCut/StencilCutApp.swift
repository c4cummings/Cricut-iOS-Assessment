//
//  StencilCutApp.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/28/24.
//

import SwiftData
import SwiftUI

@main
struct StencilCutApp: App {
    var body: some Scene {
        WindowGroup {
            StencilsHomeScreen()
        }
        .modelContainer(for: [StencilModel.self])
    }
}
