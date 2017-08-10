//
//  Network.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 06.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

final class Network {
  static func fetch(request: NetworkTargetType, onCompletion: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
    var url = request.baseURL.appendingPathComponent(request.path)
    if let parameters = request.parameters {
      url = url.appendingQueryParameters(parameters)
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue

    let task = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      if let error = error {
        onError(error)
      } else {
        if let response = response as? HTTPURLResponse {
          let statusCode = response.statusCode
          if statusCode == 200 {
            if let data = data {
              onCompletion(data)
            } else {
              onError(NetworkError.noData)
            }
          } else {
            onError(NetworkError.invalidStatusCode(statusCode))
          }
        } else {
          onError(NetworkError.invalidResponse(response))
        }
      }
    }
    task.resume()
  }
}
