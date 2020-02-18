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
    
    var indexpath = 0
    
    var bookmarkModel: BookmarkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        nameLabel.text = "이름"
        urlLabel.text = "URL"
        okButton.setTitle("확인", for: .normal)
        
        nameTextfield.text = bookmarkModel.get(indexpath).name
        urlTextfield.text = bookmarkModel.get(indexpath).url

    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        if (nameTextfield.text == "") || (urlTextfield.text == "") {
              let notice = UIAlertController(title: nil, message: "모든 텍스트 필드를 입력해주세요.", preferredStyle: .alert)
              present(notice, animated:true)
            
              Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                  self.dismiss(animated: true, completion: nil)
              }
        } else {
            bookmarkModel.editAt(indexpath, name: nameTextfield.text, url: urlTextfield.text)
            self.navigationController?.popViewController(animated: true)
        }

    }
}




