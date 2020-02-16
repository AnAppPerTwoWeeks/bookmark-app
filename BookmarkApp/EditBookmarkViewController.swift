//
//  EditBookmarkViewController.swift
//  BookmarkApp
//
//  Created by 장창순 on 16/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class EditBookmarkViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var urlTextfield: UITextField!
    
    let defaults = UserDefaults.standard
    
    var bookmarkName = ""
    var bookmarkURL = ""
    var indexpath = 0
    
    var bookmark = BookmarkVO()
    var EditedBookmarkArray = [BookmarkVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        nameLabel.text = "이름"
        urlLabel.text = "URL"
        editButton.setTitle("확인", for: .normal)
        
        nameTextfield.text = bookmark.name
        urlTextfield.text = bookmark.url

    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        bookmark.name = nameTextfield.text
        bookmark.url = urlTextfield.text
        EditedBookmarkArray[indexpath] = bookmark
        if let encode = try? JSONEncoder().encode(self.EditedBookmarkArray) {
            self.defaults.set(encode, forKey: "bookmark")
        }
        self.navigationController?.popViewController(animated: true)
    }
}



