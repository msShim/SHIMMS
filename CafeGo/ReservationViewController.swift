//
//  ReservationView.swift
//  CafeGo
//
//  Created by 5407-36 on 2016. 10. 30..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate{
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    @IBAction func cancel(_ sender: AnyObject) {
        for i in 0..<status.orderList.getAll().count{
            status.updateTime(order: "")
            status.initOrder(order: "")
            status.initQuantity(order: "")
            status.updateOrderNumber(order: 0)
            status.updateOrderBook(book: false)
            status.updatemCafeNumber(order: 0)
            orderNumber.text = ""
            
        }
        self.viewDidLoad()
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceView: UILabel!
    var reservationMenu : [String] = []
    var reservationtime : [String] = []
    var reservationQuantity : [String] = []
    var reservationPrice : [String] = []
    var listText : String = ""
    let list : OrderListService = OrderListService()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var deletePlanetIndexPath: IndexPath? = nil
    
    @IBAction func Back(_ sender: AnyObject) {
        appDelegate.switchStartViewControllers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backBtn = UIButton(type: .custom)
        backBtn.setTitle("뒤로가기", for: .normal)
        backBtn.addTarget(self, action: Selector(("backAction")), for: .touchUpInside)
        
        self.navigationController?.navigationBar.backItem?.title = "뒤로가기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        self.setReservation()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.priceView.text = String(list.get().orderNumber)
        self.reservationLabel.text = status.getOrderList().orderTime
        //오더 뷰에 가격 넣었습니다.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        orderNumber.text = String(status.getOrderList().mCafeNumber)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setReservation(){
        print(list.get().orderMenu, list.get().orderNumber, list.get().orderQuantity)
        
        if(status.getOrderList().orderBook == false){
            reservationMenu.append("예약 내역이 없습니다.")
            reservationMenu = []
            reservationtime = []
            reservationQuantity = []
            reservationPrice = []
        }else{
            var menu = list.get().orderMenu!
            var time = list.get().orderTime!
            var quantity = list.get().orderQuantity
            
            let a = menu.characters.split(separator: "|").map{ String($0)}
            let c = quantity.characters.split(separator: "|").map{String($0)}
            //오더 메뉴에 저장되어 있는 시간과 메뉴 끊어 주기 용
            for i in 0..<a.count
            {
                reservationMenu.append(a[i])
                print(reservationMenu)
                reservationQuantity.append(c[i])
                print(c.count)
            }
            //오더 넘버에다가 가격을 넣었슴다~
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationMenu.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservationCell", for: indexPath) as! ReservationViewCell
     
        cell.reservationLabel.text = reservationMenu[indexPath.row]
        cell.quantityLabel.text = reservationQuantity[indexPath.row]
        return cell
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletePlanetIndexPath = indexPath
            
            self.confirmDelete()
        }
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "항목 삭제", message: "정말로 예약을 취소하시겠습니까?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "취소", style: .destructive, handler: handleDeletePlanet)
        let CancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelDeletePlanet)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeletePlanet(_ alertAction: UIAlertAction!) -> Void {
        reservationMenu.remove(at: (deletePlanetIndexPath?.row)!)
        list.deleteStatus(id: list.get().objectID)
        list.saveChanges()
        print(list.get().cafeName)
        tableView.reloadData()
    }
    
    func cancelDeletePlanet(_ alertAction: UIAlertAction!) {
        deletePlanetIndexPath = nil
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
