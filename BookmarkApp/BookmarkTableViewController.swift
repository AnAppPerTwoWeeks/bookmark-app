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
    
    var selectedCellindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "북마크"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBookmarkUserDefaults()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkArray.count
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeCell = UIContextualAction(style: .destructive, title: "삭제") { (UIContextualAction, UIView, (Bool) -> Void) in
            self.bookmarkArray.remove(at: indexPath.row)
            self.setBookmarkUserDefaults()
        }
        
        let editCell = UIContextualAction(style: .normal, title: "편집") { (UIContextualAction, UIView, (Bool) -> Void) in
            let bookmark: BookmarkVO!
            bookmark = self.bookmarkArray[indexPath.row]
            self.selectedCellindex = indexPath.row
            self.performSegue(withIdentifier: "editSegue", sender: bookmark)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [removeCell, editCell])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
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
        
        let alert = UIAlertController(title: nil, message: "URL이 복사 되었습니다.", preferredStyle: .alert)
        present(alert, animated:true)
      
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
        
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
            
            self.setBookmarkUserDefaults()
            
        }
        
        alert.addTextField { (alertNameTextfield) in
            alertNameTextfield.placeholder = "북마크 이름을 입력해 주세요."
            nameTextfield = alertNameTextfield
        }
        
        alert.addTextField { (alertURLTextfield) in
            alertURLTextfield.placeholder = "URL을 입력해 주세요."
            if let copiedText = UIPasteboard.general.string {
                alertURLTextfield.text = copiedText
            }
            urlTextfield = alertURLTextfield
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true)
        
    }
    
    func getBookmarkUserDefaults() {
        if let savedBookmark = defaults.object(forKey: "bookmark") as? Data {
            if let loadedBookmark = try? JSONDecoder().decode([BookmarkVO].self, from: savedBookmark) {
                bookmarkArray = loadedBookmark
            }
        }
        self.tableView.reloadData()
    }
    
    func setBookmarkUserDefaults() {
        if let encode = try? JSONEncoder().encode(self.bookmarkArray) {
            self.defaults.set(encode, forKey: "bookmark")
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
                if let editCell = segue.destination as? EditBookmarkViewController {
                    if let item = sender as? BookmarkVO {
                        editCell.bookmark = item
                        editCell.EditedBookmarkArray = bookmarkArray
                        editCell.indexpath = selectedCellindex
                }
            }
        }
    }
}
