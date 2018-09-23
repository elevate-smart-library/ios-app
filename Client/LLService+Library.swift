//
//  LLService+Library.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation


extension LLService {
  
  func getLibrary(completeion: @escaping (Result<[Library]>) -> Void) {
    let endPoint = EndPoint<[Library]>(urlPath: "api/v1/libraries", method: .get, paramters: [:], completion: completeion)
    request(endPoint: endPoint)
  }
  
  func getBooks(completeion: @escaping (Result<[Book]>) -> Void) {
    let endPoint = EndPoint<[Book]>(urlPath: "api/v1/books", method: .get, paramters: [:], completion: completeion)
    request(endPoint: endPoint)
  }
  
}
