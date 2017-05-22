//
//  CatListingTableViewController.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import UIKit
import DataManager

class CatListingTableViewController: UITableViewController {

    fileprivate let kittyCell = "kittyCell"


    var cats: [Cat] = []

    var clientApi: APIClient?
  
    override func viewDidLoad() {
      guard let clientApi = self.clientApi else {
        return
      }
      
      clientApi.getCats { (cats, errors) in
        if let errors = errors {
          print(errors.localizedDescription)
          return
        }
        
        guard let cats = cats else {
          print("no error from api yet no cat was returned something is wrong")
          return
        }
        
        self.cats = cats
        self.tableView.reloadData()
      }
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: kittyCell, for: indexPath) as? KittyTableViewCell else {
        fatalError("Could not load kitty table view cell")
      }
      let cat = cats[indexPath.row]
      cell.caption.text = cat.caption
      cell.catName.text = cat.name
      
      return cell
    }

}
