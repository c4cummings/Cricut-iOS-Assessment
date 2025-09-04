//
//  ShapesEditScreen.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/31/24.
//

import SwiftData
import SwiftUI

struct StencilsEditScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var stencils: [StencilModel]

    @State var shapeFilter: String
    
    @State private var selectedStencil: StencilModel?
    
    private var filteredStencils: [StencilModel] {
        return stencils.filter { stencil in
            stencil.shape == shapeFilter
        }
    }
    
    private var isContentEmpty: Bool {
        get {
            filteredStencils.isEmpty
        }
    }
    
    init(
        shapeFilter: String
    ) {
        self.shapeFilter = shapeFilter
    }
    
    private var columns = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredStencils) { stencil in
                        StencilView(stencil: stencil)
                            .scaledToFill()
                            .onTapGesture {
                                selectedStencil = stencil
                            }
                    }
                }
                .navigationDestination(item: $selectedStencil) { stencil in
                    StencilDetailScreen(stencil: stencil)
                }
            }
            .padding(.horizontal, 16)
            .overlay {
                if filteredStencils.isEmpty {
                    Text("No \(shapeFilter) stencils found")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Delete All", action: deleteAll)
                        .disabled(isContentEmpty)
                    Spacer()
                    Button("Add", action: add)
                        .disabled(isContentEmpty)
                    Spacer()
                    Button("Remove", action: deleteLast)
                        .disabled(isContentEmpty)
                }
            }
            .navigationTitle("Edit")
        }
    }
    
    private func deleteAll() {
        for stencil in filteredStencils {
            modelContext.delete(stencil)
        }
    }
    
    private func add() {
        modelContext.insert(StencilModel(shape: "circle"))
    }
    
    func deleteLast() {
        guard let last = filteredStencils.last else {
            return
        }
        modelContext.delete(last)
    }
}

#Preview {
    StencilsEditScreen(shapeFilter: "circle")
}
