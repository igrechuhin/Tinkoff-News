//
//  String+HTML.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 10.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

extension String {
  func decodingHTML() -> String? {
    guard let data = data(using: .utf8) else { return nil }
    return try? NSAttributedString(data: data,
                                   options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                             NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
                                   documentAttributes: nil).string
  }
}
