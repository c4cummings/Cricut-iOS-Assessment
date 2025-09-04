//
//  ShapeView.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/31/24.
//

import SwiftUI
import SwiftData

struct StencilView: View {
    var stencil: StencilModel

    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = min(geometry.size.width, geometry.size.height)
            let height = width
            
            switch stencil.shape {
                case "circle": Circle()
                        .fill(.teal)
                        .frame(width: width, height: height)
                case "square": Rectangle()
                        .fill(.teal)
                        .frame(width: width, height: height)
                case "triangle": Stencils.Triangle()
                        .fill(.teal)
                        .frame(width: width, height: height)
                default: Text("Unknown")
                        .frame(width: width, height: height)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StencilModel.self, configurations: config)
    
    return StencilView(stencil: StencilModel(shape: "circle"))
        .modelContainer(container)
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StencilModel.self, configurations: config)
    
    return StencilView(stencil: StencilModel(shape: "square"))
        .modelContainer(container)
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StencilModel.self, configurations: config)
    
    return StencilView(stencil: StencilModel(shape: "triangle"))
        .modelContainer(container)
}
