//
//  ViewController.swift
//  LostSocks
//
//  Created by Tomas Sykora, jr. on 26/10/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    let mapView = MKMapView()
    let socks = [Sock]()
    var locationManager = CLLocationManager()
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        APIWrapper.loginUser(username: "user", password: "pass" , completionHandler: { success in
            if success {
                APIWrapper.getSocks(completionHandler: { (socks) in
                    print("Count of socks: \(socks.count)")
                })
            } else {
                
            }
            
        })
    }
    
    func new() {
        navigationController?.pushViewController(NewSockForm(), animated: true)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        title = "Lost Socks"
        setupConstraints()
        mapView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(ViewController.new))
        
        APIWrapper.getSocks { (socks) in
            self.updateAnnotations(socks: socks)
        }
        
        
	}
    
    func updateAnnotations(socks: [Sock]) {
        for sock in socks {
            mapView.addAnnotation(sock)
        }
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        

    }
    

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Sock {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}
