//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import FirebaseDatabase
import Foundation

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let dataBase = Database.database(url: "https://instagram-383ed-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    //MARK: Public
    
    /// Check if username and email is avialable
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        dataBase.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil  {
                // succeeded
                completion(true)
                return
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
    
}
