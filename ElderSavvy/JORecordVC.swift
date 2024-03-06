//
//  JORecordVC.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/25.
//

import UIKit

class JORecordVC: UIViewController {

    var index:Int?
    var tempAllDataAry:NSMutableArray?
    
    var selindexNote:NSDictionary!
    var selisNew = false
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "要事记录"
        let tempDateDataAry = NSMutableArray()
        if let tempAry = UserDefaults.standard.value(forKey: "noteListAry") as? Array<Dictionary<String, String>> {
            tempDateDataAry.addObjects(from: tempAry)
            tempAllDataAry = tempDateDataAry
        }else{
            tempAllDataAry = NSMutableArray()
        }
        
        
        index = 0;
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        installNavgationItem()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = false
        let tempDateDataAry = NSMutableArray()
        if let tempAry = UserDefaults.standard.value(forKey: "noteListAry") as? Array<Dictionary<String, String>> {
            tempDateDataAry.addObjects(from: tempAry)
            tempAllDataAry = tempDateDataAry
        }else{
            tempAllDataAry = NSMutableArray()
        }
        self.tableview.reloadData()
    }
    func installNavgationItem(){
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
//        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deteleGroup))
        self.navigationItem.rightBarButtonItems = [addItem]
        
    }
    @objc func addNote(){
        selisNew = true
        performSegue(withIdentifier: "noteDetailVC", sender: nil)
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


extension JORecordVC:UITableViewDelegate,UITableViewDataSource{
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return tempAllDataAry?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cellID = "noteListCellID"
            var  cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            if cell == nil{
                cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
            }
            cell?.selectionStyle = .none
            let indexdic = tempAllDataAry?[indexPath.section] as? Dictionary<String, String>
            if indexdic != nil {
                let indexStr = indexdic?["title"] as? String
                let contentStr = indexdic?["content"] as? String
                cell?.textLabel?.text = indexStr
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 25)
                cell?.detailTextLabel?.text = contentStr
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 25)
                cell?.accessoryType = .disclosureIndicator
                cell?.contentView.backgroundColor = UIColor.clear;
                cell?.backgroundColor = UIColor.clear;
            }
            
            return cell!
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.1
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footfghhererView = UIView()
            footfghhererView.backgroundColor = UIColor.white
            return footfghhererView
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selindexNote = (tempAllDataAry![indexPath.section] as! NSDictionary)
            performSegue(withIdentifier: "noteDetailVC", sender: nil)
        }
    
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteDetailVC" {
                if let destinationVC = segue.destination as? JONoteDetailVC {
                    destinationVC.isNew = selisNew
                    if !selisNew {
                        destinationVC.indexNote = selindexNote
                    }
                }
            }
    }
}
