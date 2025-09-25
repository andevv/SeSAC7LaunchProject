//
//  FolderRepository.swift
//  SeSAC7LaunchProject
//
//  Created by andev on 9/25/25.
//

import Foundation
import RealmSwift

protocol JackRepository {
    
    associatedtype Item
    
    func create()
    func readItem() -> Item
    func readAllItemCount()
    func deleteItem()
}

final class FolderRepository: JackRepository {
    func create() {
        
    }
    
    func readItem() -> MoneyFolder {
        return readFolder(name: "동아리")
    }
    
    func readAllItemCount() {
        
    }
    
    func deleteItem() {
        
    }
    
    
    let realm = try! Realm()
    
    func createFolder(name: String) {
        
        let folder = MoneyFolder(name: name)
        
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("폴더 테이블에 저장 실패")
        }
        
    }
    
    func readFolder(name: String) -> MoneyFolder {
        let folder = realm.objects(MoneyFolder.self).where {
            $0.name == "동아리"
        }.first!
        
        return folder
    }
    
    func createMoney(title: String) {
        
        let account = Account(type: false, money: .random(in: 100...50000), title: title)
        
        let folder = readFolder(name: "동아리")
        
        do {
            try realm.write {
                folder.detail.append(account)
            }
        } catch {
            print("렘 데이터에 저장 실패")
        }
    }
    
    func readFolderAllCount() -> Int {
        return realm.objects(MoneyFolder.self).count
        
    }
    
    func readFolderList() -> [MoneyFolder] {
        return Array(realm.objects(MoneyFolder.self))
    }
    
    func createDummy() {
        
        if readFolderAllCount() == 0 {
            createFolder(name: "개인")
            createFolder(name: "회사")
            createFolder(name: "동아리")
            createFolder(name: "가족")
            
            createMoney(title: "대관비")
            createMoney(title: "스티커제작비용")
            createMoney(title: "음료수")
        }
    }
    
    
    
}
