//
//  AnyObservableObject.swift
//
//  Created by James Sedlacek on 3/9/24.
//

import Foundation

/// Type-erased wrapper for `ObservableObject` instances in SwiftUI.
///
/// Similar to `AnyObservable`, this typealias allows for the handling of `ObservableObject`
/// instances in a type-agnostic manner. It is crucial for enabling the dependency injection
/// system to work with various observable objects, thus supporting a wide range of use cases
/// and enhancing the modularity of SwiftUI applications.
public typealias AnyObservableObject = AnyObject & ObservableObject
