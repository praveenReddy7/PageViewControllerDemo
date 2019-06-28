//
//  CLLIstViewController.swift
//  PageViewControllerDemo
//
//  Created by praveen on 6/27/19.

import UIKit


class CLListViewController: UIViewController, IPageController {
    var pageIndex: Int = 0
    let text: String
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No records to display \(text)"
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 240).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
