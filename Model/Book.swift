//
//  Book.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation

struct Book: Codable{
  let author: String
  let format: BookFormat
  let id: String
  let narrator: String
  let publishedDate: String
  let publisher: String
  let synopsis: String
  let title: String
}

extension Book {
  enum BookFormat: String, Codable {
    case audio = "AUDIO"
    case eBook = "EBOOK"
    case physical = "PHYSICAL"
  }
}
