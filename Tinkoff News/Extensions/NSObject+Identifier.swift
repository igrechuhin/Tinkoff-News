//
//  NSObject+Identifier.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 03.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

extension NSObject {
  static func classId() -> String {
    return String(describing: self)
  }
}
