//
//  CLPageViewController.swift
//  PageViewControllerDemo
//
//  Created by praveen on 6/27/19.

import UIKit

protocol IPageDelegate {
    func setViewController(at index: Int) -> UIViewController?
    func didMovePageViewController(_ pageViewController: CLPageViewController, to index: Int)
}

class CLPageViewController: UIPageViewController {
    var pageViewDelegate: IPageDelegate?
    let pageCount: Int    
    
    init(pageCount: Int) {
        self.pageCount = pageCount
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    func setViewController(at index: Int) -> CLListViewController {
        if (pageCount == 0) || (index >= pageCount) {
            return CLListViewController()
        }
        let vc = CLListViewController()
        vc.pageIndex = index
        return vc
    }
    */
}

extension CLPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! IPageController
        var index = vc.pageIndex
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        return pageViewDelegate?.setViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! IPageController
        var index = vc.pageIndex
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if (index == pageCount) {
            return nil
        }
        return pageViewDelegate?.setViewController(at: index)
    }
}

extension CLPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageCount
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let pg = pendingViewControllers.first as! IPageController
        pageViewDelegate?.didMovePageViewController(self, to: pg.pageIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
}

/* To use CLPageViewController, we have to inherent the IPageController. */
protocol IPageController {
    var pageIndex: Int { get set }
}
