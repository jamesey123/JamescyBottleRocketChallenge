//
//  DetailRestaurantViewController.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import UIKit
import Combine
import MapKit
import CoreLocation

class DetailRestaurantViewController: UIViewController {
    
    var viewModel: LunchViewModel?
    private var subscribers = Set<AnyCancellable>()
    private let locationManager = CLLocationManager()
    
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var categoryTypeLabel: UILabel!
    @IBOutlet private weak var addressIndexZeroLabel: UILabel!
    @IBOutlet private weak var addressIndexOneLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var twitterHandleLabel: UILabel!
    @IBOutlet private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpBinding()
        checkAuthSatus()
        populateUI()
        setUpMap()
    }
    
    private func populateUI() {
        restaurantNameLabel.text = viewModel?.restaurantSelected?.name
        categoryTypeLabel.text = viewModel?.restaurantSelected?.category
        addressIndexZeroLabel.text = viewModel?.restaurantSelected?.location?.formattedAddress[0]
        addressIndexOneLabel.text = viewModel?.restaurantSelected?.location?.formattedAddress[1]
        numberLabel.text = viewModel?.restaurantSelected?.contact?.formattedPhone
        twitterHandleLabel.text = viewModel?.restaurantSelected?.contact?.twitter
        
    }
    
    private func setUpMap(){
        let lat = viewModel?.restaurantSelected?.location?.lat ?? 40.7128
        let lng = viewModel?.restaurantSelected?.location?.lng ?? -74.0060
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        mapView.centerToLocation(initialLocation)
        
        let restaurantAnnotatoion = MKPointAnnotation()
        restaurantAnnotatoion.title = viewModel?.restaurantSelected?.name
        restaurantAnnotatoion.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        mapView.addAnnotation(restaurantAnnotatoion)
    }
    
    private func checkAuthSatus() {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            break
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
            //like delegate can also be set in Interface Builder on storyboards
            mapView.showsUserLocation = true
        case .authorizedAlways:
            mapView.showsUserLocation = true
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        @unknown default:
            break
        }
    }

}

private extension MKMapView {
  
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
