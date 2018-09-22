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
  
  let booksCollectionViewController = BooksCollectionController()
  
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(navigationBar)
    
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
    
    booksCollectionViewController.installView(above: view, startY: 429.0, endY: view.safeAreaInsets.top + 123.0, height: UIScreen.main.bounds.height - 90.0)
  }
}

extension MainViewController: MKMapViewDelegate {
  
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
