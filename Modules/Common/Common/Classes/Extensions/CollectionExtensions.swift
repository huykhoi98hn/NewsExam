//
//  CollectionExtensions.swift
//  Common
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
