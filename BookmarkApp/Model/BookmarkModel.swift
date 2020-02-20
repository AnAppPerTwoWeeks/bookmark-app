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
        getBookmarkArrayFromUserDefaults()
    }
    
    func getBookmarkAt(_ at: Int) -> Bookmark {
        return bookmarkArray[at]
    }
    
    func removeBookmarkByIndex(_ at: Int) {
        bookmarkArray.remove(at: at)
        setBookmarkArrayToUserDefaults()
    }
    
    func addBookmark(_ name: String, url: String) {
                let bookmark = Bookmark(name: name, url: url)
                self.bookmarkArray.append(bookmark)
                setBookmarkArrayToUserDefaults()
            }
        
    func editBookmarkAt(_ indexpath: Int, name: String, url: String) {
            let bookmark = Bookmark(name: name, url: url)
                bookmarkArray[indexpath] = bookmark
                setBookmarkArrayToUserDefaults()
    }

    func setBookmarkArrayToUserDefaults() {
        if let encode = try? JSONEncoder().encode(bookmarkArray) {
            UserDefaults.standard.set(encode, forKey: "bookmark")
        }
    }
    
    func getBookmarkArrayFromUserDefaults() {
        if let savedBookmark = UserDefaults.standard.object(forKey: "bookmark") as? Data {
            if let loadedBookmark = try? JSONDecoder().decode([Bookmark].self, from: savedBookmark) {
                self.bookmarkArray = loadedBookmark
            }
        }
    }
}
