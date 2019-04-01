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
    }
    
    // MARK: ACTIONS
    
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
    
    // MARK: Map Configarations
    
    func handleFindingLocationResponse(placeMarks: [CLPlacemark]?, error: Error?) {
        
        setFindingLocation(false)
        
        if (error != nil) {
            AlertManager.shared.showFailureFromViewController(viewController: self, message: "Unable to Find Location for Address.")
        }else {
            var location: CLLocation?
            
            if let placemarks = placeMarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                showLocationOnMap(location: location)
            }else {
                AlertManager.shared.showFailureFromViewController(viewController: self, message: "No Matching Location Found.")
            }
        }
    }
    
    // MARK: UI Configrations
    
    func configureFindLocationButton() {
        
        let isTexFieldsFilled = locationTextField.text != "" && linkTextField.text != ""
        
        findLocationButton.isEnabled = isTexFieldsFilled
        findLocationButton.alpha = isTexFieldsFilled ? 1.0 : 0.7
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
