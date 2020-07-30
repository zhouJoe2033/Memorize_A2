//
//  Array+Only.swift
//  Assignment_two
//
//  Created by Joe on 2020-07-23.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
