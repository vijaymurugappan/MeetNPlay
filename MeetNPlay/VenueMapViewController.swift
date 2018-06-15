//
//  VenueMapViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/14/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class VenueMapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var radius = String()
    var rating = String()
    var game = String()
    var lat = CLLocationDegrees()
    var lon = CLLocationDegrees()
    var placeID = String()
    
    let locManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .hybrid
        mapView.delegate = self
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
        locManager.startUpdatingLocation()
        mapView.userTrackingMode = .follow
        radius = radius.replacingOccurrences(of: " mi", with: "")
        radius = "\(Double(self.radius)! * 1609.34)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var anview = mapView.dequeueReusableAnnotationView(withIdentifier: "place")
        if anview == nil {
            anview = MKAnnotationView(annotation: annotation, reuseIdentifier: "place")
            anview?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            anview?.rightCalloutAccessoryView = button
            anview?.image = UIImage(named: "ico-find.png")
            anview?.frame.size = CGSize(width: 35.0, height: 35.0)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        else {
            anview?.annotation = annotation
        }
        return anview
    }
    
    @objc func buttonTapped() {
        performSegue(withIdentifier: "venueDetail", sender: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for loc in locations {
            lat = loc.coordinate.latitude
            lon = loc.coordinate.longitude
        }
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lon)&rating=\(rating)&radius=\((radius))&type=recreation&keyword=\(game)&key=AIzaSyAtMt9DUstYDjLFCANqLanqdEqzyVfC0h0")
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if error != nil {
                print(error?.localizedDescription ?? 0)
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                let data = jsonData["results"] as! [[String:Any]]
                for value in data {
                    let name = value["name"] as! String
                    let address = value["vicinity"] as! String
                    if let geo = value["geometry"] as? [String:Any] {
                        if let locate = geo["location"] as? [String:Any] {
                            let placeLatitude = locate["lat"] as! Double
                            let placeLongitude = locate["lng"] as! Double
                            let placeLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(placeLatitude, placeLongitude)
                            let animation = MKPointAnnotation()
                            animation.coordinate = placeLocation
                            animation.title = name
                            animation.subtitle = address
                            self.mapView.addAnnotation(animation)
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "venueDetail" {
            if let vc = segue.destination as? VenueDetailViewController {
                vc.placeID = self.placeID
            }
        }
    }
}
