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
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var urlTextfield: UITextField!
    
    var bookmarkName = ""
    var bookmarkURL = ""
    var indexpath = 0
    
    var bookmarkModel: BookmarkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        nameLabel.text = "이름"
        urlLabel.text = "URL"
        okButton.setTitle("확인", for: .normal)
        
        nameTextfield.text = bookmarkModel.bookmarkArray[indexpath].name
        urlTextfield.text = bookmarkModel.bookmarkArray[indexpath].url

    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        let bookmark = Bookmark(name: nameTextfield.text, url: urlTextfield.text)
        bookmarkModel.bookmarkArray[indexpath] = bookmark
        if let encode = try? JSONEncoder().encode(self.bookmarkModel.bookmarkArray) {
            UserDefaults.standard.set(encode, forKey: "bookmark")
        }
        self.navigationController?.popViewController(animated: true)
    }
}




