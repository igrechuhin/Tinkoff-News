//
//  NewsTarget.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 06.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

enum NewsTarget {
  case pullFeed
  case pullItem(id: String)
}

extension NewsTarget: NetworkTargetType {
  var baseURL: URL { return URL(string: "https://api.tinkoff.ru/v1")! }

  var path: String {
    switch self {
    case .pullFeed: return "/news"
    case .pullItem: return "/news_content"
    }
  }

  var method: HTTPMethod {
    return .get
  }

  var parameters: [String: String]? {
    switch self {
    case .pullFeed: return nil
    case .pullItem(let id): return ["id" : id]
    }
  }
}
