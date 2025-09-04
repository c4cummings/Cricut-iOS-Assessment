//
//  StencilCutTests.swift
//  StencilCutTests
//
//  Created by Chad Cummings on 8/28/24.
//

import XCTest
@testable import StencilCut

final class StencilCutTests: XCTestCase {
    
    func testFetchShapes() async throws {
        // Arrange
        // Act
        // Assert
        
        let result = try await ShapesClient.fetchShapes(id: "001")
        
        XCTAssert(!result.isEmpty)
        
        let first = result.first
        XCTAssertNotNil(first?.drawPath)
    }

}
