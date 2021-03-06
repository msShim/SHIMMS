//
//  MoreViewController.swift
//  Demo35-UIPageControl
//
//  Created by 남조선명지대학 on 2016. 10. 11..
//  Copyright © 2016년 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UIPickerViewDelegate, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var starPicker: UIPickerView!
    
    @IBOutlet weak var cafeimg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var textfield: UITextField!
    
    var registeredText : [String] = []
    var registeredStar : [String] = []
    var starData : String = ""
    var star = ["★★★★★","★★★★☆","★★★☆☆","★★☆☆☆","★☆☆☆☆"]
    var deletePlanetIndexPath: IndexPath? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBAction func Back(_ sender: AnyObject) {
        appDelegate.switchStartViewControllers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.starPicker.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textfield.delegate = self
        
        tableView.reloadData()
        starData = star[starPicker.selectedRow(inComponent:0)]
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MoreViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        ServerManager.viewController = self
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        textfield.resignFirstResponder()
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MReple.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starCell", for: indexPath) as! moreSelectedCell
        cell.starlabel.text = MReple[indexPath.row].Score
        cell.textlabel.text = MReple[indexPath.row].Body
        return cell
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let data = star[row]
        let stars = NSAttributedString(string: data, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.init(red: 1, green: 9/255, blue: 162/255, alpha: 1)])
        return stars
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int ) -> String? {
        return star[row]
    }
    
   
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return star.count
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        starData = star[pickerView.selectedRow(inComponent: 0)]
    }
//    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            deletePlanetIndexPath = indexPath
//            
//            self.confirmDelete()
//        }
//    }
    
//    func confirmDelete() {
//        let alert = UIAlertController(title: "항목 삭제", message: "정말 삭제?", preferredStyle: .actionSheet)
//        let DeleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: handleDeletePlanet)
//        let CancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelDeletePlanet)
//        
//        alert.addAction(DeleteAction)
//        alert.addAction(CancelAction)
//        
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
//        
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    func handleDeletePlanet(_ alertAction: UIAlertAction!) -> Void {
//        
//        registeredStar.remove(at: (deletePlanetIndexPath?.row)!)
//        registeredText.remove(at: (deletePlanetIndexPath?.row)!)
//        
//        tableView.reloadData()
//    }
//    
//    func cancelDeletePlanet(_ alertAction: UIAlertAction!) {
//        deletePlanetIndexPath = nil
//    }
    
    @IBAction func submit(_ sender: UIButton) {
        var reple = Reple()
        reple.Body = self.textfield.text!
        reple.Score = self.starData
        MReple.insert(reple, at: 0)
//        reple?.CafeId = "1"
//        reple?.CreatAt = ""
//        reple?.Phone = status.getOrderList().phoneNumber
        ServerManager.sendScore(star: self.starData, text: self.textfield.text!, cafeID: "1")
        textfield.text?.removeAll()
        self.tableView.reloadData()
        
    }
}
