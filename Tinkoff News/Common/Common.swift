//
//  Common.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 03.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

fileprivate func IPAD() -> Bool { return UI_USER_INTERFACE_IDIOM() == .pad }

func alternative<T>(iPhone: T, iPad: T) -> T { return IPAD() ? iPad : iPhone }

func L(_ key: String) -> String { return NSLocalizedString(key, comment: "") }

infix operator ??= : AssignmentPrecedence
func ??=<T>(optional: inout T?, defaultValue: T) {
  if optional == nil {
    optional = defaultValue
  }
}
