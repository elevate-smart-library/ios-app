//
//  Book.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation

/**
 
 {
 "id": "2222",
 "isbn": "978-3-16-148410-2",
 "title": "Daughter of a daughter of a Queen",
 "summary": "The compelling, hidden story of Cathy Williams, a former slave and the only woman to ever serve with the legendary Buffalo Soldiers. Powerful, epic, and compelling, Daughter of a Daughter of a Queen shines light on a nearly forgotten figure in history.",
 "pictureUrl": "https://syndetics.com/index.aspx?isbn=1250193168/LC.gif",
 "author": "Sarah Bird",
 "narrator": null,
 "publisher": "TPublish Inc.",
 "publishedDate": "2012-01-01T00:00:00.000Z",
 "pages": 398,
 "averageReadingTime": "PT816H",
 "format": "PHYSICAL",
 "library": {
 "id": "3333",
 "name": "Shelley Henderson-Whale #44975 Toronto ON",
 "location": {
 "address": "53 Lavinia Ave, Toronto, ON M6S 3H9",
 "lat": 43.6461694,
 "lng": -79.4795851,
 "tag": "home"
 },
 "contacts": [
 {
 "id": "3333",
 "email": null,
 "firstName": null,
 "lastName": null,
 "birthDate": null,
 "gender": null,
 "phoneNumber": null,
 "locations": null,
 "language": null
 }
 ],
 "type": "HOME"
 },
 "tags": [
 "adult",
 "fiction"
 ],
 "similar": null
 },
 */

struct Book: Codable{
  let author: String
  let format: BookFormat
  let id: String
  let pictureUrl: String
  let title: String
  let reviews: [Reviews]
  let library: Library?
  let summary: String
  
  
  var avageReview: Int {
    if reviews.isEmpty {
      return 3
    }
    var a = 0
    reviews.forEach { r in
      a += r.note
    }
    
    return Int(a/reviews.count)
  }
  
}

extension Book {
  enum BookFormat: String, Codable {
    case audio = "AUDIO"
    case eBook = "EBOOK"
    case physical = "PHYSICAL"
  }
  
  class Reviews: Codable {
    let note: Int
  }
}
