//
//  MainViewController.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

  @IBOutlet var navigationBar: SearchNavigationBar!
  @IBOutlet var mapView: MKMapView!
  
  static let identifier = "LibraryPin"
  
  let bookList = BookListViewController()
  let locationManager = CLLocationManager()
  
  var libraries: [Library] = [] {
    didSet {
      let annotations = libraries.compactMap { library -> LibraryAnnotation in
        let notation = LibraryAnnotation(with: library)
        return notation
      }
      mapView.addAnnotations(annotations)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(bookList.view)
    view.addSubview(navigationBar)
    
    bookList.view.pinToSuperView()
    
    navigationBar.subTitle.text = "6 Little Libraries Nearby"
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    if CLLocationManager.authorizationStatus() == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    } else {
      locationManager.requestLocation()
    }
    
    mapView.delegate = self
    mapView.showsUserLocation = true
    
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
      navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
      navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
    
    
    LLService.shared.getLibrary { [weak self] result in
      switch result {
      case .success(let libraries) :
        self?.libraries = libraries
      case .fail(let error):
        debugPrint("\(error)")
      }
    }
    
  }
}

extension MainViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let reuseIdentifier = "pin"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
      annotationView?.canShowCallout = true
    } else {
      annotationView?.annotation = annotation
    }
    
    if ((annotation as? MKUserLocation) != nil) {
      return annotationView
    }
    
    if let customPointAnnotation = annotation as? LibraryAnnotation {
      annotationView?.image = (annotationView?.isSelected ?? false) ? customPointAnnotation.selectedImage : customPointAnnotation.annotationImage
    }
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    if let libraryNote = view.annotation as? LibraryAnnotation {
      view.image = libraryNote.selectedImage
      
    }
  }
  
  func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
    if let libraryNote = view.annotation as? LibraryAnnotation {
      view.image = libraryNote.annotationImage
    }
  }
  
}

extension MainViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last{
      let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
      mapView.setRegion(region, animated: true)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error fetch location \(error)")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      locationManager.requestLocation()
    }
  }
  
}
