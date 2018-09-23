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
  
  var selectedAnnotation: LibraryAnnotation?
  
  let bookList = BookListViewController()
  let locationManager = CLLocationManager()
  
  let searchList = BookSearchResultController()
  
  var libraries: [Library] = [] {
    didSet {
      let annotations = libraries.compactMap { library -> LibraryAnnotation in
        let notation = LibraryAnnotation(with: library)
        return notation
      }
      mapView.addAnnotations(annotations)
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    bookList.topHeight = navigationBar.frame.maxY
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addChild(bookList)
    addChild(searchList)
    
    view.addSubview(bookList.view)
    view.addSubview(navigationBar)
    
    searchList.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(searchList.view)
    
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
    let navSize = navigationBar.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let height = navSize.height + (view.safeAreaInsets.top == 0 ? 20.0 : view.safeAreaInsets.top)
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
      navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
      navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
      navigationBar.heightAnchor.constraint(equalToConstant: height),
      
      searchList.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
      searchList.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      searchList.view.rightAnchor.constraint(equalTo: view.rightAnchor),
      searchList.view.leftAnchor.constraint(equalTo: view.leftAnchor)
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
      selectedAnnotation = libraryNote
      self.perform(#selector(updateView), with: nil, afterDelay: 0.3)
    }
  }
  
  func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
    if let libraryNote = view.annotation as? LibraryAnnotation {
      view.image = libraryNote.annotationImage
      if selectedAnnotation == libraryNote {
        selectedAnnotation = nil
      }
      self.perform(#selector(updateView), with: nil, afterDelay: 0.3)
    }
  }
  
  @objc
  func updateView() {
    if selectedAnnotation == nil {
      bookList.status = .books
    } else {
      bookList.status = .library
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
