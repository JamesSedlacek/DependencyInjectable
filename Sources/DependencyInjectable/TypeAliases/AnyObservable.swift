//
//  AnyObservable.swift
//
//  Created by James Sedlacek on 3/6/24.
//

import Foundation

/// Type-erased wrapper for `Observable` objects in SwiftUI.
///
/// This typealias facilitates working with observable objects in a type-agnostic way,
/// allowing the dependency injection system to handle objects conforming to the `Observable`
/// protocol without knowing their concrete types. It enhances the flexibility and scalability
/// of the dependency injection framework within SwiftUI applications.
@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
public typealias AnyObservable = AnyObject & Observable
