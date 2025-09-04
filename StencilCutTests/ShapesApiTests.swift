//
//  ShapesApiTests.swift
//  StencilCutTests
//
//  Created by Chad Cummings on 9/9/24.
//

import XCTest
@testable import StencilCut

final class ShapesApiTests: XCTestCase {
    
    func testShapesApi() throws {
        // Arrange
        // Act
        // Assert
        
        let pathId = "🥸0%$^$##"
        
        let lastComponent = ShapesApi.shapes(pathId).url.lastPathComponent
        
        XCTAssert(lastComponent.contains(pathId))
    }
    
    func testStylesApi() throws {
        // Arrange
        // Act
        // Assert
        
        let pathId = "🥸0%$^$##"
        
        let lastComponent = ShapesApi.styles(pathId).url.lastPathComponent
        
        XCTAssert(lastComponent.contains(pathId))
    }
}
