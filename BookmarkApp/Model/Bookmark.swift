//
//  BMModel.swift
//  BookmarkApp
//
//  Created by 장창순 on 14/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import Foundation

struct Bookmark : Codable {
    private var name : String
    private var url : String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct Directory: Codable {
    var name: String
    var bookmarks: [Bookmark]
    
    func getItems() -> [Bookmark] {
        return bookmarks
    }

}


