//
//  BookmarkArray.swift
//  BookmarkApp
//
//  Created by 장창순 on 17/02/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import Foundation

class BookmarkModel {
    
    private var bookmarkArray = [Bookmark]()
    private var directoryArray = [Directory]()
    
    var bookmarkArrayCount : Int {
        get {
            bookmarkArray.count
        }
    }
    
    var directoryArrayCount : Int {
        get {
            directoryArray.count
        }
    }
    
    init() {
        getBookmarkArrayFromUserDefaults()
        getDirectoryArrayFromUserDefaults()
    }
    
//MARK: - Bookmark Methods
    
    func getBookmarkFromBookmarkArray(_ at: Int) -> Bookmark {
        return bookmarkArray[at]
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
    
    func deleteBookmarkByIndex(_ index: Int) {
        bookmarkArray.remove(at: index)
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
    
//MARK: - Directory methods
    
    func getDirectoryAt(_ at: Int) -> Directory {
        return directoryArray[at]
    }
    
    func getBookmarkFromDirectory(_ at: Int) -> [Bookmark] {
        return directoryArray[at].getItems()
    }
    
    func getDirectoryName(_ at: Int) -> String {
        return directoryArray[at].getDirectoryName()
    }
    
    func addDirectory(_ name: String) {
        let direcrtory = Directory(name: name)
        directoryArray.append(direcrtory)
        setDirectoryArrayToUserDefaults()
    }
    
    func editDirectory(_ indexPath: Int, name: String) {
        let directory = Directory(name: name)
        directoryArray[indexPath] = directory
        setDirectoryArrayToUserDefaults()
        
    }
    
    func appendBookmarkToDirectory(directoryIndex: Int, bookmarkIndex: Int) {
        directoryArray[directoryIndex].addBookmark(bookmarkArray[bookmarkIndex])
        bookmarkArray.remove(at: bookmarkIndex)
        setBookmarkArrayToUserDefaults()
    }
    
    func addBookmarkToDirectory(directoryIndex: Int, bookmark: Bookmark) {
        directoryArray[directoryIndex].addBookmark(bookmark)
        setDirectoryArrayToUserDefaults()
        setBookmarkArrayToUserDefaults()
    }
    
    func deleteBookmarkFromDirectory(directoryIndex: Int, bookmarkIndex: Int) {
        directoryArray[directoryIndex].deleteBookmark(bookmarkIndex)
        setDirectoryArrayToUserDefaults()
        
    }
    
    func deleteDirectoryByIndex(_ index: Int) {
        for item in directoryArray[index].getItems() {
            bookmarkArray.append(item)
        }
        directoryArray.remove(at: index)
        setDirectoryArrayToUserDefaults()
        setBookmarkArrayToUserDefaults()
    }
    
    func setDirectoryArrayToUserDefaults() {
        if let encode = try? JSONEncoder().encode(directoryArray) {
            UserDefaults.standard.set(encode, forKey: "directory")
        }
    }
    
    func getDirectoryArrayFromUserDefaults() {
        if let savedDirectory = UserDefaults.standard.object(forKey: "directory") as? Data {
            if let loadedDirectory = try? JSONDecoder().decode([Directory].self, from: savedDirectory) {
                self.directoryArray = loadedDirectory
            }
        }
    }
}
