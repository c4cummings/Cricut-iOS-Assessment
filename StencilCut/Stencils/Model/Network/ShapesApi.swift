//
//  ShapesApi.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/31/24.
//

import Foundation

protocol Api {
    /// Describes the base url of an Api.
    static var baseUrl: URL { get }
}
/// http://staticcontent.cricut.com/static/test/shapes_001.json
enum ShapesApi: RawRepresentable, Api {
    static let baseUrl: URL = URL(string: "https://staticcontent.cricut.com/static/test/")!
    
    var rawValue: String {
        switch self {
            case .shapes(let id): return "shapes_\(id).json"
            case .styles(let id): return "styled_shapes_\(id).json"
        }
    }

    case shapes(_ id: String)
    case styles(_ id: String)
}

extension RawRepresentable where RawValue == String, Self: Api {
    var url: URL { Self.baseUrl.appendingPathComponent(rawValue, conformingTo: .url) }

    init?(rawValue: String) {
        nil
    }
}
