//
//  ViewController.swift
//  CoreDataIdea
//
//  Created by yuki.pro on 2017. 8. 12..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UISearchBarDelegate {


    
    @IBOutlet weak var ideaText: UITextField!
    
    let keyword = "키워드" //테스트용 더미키워드

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButton(_ sender: Any) {
        
        CoreDataManager.addIdea(ideaTxt: ideaText.text!, keywordTxt: keyword, createDate: Date())
        ideaText.text = ""
        ideaText.resignFirstResponder()
        
    }

}

