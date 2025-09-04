//
//  Shape.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/28/24.
//

import Foundation

struct ShapeModel {
    var id = UUID()
    var name: String
    var drawPath: String

    init(name: String, drawPath: String) {
        self.name = name
        self.drawPath = drawPath
    }
}

extension ShapeModel: Identifiable, Hashable {}
