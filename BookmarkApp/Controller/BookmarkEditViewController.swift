//
//  BMEditVC.swift
//  BookmarkApp
//
//  Created by 장창순 on 16/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class BookmarkEditViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var urlTextfield: UITextField!
    
    var bookmarkName = ""
    var bookmarkURL = ""
    var indexpath = 0
    
    var bookmark = Bookmark()
    var EditedBookmarkArray = [Bookmark]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        nameLabel.text = "이름"
        urlLabel.text = "URL"
        editButton.setTitle("확인", for: .normal)
        
        nameTextfield.text = EditedBookmarkArray[indexpath].name
        urlTextfield.text = EditedBookmarkArray[indexpath].url

    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        bookmark.name = nameTextfield.text
        bookmark.url = urlTextfield.text
        EditedBookmarkArray[indexpath] = bookmark
        if let encode = try? JSONEncoder().encode(self.EditedBookmarkArray) {
            UserDefaults.standard.set(encode, forKey: "bookmark")
        }
        self.navigationController?.popViewController(animated: true)
    }
}



