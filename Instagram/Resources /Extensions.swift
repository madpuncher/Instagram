//
//  Extensions.swift
//  Instagram
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 03.09.2021.
//

import Foundation

extension String {
    func safeDatabaseKey() -> String {
        self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
