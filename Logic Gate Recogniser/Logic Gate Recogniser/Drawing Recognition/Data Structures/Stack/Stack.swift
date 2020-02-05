//
//  Stack.swift
//  Logic Gate Recogniser
//
//  Created by Sonnie Hiles on 06/11/2019.
//  Copyright © 2019 Sonnie Hiles. All rights reserved.
//

import Foundation

struct Stack<Element> {
    
    private var elements: [Element] = []
    
    ///Pushes a new element onto the stack
    ///- Parameter item: Item to push onto the stack
    mutating func push(_ item: Element) {
        elements.append(item)
    }
    
    ///Pops the top element from the stack
    ///- Returns: Top element from the stack
    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

extension Stack {
    
    ///Initialise the stack with an initial ordered list of items
    ///- Parameter items: Elements to add to stack
    init(items: [Element]) {
        elements = items
    }
    
    ///The item currently on the top of the stack
    var topItem: Element? {
        return elements.isEmpty ? nil : elements[elements.count-1]
    }
    
    ///The item under the top of the stack
    var sndItem: Element? {
        return elements.count < 2 ? nil : elements[elements.count-2]
    }
    
    ///Returns the stack as a list, with the bottom most item first
    ///- Returns: Stack as a list
    func asList() -> [Element] { elements }
}
