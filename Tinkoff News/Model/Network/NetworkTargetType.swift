//
//  NetworkTargetType.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 06.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

protocol NetworkTargetType {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: String]? { get }
}
