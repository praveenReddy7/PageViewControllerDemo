//
//  CLTabBarPageViewController.swift
//  PageViewControllerDemo
//
//  Created by praveen on 6/28/19.

import UIKit

protocol ITabBarPageViewCtlDelegate {
    func didSelectTabBar(_ tabBarPage: CLTabBarPageViewController, at indexPath: IndexPath, navigationDirection: UIPageViewController.NavigationDirection)
    func setPageViewController(_ pageViewCtl: CLPageViewController, at index: Int) -> UIViewController?
}

class CLTabBarPageViewController: UIViewController {
    let pages: [String]
    var segmentedControl: CLSegmentedControl!
    var pageViewController: CLPageViewController!
    var tabBarPageDelegate: ITabBarPageViewCtlDelegate?
    
    init(pages: [String]) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl = CLSegmentedControl(title: pages)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.segmentDelegate = self
        view.addSubview(segmentedControl)
        
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pageViewController = CLPageViewController(pageCount: pages.count)
        pageViewController.pageViewDelegate = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CLTabBarPageViewController: ISegmentDelegate {
    func didSelectSegmentedControl(_ segmentedControl: CLSegmentedControl, at indexPath: IndexPath) {
        let previousIndex = self.segmentedControl.selectedIndex
        tabBarPageDelegate?.didSelectTabBar(self,
                                            at: indexPath,
                                            navigationDirection: (indexPath > previousIndex) ? .forward : .reverse)
    }
}

extension CLTabBarPageViewController: IPageDelegate {
    
    func setViewController(at index: Int) -> UIViewController? {
        return tabBarPageDelegate?.setPageViewController(self.pageViewController, at: index)
    }
    
    func didMovePageViewController(_ pageViewController: CLPageViewController, to index: Int) {
        self.segmentedControl.selectedTabBarChanged(to: IndexPath(item: index, section: 0))
    }
}
