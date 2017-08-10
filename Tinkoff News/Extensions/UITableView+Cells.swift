//
//  UITableView+Cells.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 03.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

extension UITableView {
  func registerNib<CellClass>(cellClass: CellClass.Type) where CellClass: UITableViewCell {
    register(UINib(cellClass), forCellReuseIdentifier: cellClass.classId())
  }

  func register<CellClass>(cellClass: CellClass.Type) where CellClass: UITableViewCell {
    register(cellClass, forCellReuseIdentifier: cellClass.classId())
  }

  func dequeueReusableCell<CellClass>(cellClass: CellClass.Type) -> CellClass? where CellClass: UITableViewCell {
    return dequeueReusableCell(withIdentifier: cellClass.classId()) as? CellClass
  }

  func dequeueReusableCell<CellClass>(cellClass: CellClass.Type, indexPath: IndexPath) -> CellClass where CellClass: UITableViewCell {
    return dequeueReusableCell(withIdentifier: cellClass.classId(), for: indexPath) as! CellClass
  }
}
