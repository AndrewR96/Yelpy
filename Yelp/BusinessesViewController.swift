//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{

    var businesses: [Business]!
    var filteredData: [Business]!
    var searchBar: UISearchBar!
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        filteredData = businesses
        
        
    Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
            
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

        // create the search bar programatically since you won't be
        // able to drag one onto the navigation bar
        
        
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        
        
        
        
        /* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
        // create the search bar programatically since you won't be
        // able to drag one onto the navigation bar
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if filteredData != nil{
        
            return filteredData!.count
        
        } else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
      
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty
        {
            filteredData = businesses
        }
        else
        {
            filteredData = businesses.filter({(dataItem: Business) -> Bool in
                if dataItem.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
                {
                    return true
                }
                else
                {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
