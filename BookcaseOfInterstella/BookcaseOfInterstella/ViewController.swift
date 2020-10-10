//
//  ViewController.swift
//  BookcaseOfInterstella
//
//  Created by Keunna Lee on 2020/09/17.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 글쓰기
    @IBAction func writeButtonDidTap(_ sender: Any) {
        
    }
    
    // 즐겨찾기 편지 목록
    @IBAction func bookmarkButtonDidTap(_ sender: Any) {
        
    }
    
    // 임시보관 편지 목록
    @IBAction func temporaryButtonDidTap(_ sender: Any) {
        
    }
    
    // 편지 도착 화면
    @IBAction func arrivalButtonDidTap(_ sender: Any) {
        let arrivalVC = ArrivalViewController(nibName: "ArrivalViewController", bundle: nil)
        // TODO - 데이터 설정
        present(arrivalVC, animated: true, completion: nil)
    }
    
    //설정
    @IBAction func settingButtonDidTap(_ sender: Any) {
        
    }
}
