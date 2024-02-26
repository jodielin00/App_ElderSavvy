//
//  ViewController.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/25.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var recordView: UIView!
    
    @IBOutlet weak var textConversionView: UIView!
    
    @IBOutlet weak var softUseView: UIView!
    
    @IBOutlet weak var codeView: UIView!
    
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var emergencyCallView: UIView!
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let recordTap = UITapGestureRecognizer(target: self, action:#selector(touchRecord(tap:)));
        recordView.addGestureRecognizer(recordTap);
        
        let textConversion = UITapGestureRecognizer(target: self, action:#selector(touchTextConversion(tap:)));
        textConversionView.addGestureRecognizer(textConversion);
        
        let touchSoftUse = UITapGestureRecognizer(target: self, action:#selector(touchSoftUse(tap:)));
        softUseView.addGestureRecognizer(touchSoftUse);
        
        let touchCode = UITapGestureRecognizer(target: self, action:#selector(touchCode(tap:)));
        codeView.addGestureRecognizer(touchCode);
        
        let touchAddress = UITapGestureRecognizer(target: self, action:#selector(touchAddress(tap:)));
        addressView.addGestureRecognizer(touchAddress);
        
        let emergencyCall = UITapGestureRecognizer(target: self, action:#selector(touchEmergencyCall(tap:)));
        emergencyCallView.addGestureRecognizer(emergencyCall);
    }
    
    @objc func touchRecord(tap: UITapGestureRecognizer) {
        //        let recordVC = JORecordVC()
        //        self.navigationController?.pushViewController(recordVC, animated: true)
        
        performSegue(withIdentifier: "toRecordVC", sender: nil)
        
    }
    
    @objc func touchTextConversion(tap: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toRecordVC", sender: nil)
        
    }
    
    @objc func touchSoftUse(tap: UITapGestureRecognizer) {
        performSegue(withIdentifier: "JOSoftList", sender: nil)
        
    }
    @objc func touchCode(tap: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toRecordVC", sender: nil)
        
    }
    @objc func touchAddress(tap: UITapGestureRecognizer) {
        performSegue(withIdentifier: "JOAddress", sender: nil)
        
    }
    
    @objc func touchEmergencyCall(tap: UITapGestureRecognizer) {
        
            let url = URL(string: "tel://\(10010)")!
            UIApplication.shared.open(url, options: [:])
        
    }
}

