//
//  MockService.swift
//  
//
//  Created by James Sedlacek on 3/7/24.
//

import DependencyInjectable
import Foundation

protocol MockServiceable {
    var someProperty: String { get }
}

struct MockService: MockServiceable {
    let someProperty: String

    init(_ s: String = "Default Mock Value") {
        someProperty = s
    }
}

struct MockServiceKey: DependencyKey {
    static var defaultValue: MockServiceable = MockService()
}

extension DependencyValues {
    var mockService: MockServiceable {
        get { self[MockServiceKey.self] }
        set { self[MockServiceKey.self] = newValue }
    }
}
