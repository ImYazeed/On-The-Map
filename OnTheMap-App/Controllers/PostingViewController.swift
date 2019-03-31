//
//  PostingViewController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 26/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit
import MapKit

class PostingViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var findLocationButton: LoginButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        configureFindLocationButton()
    }
    @IBAction func cancelTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationTapped(_ sender: Any) {
        
        setFindingLocation(true)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationTextField.text!) { (placeMarks, error) in
            
            self.handleFindingLocationResponse(placeMarks: placeMarks, error: error)
        }
    }
    
    func configureFindLocationButton() {
        
        let isTexFieldsFilled = locationTextField.text != "" && linkTextField.text != ""
        
        findLocationButton.isEnabled = isTexFieldsFilled
        findLocationButton.alpha = isTexFieldsFilled ? 1.0 : 0.7
    }
    
    
    func handleFindingLocationResponse(placeMarks: [CLPlacemark]?, error: Error?) {
        
        setFindingLocation(false)
        
        if (error != nil) {
            AlertManager.showFailureFromViewController(viewController: self, message: "Unable to Find Location for Address.")
        }else {
            var location: CLLocation?
            
            if let placemarks = placeMarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                showLocationOnMap(location: location)
            }else {
                AlertManager.showFailureFromViewController(viewController: self, message: "No Matching Location Found.")
            }
        }
    }
    
   func setFindingLocation(_ findingLocation: Bool) {
    if findingLocation {
        activityIndicator.startAnimating()
    } else {
        activityIndicator.stopAnimating()
    }
    findLocationButton.isEnabled = !findingLocation
    locationTextField.isEnabled = !findingLocation
    linkTextField.isEnabled = !findingLocation
    findLocationButton.isEnabled = !findingLocation
    
    findLocationButton.alpha = !findingLocation ? 1.0 : 0.7
    }
    
    func showLocationOnMap(location: CLLocation) {
        
        DispatchQueue.main.async {
            
            let newLocationVC = self.storyboard?.instantiateViewController(withIdentifier: "newLocation") as! PostNewLocationViewController
            
            newLocationVC.location = location
            newLocationVC.mediaUrl = self.linkTextField.text!
            newLocationVC.mapString = self.locationTextField.text!
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(newLocationVC, animated: true)
        }
    }
}
