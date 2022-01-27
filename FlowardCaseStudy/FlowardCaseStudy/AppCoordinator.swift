//
//  AppCoordinator.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import UIKit

class AppCoordinator {
    
    class func start(window: UIWindow?,
                     navBar: BaseNavigationController = BaseNavigationController()) {
        guard let window = window else { return }
        navBar.setAppearance()
        navBar.viewControllers = [getInitialRootVC(navBar: navBar)]
        window.rootViewController = navBar
        window.makeKeyAndVisible()
    }
    
    class func getInitialRootVC(navBar: BaseNavigationController) -> UIViewController {
        // Here we can add conditions,
        // if we have multiple options
        return HomeBuilder().build(navBar: navBar)
    }
}
