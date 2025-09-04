//
//  Stencil.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/31/24.
//

import SwiftData
import Foundation

@Model
final class StencilModel {
    private(set) var id: UUID = UUID()
    private(set) var shape: String

    init(shape: String) {
        self.shape = shape
    }
}

extension StencilModel: Identifiable, Hashable {}
