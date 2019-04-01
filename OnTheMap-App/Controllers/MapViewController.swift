//
//  MapViewController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeStudentInformationNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       unsubscribeStudentInformationNotifications()
    }
   
    // MARK: Map Configration
    
    @objc func relodMap() {
        var annotations = [MKPointAnnotation]()
        
        for studentLocation in StudentInformationModel.results {
            let lat = CLLocationDegrees(studentLocation.latitude)
            let long = CLLocationDegrees(studentLocation.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = studentLocation.firstName
            let last = studentLocation.lastName
            let mediaURL = studentLocation.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL

            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                
                if let url = URL(string: toOpen) {
                    if app.canOpenURL(url) {
                        app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
                    }else{
                       AlertManager.shared.showFailureFromViewController(viewController: self, message: "Invalid Link")
                    }
                }else {
                    AlertManager.shared.showFailureFromViewController(viewController: self, message: "No Link Found")
                }
               
                
            }
        }
    }
    
    
    // MARK: Notifications
    
    func subscribeStudentInformationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(relodMap), name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
    }
    
    func unsubscribeStudentInformationNotifications() {
         NotificationCenter.default.removeObserver(self)
    }
}
