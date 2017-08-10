//
//  NewsMapper.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 08.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

final class NewsMapper: DataMapper {
  typealias Database = NewsDatabase

  private static func validate(json: [String: Any]) throws {
    guard let resultCode = json["resultCode"] as? String, resultCode == "OK" else { throw DataMapperError.invalidResultCode }
    guard json["payload"] != nil else { throw DataMapperError.missingPayload }
  }

  private static func mapDate(json: Any?) throws -> NSDate {
    guard let json = json as? [String: Int],
      let milliseconds = json["milliseconds"] else { throw DataMapperError.corruptedPayload }

    return NSDate(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
  }

  @discardableResult
  private static func mapItemHeader(json: [String: Any], db: Database) throws -> DatabaseNewsItem {
    guard let id = json["id"] as? String,
      let text = json["text"] as? String else { throw DataMapperError.corruptedPayload }
    let publicationDate = try mapDate(json: json["publicationDate"])

    let item = try db.getItem(id: id)
    item.id ??= id
    item.text ??=  text
    item.publicationDate ??= publicationDate
    return item
  }

  static func mapFeed(data: Data, db: Database) throws {
    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

    try validate(json: json)

    guard let payload = json["payload"] as? [[String: Any]] else { throw DataMapperError.invalidPayloadType }

    try payload.forEach { try mapItemHeader(json: $0, db: db) }
  }

  static func mapItem(data: Data, db: Database) throws {
    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

    try validate(json: json)

    guard let payload = json["payload"] as? [String: Any] else { throw DataMapperError.invalidPayloadType }
    guard let title = payload["title"] as? [String: Any] else { throw DataMapperError.corruptedPayload }

    let item = try mapItemHeader(json: title, db: db)
    guard let content = payload["content"] as? String else { throw DataMapperError.corruptedPayload }
    item.content ??= content
  }
}
