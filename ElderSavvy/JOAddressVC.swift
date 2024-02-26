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
    }
    
    
    @IBAction func clickWorkAddress(_ sender: Any) {
    }
    
    
    
    @IBAction func clickLocation(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

func addAnnolgdftation(_ coordinate: CLLocationCoordinate2D, title: String, subTitle: String) -> MYAkjation {
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

extension JOAddressVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let idpoifier = "item"
        var apiotionView = mapView.dequeueReusableAnnotationView(withIdentifier: idpoifier)
        if apiotionView == nil {
            apiotionView = MKAnnotationView(annotation: annotation, reuseIdentifier: idpoifier)
        }
        apiotionView?.annotation = annotation
        apiotionView?.image = UIImage(named: "locati")
        apiotionView?.centerOffset = CGPoint(x: 0, y: 0)
        apiotionView?.canShowCallout = true// 设置弹框
        apiotionView?.calloutOffset = CGPoint(x: 10, y: 0)

        return apiotionView
    }
    
}
