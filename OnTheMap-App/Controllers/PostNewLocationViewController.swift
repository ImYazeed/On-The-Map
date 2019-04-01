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
    var mediaUrl: String!
    var mapString: String!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnnotationsOnMap()
    }
    
    // MARK: ACTIONS
    
    @IBAction func submitLocationTapped(_ sender: Any) {
    
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
       let studentInfo = StudentInfoToSend(uniqueKey: StudentInformationModel.currentUser.key, firstName: StudentInformationModel.currentUser.firstName, lastName: StudentInformationModel.currentUser.lastName, mapString: mapString, mediaURL: mediaUrl, latitude: latitude, longitude: longitude)
        
        ParseClient.postStudentLocation(student: studentInfo,
                                        success: {
            self.dismiss(animated: true, completion: nil)
        },
                                        failure: {(error) in
                AlertManager.shared.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        })
    }
    
    // UI Configrations
    
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
