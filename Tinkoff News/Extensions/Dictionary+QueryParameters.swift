//
//  Dictionary+QueryParameters.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 06.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

extension Dictionary {
  var queryParameters: String {
    var parts: [String] = []
    for (key, value) in self {
      let part = String(format: "%@=%@",
                        String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                        String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
      parts.append(part)
    }
    return parts.joined(separator: "&")
  }

}
