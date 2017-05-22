//
//  APIClient.swift
//  Apply MJD
//
//  Created by Reza Shirazian on 5/21/17.
//  Copyright © 2017 MJD Interactive. All rights reserved.
//

import Foundation


public protocol APIClient {
  func getCats(completion: @escaping ([Cat]?, NetworkErrorType?) -> Void)
  func loadImage(url: URL, completion: @escaping (UIImage?, NetworkErrorType?) -> Void)
}
