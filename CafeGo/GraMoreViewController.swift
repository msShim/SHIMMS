//
//  GraMoreViewController.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 11. 16..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class GraMoreViewController: UIViewController, UIPickerViewDelegate, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    
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
        tableView.reloadData()
        self.textfield.delegate = self
        starData = star[starPicker.selectedRow(inComponent:0)]
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MoreViewController.dismissKeyboard))
        self.starPicker.tintColor = UIColor(red: 252, green: 90, blue: 141, alpha: 0)
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
    private func textFieldShouldReturn(userText: UITextField!) -> Bool {
        textfield.resignFirstResponder()
        return true;
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let data = star[row]
        let stars = NSAttributedString(string: data, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.init(red: 1, green: 9/255, blue: 162/255, alpha: 1)])
        return stars
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registeredStar.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GraStarCell", for: indexPath) as! GraTableViewCell
        cell.starlabel.text = registeredStar[indexPath.row]
        cell.textlabel.text = registeredText[indexPath.row]
        return cell
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return star[row]
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return star.count
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        starData = star[pickerView.selectedRow(inComponent: 0)]
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        registeredStar.append(self.starData)
        registeredText.append(self.textfield.text!)
        ServerManager.sendScore(star: self.starData, text: self.textfield.text!)
        textfield.text?.removeAll()
        self.tableView.reloadData()
        
    }
}
