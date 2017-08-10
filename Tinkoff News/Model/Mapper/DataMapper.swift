//
//  DataMapper.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 10.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

protocol DataMapper {
  associatedtype Database

  static func mapFeed(data: Data, db: Database) throws
  static func mapItem(data: Data, db: Database) throws
}
