//
//  CoreDataManager.swift
//  CoreDataIdea
//
//  Created by yuki.pro on 2017. 8. 12..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager: NSObject {
    
    fileprivate class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    //MARK: - 아이디어 생성
    class func addIdea(ideaTxt: String, keywordTxt: String, createDate: Date) {
        
        let context = getContext()
        
        let newIdea = Idea(context: context)
        newIdea.ideaTxt = ideaTxt
        newIdea.keywordTxt = keywordTxt
        newIdea.createDate = createDate as NSDate
        
        try! context.save()
    }
    
    
    //MARK: - 아이디어 읽어서 아이디어 리스트 생성
    class func readIdeas(targetText: String? = nil) -> [Idea] {
        
        let context = getContext()
        
        let request : NSFetchRequest<Idea> = Idea.fetchRequest()
        
        //MARK: - 검색 조건 넣기
        if targetText != nil {
            
            // 검색 조건이 한개인 경우
            //let predicate = NSPredicate(format: "ideaTxt contains[c] %@", targetText!)
            
            // 검색 조건이 두개 이상인 경우
            // Swift 3 - OR
            let predicate1 = NSPredicate(format: "ideaTxt contains[c] %@", targetText!)
            let predicate2 = NSPredicate(format: "keywordTxt contains[c] %@", targetText!)
            let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1,predicate2])
            
            /* Swift 3 - AND
            let predicate1 = NSPredicate(format: "X == 1")
            let predicate2 = NSPredicate(format: "Y == 2")
            let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
            */

            request.predicate = predicateCompound
        }
        
        // 작성일 빠른순으로 정렬
        let sort = NSSortDescriptor(key: "createDate", ascending: false)
        request.sortDescriptors = [sort]
        
        let ideaList = try! context.fetch(request)
        
//        for idea in ideaList {
//            
//            let t = timeAgo.sinceDate(idea.createDate! as Date)
//            print(t)
//        }
        
        return ideaList
    }
    
    
    //MARK: - 수정
    class func updateIdea(updateID: Idea, ideaTxt: String) {
        
        let context = getContext()

        if updateID == getById(id: updateID.objectID) {
            updateID.ideaTxt = ideaTxt
            updateID.createDate = Date() as NSDate
        }
        try! context.save()
    }
    
    
    //MARK: - 삭제
    class func deleteIdea(indexPath: IndexPath) {
        
        let context = getContext()
        
        let request : NSFetchRequest<Idea> = Idea.fetchRequest()
        
        // 리스트 생성할때 정한 정렬 순서와 동일하게 맞춰줘야 올바르게 삭제됨
        let sort = NSSortDescriptor(key: "createDate", ascending: false)
        request.sortDescriptors = [sort]
        
        let ideaList = try! context.fetch(request)
        
        let deleteNo = ideaList[indexPath.row]
        context.delete(deleteNo)
        try! context.save()
    }
    
    
    //MARK: - 업데이트를 위한 오브젝트 아이디 가져오기
    class func getById(id: NSManagedObjectID) -> Idea {
        let context = getContext()
        return context.object(with: id) as! Idea
    }
    
    

    
    
}

