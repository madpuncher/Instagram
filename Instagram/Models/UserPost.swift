//
//  UserPost.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 12.09.2021.
//

import Foundation

enum UserPostType: String{
    case photo = "Photo"
    case video = "Video"
}

enum Gender {
    case male, female
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

struct UserPost {
    let id: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // video or full photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let postedDate: Date
    let taggedUsers: [User]
    let owner: User
}

struct PostComment {
    let id: String
    let username: String
    let comment: String
    let createdDate: Date
    let likes: [CommentLike]
}



struct PostLike {
    let username: String
    let postId: String
}

struct CommentLike {
    let username: String
    let commentId: String
}
