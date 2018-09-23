//
//  Library.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation

/**
 contacts  [...]
 id  string
 location  Location{
 address  string
 lat  number($double)
 lng  number($double)
 tag  string
 }
 name  string
 type  string
 Enum:
 [ PUBLIC, STATION, HOME ]
 */

struct Library: Codable {
  let id: String
  let location: Location
  let name: String
  let type: LibraryType
}

extension Library {
  enum LibraryType: String, Codable {
    case publicTye = "PUBLIC"
    case station = "STATION"
    case home = "HOME"
  }
}

struct Location: Codable {
  let address: String
  let lat: Double
  let lng: Double
  let tag: String
}
