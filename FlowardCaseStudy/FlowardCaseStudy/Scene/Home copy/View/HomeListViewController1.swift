//
//  HomeListViewController.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import UIKit

class HomeListViewController1: UIViewController {
    
    private enum Constants {
        static let movieCellIdentifier = "MovieListCell"
        static let retryImage : UIImage = UIImage(named: "retry") ?? UIImage()
        static let noDataErrorText = "Sorry, We are unable to load data this time..."
    }
    
    private var viewModel: HomeListViewModelProtocol
    
    private lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let errorConatiner: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.clipsToBounds = true
        stack.isHidden = true
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var errorlbl : UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.noDataErrorText
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private lazy var retryBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(Constants.retryImage, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(viewModel: HomeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

}

private extension HomeListViewController1 {
    
    func setup() {
        setUI()
        setupTableView()
        bindViewModel()
        viewModel.loadView()
    }
    
    func setUI() {
        
        view.backgroundColor = .white
        
        retryBtn.addTarget(self, action: #selector(didTapOnRetry), for: .touchUpInside)
        
        errorConatiner.addArrangedSubview(errorlbl)
        errorConatiner.addArrangedSubview(retryBtn)
        
        view.addSubview(errorConatiner)
        view.addSubview(tableview)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorConatiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorConatiner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorConatiner.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func setupTableView() {
      
        tableview.register(MovieListTableViewCell.self, forCellReuseIdentifier: Constants.movieCellIdentifier)
        tableview.tableFooterView = UIView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.applyGradient()
    }
    
    func bindViewModel() {
        
        viewModel.handleSuccess = { [weak self] in
            self?.setView(haveData: true)
            self?.tableview.reloadData()
        }
        
        viewModel.handleNoData = { [weak self] in
            self?.setView(haveData: false)
        }
        
        viewModel.handleError = { [weak self] (error) in
            self?.setView(haveData: false)
        }
        
        viewModel.startActivityView = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.stopActivityView = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func setView(haveData bool: Bool) {
        tableview.isHidden = !bool
        errorConatiner.isHidden = bool
    }
    
    @objc private func didTapOnRetry() {
        errorConatiner.isHidden = true
        viewModel.loadView()
    }
}

extension HomeListViewController1: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListTableViewCell
        else { return UITableViewCell() }
        cell.configureWithModel(viewModel.getCellConfigration(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOptions
    }
}
