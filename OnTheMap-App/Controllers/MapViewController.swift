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
        NotificationCenter.default.addObserver(self, selector: #selector(relodMap), name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func relodMap() {
        var annotations = [MKPointAnnotation]()
        
        for studentLocation in StudentInformationModel.results {
            let lat = CLLocationDegrees(studentLocation.latitude ?? 1.0)
            let long = CLLocationDegrees(studentLocation.longitude ?? 1.0)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = studentLocation.firstName ?? ""
            let last = studentLocation.lastName ?? ""
            let mediaURL = studentLocation.mediaURL ?? ""
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
    
    
    
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
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                
                if let url = URL(string: toOpen) {
                    if app.canOpenURL(url) {
                        app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
                    }else{
                        AlertManager.showFailureFromViewController(viewController: self, message: "Invalid Link")
                    }
                }else {
                    AlertManager.showFailureFromViewController(viewController: self, message: "No Link Found")
                }
               
                
            }
        }
    }
    
    
    
}
