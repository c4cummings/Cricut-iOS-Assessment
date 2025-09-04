//
//  StencilDetailScreen.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/31/24.
//

import SwiftData
import SwiftUI

struct StencilDetailScreen: View {
    let stencil: StencilModel
    
    var body: some View {
        NavigationStack {
            VStack {
                StencilView(stencil: stencil)
            }
            .navigationTitle(stencil.shape)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StencilModel.self, configurations: config)
    
    return StencilDetailScreen(stencil: StencilModel(shape: "triangle"))
        .modelContainer(container)
}
