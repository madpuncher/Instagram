//
//  AuthManager.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //MARK: Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { success in
            if success {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { success in
                        if success {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        
        if let email = email {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
}
