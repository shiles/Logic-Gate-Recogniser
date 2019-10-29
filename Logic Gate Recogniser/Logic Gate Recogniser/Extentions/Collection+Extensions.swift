//
//  Collection+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 29/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
