//
//  Letter.swift
//  BookcaseOfInterstella
//
//  Created by Wonhee on 2020/10/30.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Letter : Object {
    @objc dynamic var validDate: Date       = Date()
    @objc dynamic var contents: String      = ""
    @objc dynamic var timestamp: Date       = Date()
    @objc dynamic var photo: Data?          = nil
    @objc dynamic var isBookmarked: Bool    = false
    
//    override static func primaryKey() -> String? {
//        return "validDate"
//    }
    
    // 편지 가져오기
    
    // 북마크 변경
    
    // 편지 삭제하기
}
