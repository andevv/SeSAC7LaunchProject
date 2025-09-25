//
//  RealmTable.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/17/25.
//

import Foundation
import RealmSwift
 
class MoneyFolder: Object {
    @Persisted(primaryKey: true) var id: ObjectId //PK index
    @Persisted var name: String //폴더명
    @Persisted var regdate: Date //폴더 생성일
    
    @Persisted var detail: List<Account>
    //폴더 테이블 안에 account 테이블이 들어 있는 구조
    //1:N Relationship (To-many Relationship)
    
    @Persisted var memo: Memo? //항상 옵셔널 선언. Memo 테이블이 생기지는 않음.
    @Persisted var card: Card?
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
        self.regdate = Date()
    }
}

// 가계부 : 금액, 내역, 날짜, 장소, 카테고리, 수입지출여부, 카드현금
class Account: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId //PK index
    
    @Persisted var type: Bool // 필수, 수입 true, 지출 false
    @Persisted var money: Int // 금액, int, 필수
    @Persisted var title: String //내용
 
    convenience init(type: Bool, money: Int, title: String) {
        self.init()
        self.type = type
        self.money = money
        self.title = title
    }
}
 
class Memo: EmbeddedObject {
    @Persisted var memoContents: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
    
    convenience init(memoContents: String, regDate: Date, editDate: Date) {
        self.init()
        self.memoContents = memoContents
        self.regDate = regDate
        self.editDate = editDate
    }
}
  
class Card: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
