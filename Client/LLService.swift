//
//  LLService.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
  case success(T)
  case fail(Error?)
}

struct CommonResponse: Codable {
  let success: Int
}

class LLService {
  
  private let apiString = "http://0.0.0.0:8001/api/pizzachatbot/testMessage"
  
  private let baseURL: String
  
  static let shared = LLService()
  
  init(baseURL: String = "http://0.0.0.0:8001") {
    self.baseURL = baseURL
  }
  
  func request<T>(endPoint: EndPoint<T>) -> URLRequest? {
    let request = Alamofire.request(endPoint.url, method: endPoint.method, parameters: endPoint.parameters)
    request.validate().responseJSON { response in
      
      guard response.result.isSuccess, let data = response.data else {
        endPoint.completion(Result.fail(response.error))
        return
      }
      
      do {
        let theResult = try JSONDecoder().decode(T.self, from: data)
        endPoint.completion(Result.success(theResult))
      } catch {
        endPoint.completion(Result.fail(error))
      }
    }
    return request.request
  }
}

struct EndPoint<T: Codable> {
  
  let url: URL
  let method: HTTPMethod
  let parameters: [String: Any]?
  let completion: (Result<T>) -> Void
  
  
  init(urlPath: String, method: HTTPMethod, paramters: [String: Any], completion: @escaping (Result<T>) -> Void) {
    guard let url = URL(string: urlPath) else {
      fatalError("url unvalid")
    }
    self.url = url
    self.method = method
    self.parameters = paramters
    self.completion = completion
  }
  
}
