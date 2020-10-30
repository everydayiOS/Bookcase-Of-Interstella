//
//  DataController.swift
//  BookcaseOfInterstella
//
//  Created by Wonhee on 2020/10/31.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import Foundation
import RealmSwift

class DataController {
    
    // 편지 쓰기
    func write(_ contents: String, photo: UIImage?) {
        
        let letter = Letter()
        letter.contents = contents
        letter.validDate = createValid(letter.timestamp) ?? Date()
        if let image = photo {
            letter.photo = image.jpegData(compressionQuality: 0.01) ?? Data()
        }
        
        let realm = try? Realm()
        
        try? realm?.write {
            realm?.add(letter)
        }
    }

    func createValid(_ now: Date) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        return Calendar.current.date(byAdding: dateComponents, to: now)
    }
}
