//
//  ViewController.swift
//  PageViewControllerDemo
//
//  Created by praveen on 6/27/19.


import UIKit

class ViewController: UIViewController {
   
    let titles = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarPageCtl = CLTabBarPageViewController(pages: titles)
        tabBarPageCtl.tabBarPageDelegate = self
        tabBarPageCtl.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(tabBarPageCtl)
        view.addSubview(tabBarPageCtl.view)
        tabBarPageCtl.didMove(toParent: self)
        
        tabBarPageCtl.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarPageCtl.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tabBarPageCtl.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarPageCtl.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40).isActive = true
        
        tabBarPageCtl.pageViewController.setViewControllers([pageContentViewController(at: 0)],
                                                            direction: .forward,
                                                            animated: true,
                                                            completion: nil)
        
    }
    
}

extension ViewController: ITabBarPageViewCtlDelegate {
    func didSelectTabBar(_ tabBarPage: CLTabBarPageViewController, at indexPath: IndexPath) {
        let previousIndex = tabBarPage.segmentedControl.selectedIndex
        tabBarPage.pageViewController.setViewControllers([pageContentViewController(at: indexPath.row)],
                                                         direction: (indexPath > previousIndex) ? .forward : .reverse, animated: true,
                                                         completion: nil)
    }
    
    func setPageViewController(_ pageViewCtl: CLPageViewController, at index: Int) -> UIViewController? {
        return self.pageContentViewController(at: index)
    }
    
    private func pageContentViewController(at index: Int) -> UIViewController {
        let vc = CLListViewController(text: titles[index])
        vc.pageIndex = index
        return vc
    }
    
    
}
