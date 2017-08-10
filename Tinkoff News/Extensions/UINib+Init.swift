//
//  UINib+Init.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 03.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

extension UINib {
  convenience init<ViewClass>(_ viewClass: ViewClass.Type, bundle: Bundle? = nil) where ViewClass: UIView {
    self.init(nibName: viewClass.classId(), bundle: bundle)
  }
}
