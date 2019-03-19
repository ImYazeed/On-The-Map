//
//  MapViewController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @objc func configureActivityIndicator() {
    

    }

    override func viewWillDisappear(_ animated: Bool) {
     
    }

}
