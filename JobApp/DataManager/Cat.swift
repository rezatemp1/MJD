//
//  Cat.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import Foundation


public typealias Data = [String: Any]

public protocol Model {
    init?(data: Data)
}


public struct Cat: Model {

    public init?(data: Data) {
        guard !data.isEmpty else {
            return nil
        }
    }
}
