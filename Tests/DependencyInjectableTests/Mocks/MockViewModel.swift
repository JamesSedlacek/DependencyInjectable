//
//  MockViewModel.swift
//
//
//  Created by James Sedlacek on 3/7/24.
//

import DependencyInjectable
import SwiftUI

@Observable
final class MockViewModel {
    var service: MockServiceable?

    var someProperty: String {
        service?.someProperty ?? "default mock value"
    }

    package init() {}
}

extension MockViewModel: DependencyInjectable {
    func onInject(dependencies: DependencyValues) {
        service = dependencies.mockService
    }
}
