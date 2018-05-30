//
//  ViewController.swift
//  Sample
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit
import HeWeatherIO
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private lazy var locationManager: CLLocationManager = {

        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.distanceFilter = kCLLocationAccuracyThreeKilometers
        manager.delegate = self

        return manager
    }()

    private lazy var username: String = {
        do {
            guard let path = Bundle.main.path(forResource: "USER_NAME", ofType: nil) else {
                return ""
            }
            let str: String = try String(contentsOfFile: path)
            return str.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return ""
        }
    }()
    private lazy var apiKey: String = {
        do {
            guard let path = Bundle.main.path(forResource: "API_KEY", ofType: nil) else {
                return ""
            }
            let str: String = try String(contentsOfFile: path)
            return str.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return ""
        }
    }()

    private var userLocation: CLLocation? {
        didSet {
            guard let location = userLocation else {
                return
            }
            #if false
            let client = HeWeatherClient(authByKey: self.apiKey)
            client.getForecast(location: location) { (result) in
                switch result {

                case .success(let value):
                    guard let value = value else {
                        break
                    }
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            #else
            let client = HeWeatherClient(authBySign: self.username, apiKey: self.apiKey)
            client.getForecast(location: .coreLocation(location: location)) { (result) in
                switch result {

                case .success(let value):
                    guard let value = value else {
                        break
                    }
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            #endif
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {

        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.userLocation == nil {
            self.userLocation = locations.last
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}

