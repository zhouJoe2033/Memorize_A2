//
//  Array+Identifiable.swift
//  Assignment_two
//
//  Created by Joe on 2020-07-23.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        return nil
    }
}
