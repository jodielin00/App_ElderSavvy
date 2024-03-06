//
//  JONoteDetailVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/25.
//

import UIKit

class JONoteDetailVC: UIViewController {
    var indexNote:NSDictionary?
    var titleTextField:UITextField?
//    var dueTimeLbl:UILabel!
    var bodyTextView:UITextView?
    var isNew = false
    let NotificationContent = UNMutableNotificationContent()
    var indexDatePicker:UIDatePicker!
    var oldRemindIdentifier:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "要事记录"
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
    
    //    通知函数
    func sendNotifaction(title:String,remindDate:Date){
        NotificationContent.title = title
        NotificationContent.sound = UNNotificationSound.default
        var animationDuration: TimeInterval = remindDate.timeIntervalSinceNow
        if animationDuration < 0 {
            animationDuration = 1;
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: animationDuration, repeats: false)
        let request = UNNotificationRequest(identifier: title + remindDate.description, content: NotificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotifaction(identifiers:String){
//        let identifiers =  title + remindDate.description
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: [identifiers])
        center.removePendingNotificationRequests(withIdentifiers: [identifiers])
    }
    
    @objc func addNote(){
        let tempDateDataAry = NSMutableArray()
        let remindTimeStr = getRemindTimeValue()
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
                    tempDic.setValue(remindTimeStr, forKey: "remindTime")
                    tempDateDataAry.add(tempDic)
                    
                    
                }else{// 第一次创建
                    
                    let tempDic = NSMutableDictionary()
                    tempDic.setValue(titleStr, forKey: "title")
                    tempDic.setValue(bodyStr, forKey: "content")
                    tempDic.setValue(timeStr, forKey: "time")
                    tempDic.setValue(remindTimeStr, forKey: "remindTime")
                    tempDateDataAry.add(tempDic)
                    
                }
                sendNotifaction(title: titleStr!, remindDate: indexDatePicker.date)
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
                        tempDic.setValue(remindTimeStr, forKey: "remindTime")
                        //                        tempDic.setValue(timeStr, forKey: "time")
                        tempDateDataAry.removeObject(at: i)
                        tempDateDataAry.insert(tempDic, at: i)
                        
                        break
                    }
                }
                if oldRemindIdentifier.count > 0{
                    removeNotifaction(identifiers: oldRemindIdentifier)
                }
                
                sendNotifaction(title: titleStr!, remindDate: indexDatePicker.date)
                
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
        let action2  = UIAlertAction(title: "删除", style: .destructive, handler: { [self](UIAlertAction)-> Void in
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
                
                if self.oldRemindIdentifier.count > 0{
                    removeNotifaction(identifiers: self.oldRemindIdentifier)
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
    
   private func getRemindTimeValue() -> String
    {
//        let indexDatePicker = self.view.viewWithTag(1)as! UIindexDatePicker//通过tag获取indexDatePicker对象
        let date = indexDatePicker.date//获取选定的值
        //初始化日期格式化对象
        let dateFormatter = DateFormatter()
        //设置日期格式化对象的具体格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        //将选定的值转换为string格式以设定格式输出
        let dateAndTime = dateFormatter.string(from: date)
        print(dateAndTime)
        return dateAndTime
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
        
        let dueTimeBtn = UIButton(type: .system)
        dueTimeBtn.setTitle("提醒时间", for: .normal)
        dueTimeBtn.backgroundColor = .lightGray
        dueTimeBtn.layer.cornerRadius = 5
        self.view.addSubview(dueTimeBtn)
        dueTimeBtn.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(line.snp.bottom).offset(5)
                maker.left.equalTo(15)
                maker.width.equalTo(80)
                maker.height.equalTo(30)
            }
        )
        
        //设置tag(可通过tag来获取其对象)
        indexDatePicker = UIDatePicker()
        indexDatePicker.tag = 1
        //设置显示模式为日期时间
        indexDatePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        //设置最大值，最小值
        indexDatePicker.maximumDate = Date(timeInterval:7*24*60*60,since:Date())//设置最大值为现在时间往后7天以内
//        indexDatePicker.minimumDate = Date()//设置最小值为现在
        //更改地区文字
        indexDatePicker.locale = Locale(identifier: "zh_CN")
        //设置文字颜色
        indexDatePicker.setValue(UIColor.red, forKey: "textColor")
        //添加到视图中
        self.view.addSubview(indexDatePicker)
        
        indexDatePicker.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(line.snp.bottom).offset(5)
                maker.left.equalTo(dueTimeBtn.snp.right).offset(15)
                maker.width.equalTo(200)
                maker.height.equalTo(30)
            }
        )
        
//        dueTimeBtn.addTarget(self, action: #selector(seldueTime), for: .touchUpInside)
        
//        dueTimeLbl = UILabel()
//        dueTimeLbl.layer.cornerRadius = 5
//        self.view.addSubview(dueTimeLbl)
//        dueTimeLbl.snp.makeConstraints(
//            {(maker) in
//                maker.top.equalTo(line.snp.bottom).offset(5)
//                maker.left.equalTo(dueTimeBtn.snp.right).offset(5)
//                maker.right.equalTo(-30)
//                maker.height.equalTo(30)
//            }
//        )
        
        
        let lineMidle = UIView()
        self.view.addSubview(lineMidle)
        lineMidle.backgroundColor = UIColor.gray
        lineMidle.snp.makeConstraints(
            {(maker) in
                maker.top.equalTo(dueTimeBtn.snp.bottom).offset(5)
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
                maker.top.equalTo(lineMidle.snp.bottom).offset(10)
                maker.left.equalTo(30)
                maker.right.equalTo(-30)
                maker.bottom.equalTo(-30)
            }
        )
        oldRemindIdentifier = ""
        if !isNew{
            let indextitle = indexNote!["title"] as! String
            let indexContent = indexNote!["content"] as! String
            titleTextField?.text = indextitle
            bodyTextView?.text = indexContent
            
            let indexRemindTime = indexNote!["remindTime"] as! String
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm" // 设置日期格式
            if let date = formatter.date(from: indexRemindTime) {
//                indexDatePicker.date = date
                indexDatePicker.setDate(date, animated: true)
                oldRemindIdentifier = indextitle + date.description
            } else {
                print("无法将字符串转换为日期")
            }

            
        }
    }
    
}
