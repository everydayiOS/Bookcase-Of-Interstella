//
//  ArrivalViewController.swift
//  BookcaseOfInterstella
//
//  Created by yurimac on 2020/10/06.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import UIKit

class ArrivalViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    var letterImage: UIImage?
    var letterContent: String?
    var letterTimestamp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.layer.cornerRadius = 8.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        image.image = letterImage
//        content.text = letterContent
//        timestamp.text = letterTimestamp
        
        content.sizeToFit()
        if content.frame.height < contentHeight.constant {
            contentHeight.constant = content.frame.height
        }
        print(content.frame)
    }
    
}
