//
//  StorageManager.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 30.08.2021.
//

import UIKit
import FirebaseStorage 

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage(url: "gs://instagram-383ed.appspot.com/").reference()
    
    enum StorageManagerError: Error {
        case failedToDownload
    }
    
    //MARK: Public
    
    func uploadUserPost(model: PhotoPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageManagerError.failedToDownload))
                return
            }
            
            completion(.success(url))
        }
    }
}

enum UserPostType {
    case photo, video
}

struct PhotoPost {
    let postType: UserPostType
}
