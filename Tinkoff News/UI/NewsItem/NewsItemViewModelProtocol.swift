//
//  NewsItemViewModelProtocol.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 10.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

protocol NewsItemViewModelProtocol: class {
  var item: DatabaseNewsItem? { get }

  var isEmpty: Bool { get }

  var syncCompletion: NewsSyncManager.Completion { get set }
}
