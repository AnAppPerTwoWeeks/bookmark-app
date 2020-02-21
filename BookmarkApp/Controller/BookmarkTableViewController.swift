//
//  BMTableVC.swift
//  BookmarkApp
//
//  Created by 장창순 on 11/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

enum SectionType: Int {
    case directory
    case bookmark
}

class BookmarkTableViewController: UITableViewController {
    
    var bookmarkModel = BookmarkModel()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "북마크"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkModel.getSectionCount(index: section)
    }
    
    private func onRemoveAction(indexPath: IndexPath) {
        if indexPath.row == SectionType.directory.rawValue {
            self.bookmarkModel.deleteDirectoryByIndex(indexPath.row)
        } else {
            self.bookmarkModel.deleteBookmarkByIndex(indexPath.row)
        }
        self.tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeCell = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, (Bool) -> Void) in
            onRemoveAction(indexPath: indexPath)
        }
        if indexPath.section == 0 {
            let swipeAction = UISwipeActionsConfiguration(actions: [removeCell])
            swipeAction.performsFirstActionWithFullSwipe = false
            return swipeAction
        } else {
           
        
            
            let editCell = UIContextualAction(style: .normal, title: "편집") { (UIContextualAction, UIView, (Bool) -> Void) in
                self.performSegue("editSegue", indexPath.row)
            }
            
            let swipeAction = UISwipeActionsConfiguration(actions: [removeCell, editCell])
            swipeAction.performsFirstActionWithFullSwipe = false
            
            return swipeAction
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var directoryCell = DirectoryCell()
            if let cell = tableView.dequeueReusableCell(withIdentifier: "directoryCell", for: indexPath) as? DirectoryCell {
                directoryCell = cell
            }
            directoryCell.update(bookmarkModel.getDirectoryAt(indexPath.row))
            return directoryCell
        } else {
            var bookmarkCell = BookmarkCell()
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BookmarkCell {
                bookmarkCell = cell
        }
            bookmarkCell.update(bookmarkModel.getBookmarkFromBookmarkArray(indexPath.row))
            return bookmarkCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.performSegue(withIdentifier: "directorySegue", sender: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            UIPasteboard.general.string = bookmarkModel.getBookmarkFromBookmarkArray(indexPath.row).getBookmarkURL()
              
            let alert = UIAlertController(title: nil, message: "URL이 복사 되었습니다.", preferredStyle: .alert)
            present(alert, animated:true)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                self.dismiss(animated: true, completion: nil)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    @IBAction func addDirectoryButtonPressed(_ sender: Any) {
        
        var nameTextField = UITextField()
        
        let alert = UIAlertController(title: "폴더 생성", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (action) in
        }
        
        let addAction = UIAlertAction(title: "생성", style: .default) { (action) in
            if nameTextField.text != "" {
                if let name = nameTextField.text {
                    self.bookmarkModel.addDirectory(name)
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (alertNameTextfield) in
            alertNameTextfield.placeholder = "디렉토리의 이름을 입력해 주세요."
            nameTextField = alertNameTextfield
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        present(alert, animated: true)
    }
    
    @IBAction func addBookmarkButtonPressed(_ sender: UIBarButtonItem) {
        
        var nameTextfield = UITextField()
        var urlTextfield = UITextField()
        
        let alert = UIAlertController(title: "북마크 추가", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (action) in
        }
        
        let addAction = UIAlertAction(title: "저장", style: .default) { (action) in
            if (nameTextfield.text != "") && (urlTextfield.text != "") {
                if let name = nameTextfield.text , let url = urlTextfield.text {
                    self.bookmarkModel.addBookmark(name, url: url)
                    self.tableView.reloadData()
                }
            } else {
                let notice = UIAlertController(title: nil, message: "모든 텍스트 필드를 입력해주세요.", preferredStyle: .alert)
                self.present(notice, animated:true)
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                    self.dismiss(animated: true, completion: nil)
                    self.present(alert, animated:true)
                }
            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            if let editCell = segue.destination as? BookmarkEditViewController {
                if let index = sender as? Int {
                    let indexPath = index
                    editCell.setBookmarkModel(bookmarkModel)
                    editCell.setIndexpath(indexPath)
                }
            }
        } else if segue.identifier == "directorySegue" {
            if let directoryCell = segue.destination as? DirectoryTableViewController {
                if let index = sender as? Int {
                    let indexPath = index
                    directoryCell.setBookmarkModel(bookmarkModel)
                    directoryCell.setIndexpath(indexPath)
                }
            }
        }
    }
}
