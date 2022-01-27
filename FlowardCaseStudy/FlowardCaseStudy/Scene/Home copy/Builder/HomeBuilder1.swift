//
//  HomeBuilder.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import UIKit

class HomeBuilder1 {

    func build(navBar: BaseNavigationController) -> UIViewController {
        let homeVM = HomeListViewModel(network: MovieStroeServiceImpl())
        let homeLisVC = HomeListViewController(viewModel: homeVM)
        return homeLisVC
    }
}
