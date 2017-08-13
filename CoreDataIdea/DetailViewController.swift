//
//  DetailViewController.swift
//  CoreDataIdea
//
//  Created by yuki.pro on 2017. 8. 13..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var ideaList : Idea!
    
    @IBOutlet weak var ideaDetailText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ideaDetailText.text = ideaList.ideaTxt
        
    }

    

    @IBAction func editButton(_ sender: Any) {
        
        CoreDataManager.updateIdea(updateID: ideaList, ideaTxt: ideaDetailText.text)
    }

    
}
