//
//  JOAddressVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/26.
//

import UIKit
import MapKit

class JOAddressVC: UIViewController {
    
    @IBOutlet weak var mapBackView: UIView!
    
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "位置"
        // Do any additional setup after loading the view.
        
        setUpMapView()
        mapView.mapType = MKMapType.standard
        mapView.showsBuildings = true
        mapView.delegate = self
//        mapView.showsUserLocation = true
        
        // 设置中心点坐标
//                let centerCoordinate = CLLocationCoordinate2D(latitude: 23.17881107170488, longitude: 113.26347675918576)
//                let centerSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // 缩放级别
//                let region = MKCoordinateRegion(center: centerCoordinate, span: centerSpan)
                
        
        let coordinate =  CLLocationCoordinate2D(latitude: 22.28512194624257, longitude: 114.1467661268296)
        let annotation:MYAkjation = addAnnotation(coordinate, title: "", subTitle: "")
//        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.isScrollEnabled = true
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geochange.reverseGeocodeLocation(location) { (pls: [CLPlacemark]?, error: Error?) -> Void in
            if error == nil {
                let pl = pls?.first
                annotation.title = pl?.locality
                annotation.subtitle = pl?.name
            }
        }
        
        
        let coordinateT =  CLLocationCoordinate2D(latitude: 22.427142881762666, longitude: 114.2070683111552)
        let annotationT:MYAkjation = addAnnotation(coordinateT, title: "", subTitle: "")
//        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotationT)
        mapView.isScrollEnabled = true
        let locationT = CLLocation(latitude: coordinateT.latitude, longitude: coordinateT.longitude)
        geochange.reverseGeocodeLocation(locationT) { (pls: [CLPlacemark]?, error: Error?) -> Void in
            if error == nil {
                let pl = pls?.first
                annotationT.title = pl?.locality
                annotationT.subtitle = pl?.name
            }
        }
        
        let latDelta = 0.135
        let longDelta = 0.135
        let  center =  CLLocationCoordinate2D(latitude: 22.3561322881762666, longitude: 114.17691711552)
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let  currentRegion =  MKCoordinateRegion (center: center, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
                // 设置地图的区域
//                mapView.setRegion(region, animated: true)
        
    }
    
    func setUpMapView() {
        mapView = MKMapView()
        self.mapBackView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    @IBAction func clickHomeAddress(_ sender: Any) {
        let coordinate =  CLLocationCoordinate2D(latitude: 22.28512194624257, longitude: 114.1467661268296)
        let annotation:MYAkjation = addAnnotation(coordinate, title: "", subTitle: "")
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.isScrollEnabled = true
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geochange.reverseGeocodeLocation(location) { (pls: [CLPlacemark]?, error: Error?) -> Void in
            if error == nil {
                let pl = pls?.first
                annotation.title = pl?.locality
                annotation.subtitle = pl?.name
            }
        }
        
        let latDelta = 0.005
        let longDelta = 0.005
        let  center =  CLLocationCoordinate2D(latitude: 22.28512194624257, longitude: 114.1467661268296)
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let  currentRegion =  MKCoordinateRegion (center: center, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
    }
    
    
    
    
    
    @IBAction func clickLocation(_ sender: Any) {
        
        let coordinate =  CLLocationCoordinate2D(latitude: 22.427142881762666, longitude: 114.2070683111552)
        let annotation:MYAkjation = addAnnotation(coordinate, title: "", subTitle: "")
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.isScrollEnabled = true
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geochange.reverseGeocodeLocation(location) { (pls: [CLPlacemark]?, error: Error?) -> Void in
            if error == nil {
                let pl = pls?.first
                annotation.title = pl?.locality
                annotation.subtitle = pl?.name
            }
        }
        
        let latDelta = 0.005
        let longDelta = 0.005
        let  center =  CLLocationCoordinate2D(latitude: 22.427142881762666, longitude: 114.2070683111552)
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let  currentRegion =  MKCoordinateRegion (center: center, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
        
        
//        // 开始定位服务
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//            locationManager.requestWhenInUseAuthorization()
//        } else if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
//            print("无法访问位置信息")
//        } else {
//            startLocationServices()
//        }
        

    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        return manager
    }()
    private func startLocationServices() {
        
        guard CLLocationManager.locationServicesEnabled() else {
            print("未能打开位置服务")
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    private lazy var geochange: CLGeocoder = {
        return CLGeocoder()
    }()
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

func addAnnotation(_ coordinate: CLLocationCoordinate2D, title: String, subTitle: String) -> MYAkjation {
    let aljkfation: MYAkjation = MYAkjation()
    aljkfation.coordinate = coordinate
    aljkfation.title = title
    aljkfation.subtitle = subTitle
    return aljkfation
}

class MYAkjation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?
}

extension JOAddressVC: MKMapViewDelegate,CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "item"
        var addAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if addAnnotation == nil {
            addAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        addAnnotation?.annotation = annotation
        addAnnotation?.image = UIImage(named: "locateImg")
        addAnnotation?.centerOffset = CGPoint(x: 0, y: 0)
        addAnnotation?.canShowCallout = true// 设置弹框
        addAnnotation?.calloutOffset = CGPoint(x: 10, y: 0)
        
        return addAnnotation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        
        // 将地图视图移动到最新的位置
//        let camera = MKMapCamera(lookingAtCenterCoordinate: currentLocation.coordinate, fromDistance: 1000, pitch: 45, heading: 0)
//        mapView!.setCamera(camera, animated: true)
        
        let coordinate =  CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        let annotation:MYAkjation = addAnnotation(coordinate, title: "", subTitle: "")
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.isScrollEnabled = true
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geochange.reverseGeocodeLocation(location) { (pls: [CLPlacemark]?, error: Error?) -> Void in
            if error == nil {
                let pl = pls?.first
                annotation.title = pl?.locality
                annotation.subtitle = pl?.name
            }
        }
        
        let latDelta = 0.005
        let longDelta = 0.005
        let  center =  CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let  currentRegion =  MKCoordinateRegion (center: center, span: currentLocationSpan)
        mapView.setRegion(currentRegion, animated: true)
        
        // 停止更新位置
        locationManager.stopUpdatingLocation()
    }
    
   
    
}
