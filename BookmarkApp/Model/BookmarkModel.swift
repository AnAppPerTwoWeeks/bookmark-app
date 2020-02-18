//
//  BookmarkArray.swift
//  BookmarkApp
//
//  Created by 장창순 on 17/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import Foundation

class BookmarkModel {
    
    var bookmarkArray = [Bookmark]()
    
    var count : Int {
        get {
            bookmarkArray.count
        }
    }
    
    init() {
        getBookmarkFromUserDefaults()
    }
    
    func get(_ at: Int) -> Bookmark {
        return bookmarkArray[at]
    }
    
    func remove(_ at: Int) {
        bookmarkArray.remove(at: at)
        setBookmarkToUserDefaults()
    }
    
    func append(_ name: String?, url: String?) {
        if let nameText = name, !nameText.isEmpty {
            if let urlText = url, !urlText.isEmpty {
                let bookmark = Bookmark(name: nameText, url: urlText)
                self.bookmarkArray.append(bookmark)
                setBookmarkToUserDefaults()
            }
        }
    }
    
    func editAt(_ indexpath: Int, name: String?, url: String?) {
        let bookmark = Bookmark(name: name, url: url)
        bookmarkArray[indexpath] = bookmark
        setBookmarkToUserDefaults()
    }

    func setBookmarkToUserDefaults() {
        if let encode = try? JSONEncoder().encode(bookmarkArray) {
            UserDefaults.standard.set(encode, forKey: "bookmark")
        }
    }
    
    func getBookmarkFromUserDefaults() {
        if let savedBookmark = UserDefaults.standard.object(forKey: "bookmark") as? Data {
            if let loadedBookmark = try? JSONDecoder().decode([Bookmark].self, from: savedBookmark) {
                self.bookmarkArray = loadedBookmark
            }
        }
    }
}
