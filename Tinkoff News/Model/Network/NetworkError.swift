//
//  NetworkError.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 06.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case invalidResponse(URLResponse?)
  case invalidStatusCode(Int)
  case noData
}
