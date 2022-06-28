//
//  ViewController.swift
//  GooglePlacesMock
//
//  Created by Taichi Yuki on 2022/06/28.
//

import UIKit
import GooglePlaces
import CoreLocation

class ViewController: UIViewController {

  private let client = GMSPlacesClient.shared()
  private let locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()

    let status = CLLocationManager.authorizationStatus()
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      getCurrenPlace()
    default:
      locationManager.requestWhenInUseAuthorization()
    }
  }

  private func getCurrenPlace() {
    let placeFields: GMSPlaceField = [.name, .formattedAddress]
    client.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { (placeLikelihoods, error) in

      guard error == nil else {
        print("Current place error: \(error?.localizedDescription ?? "")")
        return
      }
      guard let place = placeLikelihoods?.first?.place else {
        print("No current place")
        return
      }

      print("testing...", placeLikelihoods?.count)
      print("testing...", place.name)
      print("testing...", place.formattedAddress)
    }
  }
}

