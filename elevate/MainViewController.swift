//
//  ViewController.swift
//  elevate
//
//  Created by Harry Wu on 2018-09-22.
//  Copyright © 2018 Harry Wu. All rights reserved.
//

import UIKit
import MapKit

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
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }

    
}

class MainViewController: UIViewController {
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HOME"
        // Do any additional setup after loading the view, typically from a nib.
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let customerCoord = CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832)
        
        let customerAnnotation = CustomerLocationAnnotation(coordinate: customerCoord, title: "Customer", subTitle: "Location")
        mapView.addAnnotation(customerAnnotation)
        mapView.setRegion(customerAnnotation.region, animated: true)
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
