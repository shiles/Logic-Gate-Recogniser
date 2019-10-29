//
//  Array+Extensions.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 28/10/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation

extension Array {
    
    func split() -> (left: [Element], right: [Element]) {
        let max = self.count
        let half = max / 2
        //Adding one for an overlap to reduce gaps that may occure between lines
        return (left: Array(self[0 ..< half+1]), right: Array(self[half ..< max]))
    }
}
