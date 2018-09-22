//
//  ViewController.swift
//  elevate
//
//  Created by Harry Wu on 2018-09-22.
//  Copyright © 2018 Harry Wu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class CustomerLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subTitle: String?
    
    init(coordinate:CLLocationCoordinate2D, title: String?, subTitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subTitle = subTitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        return MKCoordinateRegion(center: coordinate, span: span)
    }

    
}

class MainViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    let locations = [
        ["title": "Local Store 3",    "latitude": 43.6520, "longitude": -79.3900],
        ["title": "Local Store 2", "latitude": 43.6540, "longitude": -79.3700],
        ["title": "Local Store 1",     "latitude": 43.6523, "longitude": -79.3830]
    ]

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let customerCoord = CLLocationCoordinate2D(latitude: 43.6558, longitude: -79.3866)
        
        let customerAnnotation = CustomerLocationAnnotation(coordinate: customerCoord, title: "Customer", subTitle: "Location")
        mapView.addAnnotation(customerAnnotation)
        mapView.setRegion(customerAnnotation.region, animated: true)
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            mapView.addAnnotation(annotation)
        }
        
        
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        searchButton.layer.cornerRadius = 5
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let reviewController = ReviewViewController(nibName: String(describing: ReviewViewController.self), bundle: nil)
        self.navigationController?.pushViewController(reviewController, animated: true)
        
    }
    
    func showStoreLocation() {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    @IBAction func didPressSearch() {
        NSLog("HERE")
    }

    @IBAction func didPressLocation() {
        NSLog("HERE")
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let customerAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            customerAnnotationView.animatesWhenAdded = true
            customerAnnotationView.titleVisibility = .adaptive
            customerAnnotationView.subtitleVisibility = .adaptive
            return customerAnnotationView
            
        }
        return nil
    }
}
