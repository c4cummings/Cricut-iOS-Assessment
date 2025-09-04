//
//  ShapeDTO.swift
//  StencilCut
//
//  Created by Chad Cummings on 9/2/24.
//

import Foundation

struct ButtonsDTO {
    let buttons: [ShapeDTO]
}

extension ButtonsDTO: Decodable {
    enum CodingKeys: CodingKey {
        case buttons
    }
}

struct ShapeDTO {
    let name: String
    let drawPath: String
}

extension ShapeDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}
