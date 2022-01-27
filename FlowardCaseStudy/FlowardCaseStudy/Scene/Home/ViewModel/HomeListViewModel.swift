//
//  HomeListViewModel.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import Foundation

protocol HomeListViewModelProtocol: class {
    
    func loadView()
    func getCellConfigration(indexPath: IndexPath) -> Item
    func willDisplayCell(indexPath: IndexPath)
    
    var numberOfOptions: Int { get }
    
    var startActivityView: (() -> Void)? { get set }
    var stopActivityView: (() -> Void)? { get set }
    
    var handleSuccess: (() -> Void)? { get set }
    var handleNoData: (() -> Void)? { get set }
    var handleError: ((String) -> Void)? { get set }
}

class HomeListViewModel: HomeListViewModelProtocol {
    
    private let network: MovieStroeService
    private var movieList : [Item] = []
    
    var startActivityView: (() -> Void)?
    var stopActivityView: (() -> Void)?
    
    var handleSuccess: (() -> Void)?
    var handleError: ((String) -> Void)?
    var handleNoData: (() -> Void)?
    
    init(network: MovieStroeService) {
        self.network = network
    }
}

extension HomeListViewModel {
    
    var numberOfOptions: Int {
        return movieList.count
    }
    
    func loadView() {

        startActivityView?()
        network.getProductList { [weak self] (result) in
            self?.stopActivityView?()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.handleSuccess(response: response)
            case .failure(let error):
                self.handleError?(error.localizedDescription)
            }
        }
    }
    
    func getCellConfigration(indexPath: IndexPath) -> Item {
        movieList[indexPath.row]
    }
    
    func willDisplayCell(indexPath: IndexPath) {
        
    }
}

private extension HomeListViewModel {
    
    func handleSuccess(response: BaseResponseEntity<MovieListResponse>) {
        guard let movieList = response.items,movieList.count > 0 else {
            handleNoData?()
            return
        }
        self.movieList = movieList
        handleSuccess?()
    }
}
