//
//  LibraryAnnotaion.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import MapKit


class LibraryAnnotation: MKPointAnnotation {
  
  let annotationImage: UIImage = #imageLiteral(resourceName: "unselectedPin")
  let selectedImage: UIImage = #imageLiteral(resourceName: "selectedPin")
  
  var library: Library
  
  init(with lib: Library) {
    self.library = lib
    super.init()
    coordinate = CLLocationCoordinate2D(latitude: library.location.lat, longitude: library.location.lng)
  }
  
}
