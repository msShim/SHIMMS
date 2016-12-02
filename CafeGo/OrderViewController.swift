//
//  OrderViewController.swift
//  Demo35-UIPageControl
//
//  Created by 남조선명지대학 on 2016. 10. 9..
//  Copyright © 2016년 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit
import CoreData

open class OrderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //피커뷰(주문창) 소스
    let dataContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var menu = tree
    var cafeMenu = [Coffee]()
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBAction func datePickerAction(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var strDate = dateFormatter.string(from: myDatePicker.date)
        self.selectedDate.text = strDate
        status.updateTime(order: strDate)
    }
    var timeSelect : [String] = []
    var minuteSelect : [String] = []
    var beverageSelect:[String] = []
    var countSelect = ["1","2","3","4"]
    var selectionArr = [[String]]()
    
    
    var registeredTime : [String] = [""]
    var registeredBeverage : [String] = []
    var registeredCount : [String] = []
    var registeredPrice : Int64 = 0
    var registeredArr = [[String]]()
    
    var nextIdx = Int()
    
    var deletePlanetIndexPath: IndexPath? = nil
    var alertMessage:String = ""

    //피커뷰 선택 값
    
    var timeData : String?
    var minuteData : String?
    var beverageData : String?
    var countData : String?
    var priceData : Int64?
    
    var a : String?
    var b : String?
    var c : String?
    
    var currentIdx = Int()
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return selectionArr.count;
    }
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedRecord: UITableView!
    
    @IBAction func order(_ sender: UIButton) {
        let alert = UIAlertController(title: "주문창", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let list : OrderListService = OrderListService()
        var orderMenuString: String = ""
        var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            UIAlertAction in
            if(status.getOrderList().orderBook == false){
                status.initOrder(order: "")
                status.initQuantity(order: "")
                for i in 0..<self.registeredBeverage.count{
                    status.updateOrder(order: self.registeredBeverage[i])
                    status.updateQuantity(order: self.registeredCount[i])
                }
                self.registeredArr.append(self.registeredBeverage)
                self.registeredArr.append(self.registeredCount)
                //시간 메뉴 예약 총액 카페이름 수량
                status.updateOrderNumber(order: self.registeredPrice)
                status.updateCafeName(order: "명지카페")
                if(status.getOrderList().orderNumber != 0){
                    status.updateOrderBook(book: true)
                }
                
                ServerManager.sendOrder(phoneNum: status.getOrderList().phoneNumber!, time: status.getOrderList().orderTime!, productName: status.getOrderList().orderMenu!, productCnt: status.getOrderList().orderQuantity!, total: status.getOrderList().orderNumber)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchStartViewControllers()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.switchStartViewControllers()
            }
        }
        //실험.
        print(list.get().orderMenu , list.get().phoneNumber,list.get().orderNumber)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(okAction)
    }
    
    
    
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        //시간 설정.
//        self.setTime()
        setMenuList()
        if(status.getOrderList().orderBook == true){
            alertMessage = "중복 예약은 불가합니다. 원하신다면 예약 취소 후 이용해 주세요."
        } else {
            alertMessage = "예약되었습니다. 감사합니다."
        }
        var todaysDate:NSDate = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var DateInFormat:String = dateFormatter.string(from: todaysDate as Date)
        self.selectedDate.text = DateInFormat
        status.updateTime(order: DateInFormat)
        selectionArr = [beverageSelect, countSelect]
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        //data들 초기화 안시켜주면 리스트 움직이지 않으면 데이터가 안 들어감.
//        timeData = timeSelect[pickerView.selectedRow(inComponent: 0)]
//        minuteData = minuteSelect[pickerView.selectedRow(inComponent: 1)]
        beverageData = beverageSelect[ pickerView.selectedRow(inComponent: 0)]
        countData = countSelect[pickerView.selectedRow(inComponent: 1)]
        // Do any additional setup after loading the view.
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //추가 이벤트
    
    func setMenuList(){
        for data in mCoffeeAll{
            self.beverageSelect.append(data.name!)
            self.cafeMenu.append(data)
        }
    }
    //시간 설정
    
//    func setTime(){
//        var time = 0
//        var minute = 0
//        for i in 8..<20 {
//            time = i + 1
//            self.timeSelect.append(String(time))
//        }
//        for i in 0..<12 {
//            minute = i * 5
//            self.minuteSelect.append(String(minute))
//        }
//    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectionArr[component][row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectionArr[component].count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        timeData = timeSelect[pickerView.selectedRow(inComponent: 0)]
//        minuteData = minuteSelect[pickerView.selectedRow(inComponent: 1)]
        beverageData = beverageSelect[ pickerView.selectedRow(inComponent: 0)]
        countData = countSelect[pickerView.selectedRow(inComponent: 1)]
    }
    
    /********** 테이블 뷰 ***************/
    //로우 수
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registeredBeverage.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! SelectedOrderTableViewCell
//        cell.timeLabel.text = registeredTime[0]
        cell.beverageLabel.text = registeredBeverage[indexPath.row]
        cell.countLabel.text = registeredCount[indexPath.row]
        return cell
    }
    //추가 버튼
    @IBAction func addButton(_ sender: UIButton) {
        var countSum = self.countSum()
        if(countSum>4){
            self.countAlert()
        }else{
            registeredCount.append(self.countData!)
//            registeredTime.append(self.timeData! + ":" + self.minuteData!)
            
            registeredBeverage.append(self.beverageData!)
            print(status.getOrderList().orderTime)
            
            registeredArr = [registeredBeverage, registeredCount]
            for i in 0..<cafeMenu.count{
                if(cafeMenu[i].name == beverageData){
                    priceData = Int64(cafeMenu[i].price!)
                }
            }
            registeredPrice = registeredPrice + priceData! * Int64(countData!)!
            priceLabel.text = String(self.registeredPrice)
            selectedRecord.reloadData()
        }
    }
    public func countSum() -> Int64{
        var countSum : Int64 = Int64(self.countData!)!
        for i in 0..<registeredCount.count{
            countSum = countSum + Int64(registeredCount[i])!
        }
        return countSum
    }
    public func countAlert(){
        let alert = UIAlertController(title: "공지", message: "예약은 총 4잔으로 제한됩니다.", preferredStyle: UIAlertControllerStyle.alert)
        let list : OrderListService = OrderListService()
        var orderMenuString: String = ""
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //드래그앤 드롭
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //딜리트
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePlanetIndexPath = indexPath
            
            self.confirmDelete()
        }
    }
    
    //딜리트 확인하는 팝업
    func confirmDelete() {
        let alert = UIAlertController(title: "항목 삭제", message: "정말 삭제?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "삭제", style: .destructive, handler: handleDeletePlanet)
        let CancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelDeletePlanet)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeletePlanet(_ alertAction: UIAlertAction!) -> Void {
        for i in 0..<cafeMenu.count{
            if(cafeMenu[i].name == registeredBeverage[(deletePlanetIndexPath?.row)!]){
                priceData = Int64(cafeMenu[i].price!)
            }
        }
        registeredPrice = registeredPrice - priceData! * Int64(registeredCount[(deletePlanetIndexPath?.row)!])!
        priceLabel.text = String(self.registeredPrice)
        registeredCount.remove(at: (deletePlanetIndexPath?.row)!)
        registeredBeverage.remove(at: (deletePlanetIndexPath?.row)!)
        registeredArr[0].remove(at: (deletePlanetIndexPath?.row)!)
        registeredArr[1].remove(at: (deletePlanetIndexPath?.row)!)
        deletePlanetIndexPath = nil
        selectedRecord.reloadData()
    }
    
    func cancelDeletePlanet(_ alertAction: UIAlertAction!) {
        deletePlanetIndexPath = nil
    }
}
