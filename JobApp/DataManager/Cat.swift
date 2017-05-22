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

  public let name: String
  public let source: String
  public let image: String
  public let caption: String
  
  public init?(data: Data) {
      guard !data.isEmpty else {
          return nil
      }
    
    self.name = data["name"] as? String ?? "Unnamed Kitty"
    self.source = data["source"] as? String ?? "No Source"
    self.image = data["image"] as? String ??  "https://maxcdn.icons8.com/Color/PNG/512/User_Interface/cat_profile-512.png"
    self.caption = data["caption"] as? String ?? "No caption"
  }
}
