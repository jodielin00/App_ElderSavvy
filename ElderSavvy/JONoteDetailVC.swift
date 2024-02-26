//
//  JONoteDetailVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/25.
//

import UIKit

class JONoteDetailVC: JOBaseVC {
    var indexNote:NSDictionary?
    var titleTextField:UITextField?
    var bodyTextView:UITextView?
    var group:String?
    var isNew = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.backgroundColor = UIColor.white
        self.title = "要事记录"
//        navigationController?.navigationBar.topItem?.title = ""
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardBeShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardBeHidden), name: UIResponder.keyboardDidHideNotification, object: nil)
        self.view.backgroundColor = UIColor.white
        installUI()
        installNavigationItem()
    }
    func installNavigationItem(){
        let itemSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNote))
        let itemDelete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        if self.isNew {
            self.navigationItem.rightBarButtonItems = [itemSave]
        }else{
            self.navigationItem.rightBarButtonItems = [itemSave,itemDelete]
        }
        
    }
    @objc func addNote(){
        let tempDateDataAry = NSMutableArray()
        if isNew{
            if titleTextField?.text != nil && (titleTextField?.text!.count)! > 0{
                
                let titleStr = titleTextField?.text!
                let bodyStr = bodyTextView?.text!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let timeStr = dateFormatter.string(from: Date())
                
                if let tempAry = UserDefaults.standard.value(forKey: "noteListAry") as? Array<Dictionary<String, Any>> {
                    tempDateDataAry.addObjects(from: tempAry)
                    
                    let tempDic = NSMutableDictionary()
                    tempDic.setValue(titleStr, forKey: "title")
                    tempDic.setValue(bodyStr, forKey: "content")
                    tempDic.setValue(timeStr, forKey: "time")
                    tempDateDataAry.add(tempDic)
                    
                    
                }else{// 第一次创建
                    
                    let tempDic = NSMutableDictionary()
                    tempDic.setValue(titleStr, forKey: "title")
                    tempDic.setValue(bodyStr, forKey: "content")
                    tempDic.setValue(timeStr, forKey: "time")
                    tempDateDataAry.add(tempDic)
                    
                }
                
                UserDefaults.standard.set(NSArray(array: tempDateDataAry), forKey: "noteListAry")
                UserDefaults.standard.synchronize()
                
                self.navigationController!.popViewController(animated: true)
            }
        }else{
            if titleTextField?.text != nil && (titleTextField?.text!.count)! > 0{
                
                let titleStr = titleTextField?.text!
                let bodyStr = bodyTextView?.text!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let indexNoteTime = indexNote!["time"] as! String
                
                let tempAry = UserDefaults.standard.value(forKey: "noteListAry")
                tempDateDataAry.addObjects(from: tempAry as! [Any])
                
                for i: Int in 0..<tempDateDataAry.count {
                    let indexDic =  tempDateDataAry[i] as! Dictionary<String, Any>
                    let tempDic = NSMutableDictionary(dictionary: indexDic)
                    let indextempTime = indexDic["time"] as! String
                    if indextempTime == indexNoteTime{
                        
                        tempDic.setValue(titleStr, forKey: "title")
                        tempDic.setValue(bodyStr, forKey: "content")
                        //                        tempDic.setValue(timeStr, forKey: "time")
                        tempDateDataAry.removeObject(at: i)
                        tempDateDataAry.insert(tempDic, at: i)
                        
                        break
                    }
                }
                UserDefaults.standard.set(NSArray(array: tempDateDataAry), forKey: "noteListAry")
                UserDefaults.standard.synchronize()
                self.navigationController!.popViewController(animated: true)
            }
        }
    }
    @objc func deleteNote(){
        if self.isNew{
            return
        }
        let alertController = UIAlertController(title: "警告", message: "您确定要删除此要事吗？", preferredStyle: .alert)
        let action  = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let indexNoteTime = indexNote!["time"] as! String
        let action2  = UIAlertAction(title: "删除", style: .destructive, handler: {(UIAlertAction)-> Void in
            if !self.isNew{
                let tempDateDataAry = NSMutableArray()
                let tempAry = UserDefaults.standard.value(forKey: "noteListAry")
                tempDateDataAry.addObjects(from: tempAry as! [Any])
                
                for i: Int in 0..<tempDateDataAry.count {
                    let indexDic =  tempDateDataAry[i] as! Dictionary<String, Any>
                    let indextempTime = indexDic["time"] as! String
                    if indextempTime == indexNoteTime{
                        tempDateDataAry.removeObject(at: i)
                        break
                    }
                }
                UserDefaults.standard.set(NSArray(array: tempDateDataAry), forKey: "noteListAry")
                UserDefaults.standard.synchronize()
                
                self.navigationController!.popViewController(animated: true)
            }
            
        })
        alertController.addAction(action)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
        
    }
    @objc func keyBoardBeShow(notification:Notification){
        let userInfo = notification.userInfo!
        let frameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject
        let height = frameInfo.cgRectValue.size.height
        bodyTextView?.snp.updateConstraints({(maker) in maker.bottom.equalTo(-30-height)})
        UIView.animate(withDuration: 0.3, animations: {() in self.view.layoutIfNeeded()})
    }
    @objc func keyBoardBeHidden(notification:Notification){
        bodyTextView?.snp.updateConstraints({(maker) in maker.bottom.equalTo(-30)})
        UIView.animate(withDuration: 0.3, animations: {() in self.view.layoutIfNeeded()})
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bodyTextView?.resignFirstResponder()
        titleTextField?.resignFirstResponder()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func installUI(){
        let backImgView = UIImageView(frame: self.view.frame)
        self.view.addSubview(backImgView)
        backImgView.image = UIImage.init(named: "backGroundImg")
        titleTextField?.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(0)
                maker.left.equalTo(0)
                maker.right.equalTo(0)
                maker.height.equalTo(0)
            }
        )
        
        titleTextField = UITextField()
        self.view.addSubview(titleTextField!)
        titleTextField?.borderStyle = .none
        titleTextField?.placeholder = "请输入要事标题"
        titleTextField?.font = UIFont.systemFont(ofSize: 25)
        titleTextField?.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(30)
                maker.left.equalTo(30)
                maker.right.equalTo(-30)
                maker.height.equalTo(30)
            }
        )
        let line = UIView()
        self.view.addSubview(line)
        line.backgroundColor = UIColor.gray
        line.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(titleTextField!.snp.bottom).offset(5)
                maker.left.equalTo(15)
                maker.right.equalTo(-15)
                maker.height.equalTo(0.5)
            }
        )
        bodyTextView = UITextView()
        bodyTextView?.layer.borderColor = UIColor.gray.cgColor
        bodyTextView?.layer.borderWidth = 1
        bodyTextView?.backgroundColor = UIColor.clear
        bodyTextView?.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(bodyTextView!)
        bodyTextView?.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(line.snp.bottom).offset(10)
                maker.left.equalTo(30)
                maker.right.equalTo(-30)
                maker.bottom.equalTo(-30)
            }
        )
        if !isNew{
            let indextitle = indexNote!["title"] as! String
            let indexContent = indexNote!["content"] as! String
            titleTextField?.text = indextitle
            bodyTextView?.text = indexContent
        }
    }
    
}
