//
//  SearchViewController.swift
//  CafeGo
//
//  Created by 남조선명지대학 on 2016. 11. 23..
//  Copyright © 2016년 SMS. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    @IBOutlet weak var tableView: UITableView!

    var filteredMenu = [Coffee]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK TABLE VIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.searchDisplayController?.searchResultsTableView){
            return self.filteredMenu.count
        } else {
            return mCoffeeAll.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as! SearchTableViewCell
        var menu:Coffee
        if(tableView == self.searchDisplayController?.searchResultsTableView){
            menu = self.filteredMenu[indexPath.row]
        }
        else{
            menu = mCoffeeAll[indexPath.row]
        }
        cell.cafeName.text = "명지카페"
        cell.menuName.text = menu.name
        ImageDownLoader.settingImg(string: mCoffeeAll[indexPath.row].img!, imgView: cell.img)
        cell.price.text = String(describing: menu.price!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var menu:Coffee
        if(tableView == self.searchDisplayController?.searchResultsTableView){
            menu = self.filteredMenu[indexPath.row]
        } else {
            menu = mCoffeeAll[indexPath.row]
        }
    }
    
    // mark: Search
    
    func filterContentForSearchText(searchText: String, scope: String = "Title"){
        self.filteredMenu = mCoffeeAll.filter({( menu:Coffee) -> Bool in
            var categoryMatch = (scope == "Title")
            var stringMatch = menu.name?.range(of: searchText)
            
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        self.filterContentForSearchText(searchText: searchString!, scope: "Title")
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(searchText: (self.searchDisplayController?.searchBar.text)!, scope:"Title")
        return true
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
