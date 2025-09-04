//
//  StencilsHomeScreen.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/28/24.
//

import Foundation
import SwiftData
import SwiftUI

struct StencilsHomeScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var stencils: [StencilModel]

    @State private var viewModel: ViewModel

    init(viewModel: ViewModel = .init()) {
        self.viewModel = viewModel
    }

    private var columns = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(stencils, id: \.self) { stencil in
                        StencilView(stencil: stencil)
                            .scaledToFill()
                            .onTapGesture {
                                viewModel.selectedStencil = stencil
                            }
                            .accessibilityAddTraits(.isButton)
                    }
                }
                .navigationDestination(item: $viewModel.selectedStencil) { stencil in
                    StencilDetailScreen(stencil: stencil)
                }
                .accessibilityLabel("Grid of stencil shapes")
                .accessibilityHint("Tap an item to see stencil details")
            }
            .overlay {
                if stencils.isEmpty {
                    Text("Add Stencil Shapes to Begin")
                        .accessibilityLabel("Add to begin")
                }
            }
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear All", role: .destructive, action: clearAll)
                        .disabled(stencils.isEmpty)
                        .accessibilityLabel("Clear all stencils")
                        .accessibilityHint("Tap to clear all stencils")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        StencilsEditScreen(shapeFilter: "circle")
                    } label: {
                        Text("Edit Circles")
                            .accessibilityLabel("Edit Circles")
                            .accessibilityHint("Tap to edit all circle stencils")
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    if viewModel.isLoading || viewModel.shapes.isEmpty {
                        ProgressView()
                    } else {
                        HStack {
                            ForEach(viewModel.shapes, id: \.self) { shape in
                                Spacer()
                                Button(shape.name) {
                                    addStencil(drawPath: shape.drawPath)
                                }
                                .accessibilityLabel("Shape \(shape.name)")
                                .accessibilityHint(String(localized: "Tap to add a \(shape.name) stencil"))
                                Spacer()
                            }
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.loadShapes()
            }
            .task {
                if viewModel.shapes.isEmpty {
                    await viewModel.loadShapes()
                }
            }
        }
    }

    private func clearAll() {
        for stencil in stencils {
            modelContext.delete(stencil)
        }
    }

    private func addStencil(drawPath: String) {
        modelContext.insert(StencilModel(shape: drawPath))
    }
}

extension StencilsHomeScreen {
    @Observable
    @MainActor
    class ViewModel {
        var shapes: [ShapeModel]

        var selectedStencil: StencilModel?

        var isLoading: Bool = false

        init(shapes: [ShapeModel] = []) {
            self.shapes = shapes
        }

        func loadShapes() async {
            isLoading = true
            defer { isLoading = false }
            do {
                // Debug for progress view when slow internet
                //try await Task.sleep(for: .seconds(10))
                shapes = try await ShapesClient.fetchShapes(id: "001")
            } catch {
                print("Failed to fetch shapes: \(error)")
                shapes = []
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: StencilModel.self, configurations: config)
    
    return StencilsHomeScreen()
    .modelContainer(container)
}
