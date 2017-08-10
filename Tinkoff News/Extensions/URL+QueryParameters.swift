//
//  URL+QueryParameters.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 06.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

extension URL {
  func appendingQueryParameters(_ parameters : [String: String]) -> URL {
    let URLString = String(format: "%@?%@", absoluteString, parameters.queryParameters)
    return URL(string: URLString)!
  }
}
