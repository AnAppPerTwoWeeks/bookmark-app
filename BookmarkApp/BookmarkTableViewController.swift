//
//  BookmarkTableViewController.swift
//  BookmarkApp
//
//  Created by 장창순 on 11/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class BookmarkTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    var bookmarkArray = ["http://google.com","http://daum.net","http://naver.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "북마크"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookmarkArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookmarkTableViewCell
        cell.bookmarkLabel.text = bookmarkArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var urlTextfield = UITextField()
        
        let alert = UIAlertController(title: "북마크 추가", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (action) in
            
        }
        
        let addAction = UIAlertAction(title: "저장", style: .default) { (action) in
            if let newItem = urlTextfield.text {
                self.bookmarkArray.append(newItem)
            }
            self.defaults.set(self.bookmarkArray, forKey: "bookmark")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertNameTextfield) in
            alertNameTextfield.placeholder = "북마크 이름을 입력해 주세요."
        }
        
        alert.addTextField { (alertURLTextfield) in
            alertURLTextfield.placeholder = "URL을 입력해 주세요."
            urlTextfield = alertURLTextfield
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true)
        
    }
}
