//
//  ViewController.swift
//  SearchLocation
//
//  Created by Vũ Linh on 11/05/2021.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation

class ViewController: UIViewController {
    
    let mapView = MKMapView()
    let panel = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        
        let vc = SearchViewController()
        vc.delegate = self
        
        // Float Panel
        panel.set(contentViewController: vc)
        panel.addPanel(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
}

extension ViewController: SearchViewControllerDelegate {
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            return
        }
        
        panel.move(to: .tip, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
    }
}
