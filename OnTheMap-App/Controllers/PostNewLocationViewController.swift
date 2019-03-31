//
//  PostNewLocationViewController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 31/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import MapKit

class PostNewLocationViewController: UIViewController {
    
    var location: CLLocation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnnotationsOnMap()
    }
    
    
    @IBAction func submitLocationTapped(_ sender: Any) {
        
    }
    
    
    func showAnnotationsOnMap() {
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
        let coordinateRegion = MKCoordinateRegion(center: coordinate, span: coordinateSpan)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        self.mapView.region = coordinateRegion
        self.mapView.addAnnotation(annotation)
        
        
    }
}
