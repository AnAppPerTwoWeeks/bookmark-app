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
    
    var bookmarkArray = [BookmarkVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "북마크"
        
        if let savedBookmark = defaults.object(forKey: "bookmark") as? Data {
            if let loadedBookmark = try? JSONDecoder().decode([BookmarkVO].self, from: savedBookmark) {
                bookmarkArray = loadedBookmark
            }
        }

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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeCell = UIContextualAction(style: .destructive, title: "삭제") { (UIContextualAction, UIView, (Bool) -> Void) in
            self.bookmarkArray.remove(at: indexPath.row)
            self.setBookmarkUserDeafaults()
        }
        
        let fullSwipeAction = UISwipeActionsConfiguration(actions: [removeCell])
        fullSwipeAction.performsFirstActionWithFullSwipe = false
        
        return fullSwipeAction
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookmarkTableViewCell
        cell.nameLabel.text = bookmarkArray[indexPath.row].name
        cell.urlLabel.text = bookmarkArray[indexPath.row].url
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.bookmarkArray[indexPath.row].url
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var nameTextfield = UITextField()
        var urlTextfield = UITextField()
        
        let alert = UIAlertController(title: "북마크 추가", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (action) in
        }
        
        let addAction = UIAlertAction(title: "저장", style: .default) { (action) in
           
            if let nameText = nameTextfield.text, !nameText.isEmpty {
                if let urlText = urlTextfield.text, !urlText.isEmpty {
                    let bookmarkItem = BookmarkVO(name: nameText, url: urlText)
                    self.bookmarkArray.append(bookmarkItem)
                }
            }
            
            self.setBookmarkUserDeafaults()
            
        }
        
        alert.addTextField { (alertNameTextfield) in
            alertNameTextfield.placeholder = "북마크 이름을 입력해 주세요."
            nameTextfield = alertNameTextfield
        }
        
        alert.addTextField { (alertURLTextfield) in
            alertURLTextfield.placeholder = "URL을 입력해 주세요."
            urlTextfield = alertURLTextfield
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true)
        
    }
    
    func setBookmarkUserDeafaults() {
        if let encode = try? JSONEncoder().encode(self.bookmarkArray) {
            self.defaults.set(encode, forKey: "bookmark")
        }
        self.tableView.reloadData()
    }
}
