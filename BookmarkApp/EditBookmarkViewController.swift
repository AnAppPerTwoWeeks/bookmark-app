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
    
    var bookmarkArr = [BookmarkVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        nameLabel.text = "이름"
        urlLabel.text = "URL"
        editButton.setTitle("확인", for: .normal)
        
    }
    

        
    }



