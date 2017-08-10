//
//  DataMapperError.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 08.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

enum DataMapperError: Error {
  case corruptedPayload
  case invalidPayloadType
  case invalidResultCode
  case missingPayload
}
