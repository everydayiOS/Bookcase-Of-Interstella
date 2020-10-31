//
//  LetterController.swift
//  BookcaseOfInterstella
//
//  Created by Wonhee on 2020/10/31.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import Foundation
import RealmSwift

// TODO: 유효기간 지난 편지 삭제하기 -> 어느 타이밍에 삭제하지?
class LetterController {
    static let letter = LetterController()
    
    // TODO: 현재는 timestamp가 편지 쓸때인데 설정에 따라서 편지를 받아보는 시간에 따라서 timestamp 바꿔주고 validdate도 바꿔야함
    // timeStamp<= <validDate가 편지가 보이는 시간 -> 편지 쓸때
    // 편지 쓸때 timeStamp는 편지 쓴 날 기준 다음 편지 open 시간으로 저장
    // validDate는 timeStamp에 1일 더한 date로 저장
    // 편지 쓰기
    func writeLetter(_ contents: String, photo: UIImage?) {
        
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

    // timestamp에 따라 validDate 생성
    func createValid(_ now: Date) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        return Calendar.current.date(byAdding: dateComponents, to: now)
    }
    
    // 북마크 지정
    func setBookmark(_ validDate: Date) {
        let realm = try? Realm()
        
        let letter = realm?.objects(Letter.self).filter("validDate == \(validDate)").first
        try? realm?.write {
            letter?.isBookmarked = true
        }
    }
    
    // 북마크 해제
    func delBookmark(_ validDate: Date) {
        let realm = try? Realm()
        let letter = realm?.objects(Letter.self).filter("validDate == \(validDate)").first
        try? realm?.write {
            // 유효기간이 지난 편지 -> 삭제
            if validDate < Date() {
                guard let deleteLetter = letter else {
                    // TODO: thorw Error
                    return
                }
                realm?.delete(deleteLetter)
            }
            // 유효기간이 남은 편지 -> 북마크만 해제해서 임시보관함에서 부를 수 있음
            else {
                letter?.isBookmarked = false
            }
        }
    }
    
    // TODO: 오늘의 편지 없으면 명언 API에서 가져오기
    // 오늘의 편지 가져오기
    func getTodayLetter() -> Letter? {
        let realm = try? Realm()
        let today = Date()
        guard let letter = realm?.objects(Letter.self).filter("timeStamp <= \(today) AND \(today) < validDate").first
        else {
            // TODO: throw Error
            return nil
        }
        return letter
    }
    
    // 북마크 리스트 가져오기
    func getBookmarkList() -> [Letter]? {
        let realm = try? Realm()
        guard let letters = realm?.objects(Letter.self).filter("isBookmarked == true").sorted(byKeyPath: "validDate").toArray(ofType: Letter.self)
        else {
            // TODO: throw Error
            return nil
        }
        
        return letters
    }
    
    // 임시보관함 가져오기
    func getLetterList() -> [Letter]? {
        let realm = try? Realm()
        let today = Date()
        guard let letters = realm?.objects(Letter.self).filter("timeStamp <= \(today) AND \(today) < validDate AND isBookmarked == false").sorted(byKeyPath: "validDate").toArray(ofType: Letter.self)
        else {
            // TODO: throw Error
            return nil
        }
        return letters
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0..<count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
