//
//  StencilsClient.swift
//  StencilCut
//
//  Created by Chad Cummings on 8/28/24.
//

import Foundation
import os

/// Uses the ShapesApi to return data models
struct ShapesClient {
    enum ShapesClientError: LocalizedError {
        case networkError(Error)
        case decodingError(Error)
        case invalidResponse
        case noData

        var errorDescription: String? {
            switch self {
                case .networkError(let error): return "Network error: \(error.localizedDescription)"
                case .decodingError(let error): return "Decoding error: \(error.localizedDescription)"
                case .invalidResponse: return "Invalid response"
                case .noData: return "No data received"
            }
        }
    }

    static func fetchShapes(id: String) async throws -> [ShapeModel] {
        let (data, response): (Data, URLResponse)

        do {
            (data, response) = try await URLSession.shared.data(from: ShapesApi.shapes(id).url)
        } catch {
            print(error)
            throw ShapesClientError.networkError(error)
        }

        guard data.isEmpty == false else {
            throw ShapesClientError.noData
        }

        guard let response = response as? HTTPURLResponse else {
            throw ShapesClientError.invalidResponse
        }

        if !response.isStatusOK() {
            throw ShapesClientError.networkError(NSError(domain: "StencilCut", code: response.statusCode, userInfo: nil))
        }

        do {
            let dto = try JSONDecoder().decode(ButtonsDTO.self, from: data)
            return dto.buttons.map { button in
                ShapeModel(name: button.name, drawPath: button.drawPath)
            }
        } catch {
            print(error)
            throw ShapesClientError.decodingError(error)
        }
    }
}

extension HTTPURLResponse {
    func isStatusOK() -> Bool {
        return (200...299).contains(self.statusCode)
    }
    
    func isForwarding() -> Bool {
        return (300...399).contains(self.statusCode)
    }

    func isClientError() -> Bool {
        return (400...499).contains(self.statusCode)
    }

    func isServerError() -> Bool {
        return(500...599).contains(self.statusCode)
    }
}
