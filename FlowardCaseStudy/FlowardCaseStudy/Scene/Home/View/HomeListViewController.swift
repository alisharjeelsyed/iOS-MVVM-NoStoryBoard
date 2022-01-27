//
//  HomeListViewController.swift
//  FlowardCaseStudy
//
//  Created by Sharjeel Ali on 23/08/2021.
//

import UIKit

class HomeListViewController: UIViewController {
    
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

private extension HomeListViewController {
    
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
        
        let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.view.frame.size.height, height: 200))
        view.backgroundColor = .brown
        tableview.tableHeaderView = view
        
        
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

extension HomeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListTableViewCell
        else { return UITableViewCell() }
        cell.configureWithModel(viewModel.getCellConfigration(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOptions
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .black
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Notification Times"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemRed
        
        headerView.addSubview(label)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //pushing up
    func tableView(_ tableView: UITableView,
                   didEndDisplayingHeaderView view: UIView,
                   forSection section: Int) {

        //lets ensure there are visible rows.  Safety first!
        guard let pathsForVisibleRows = tableView.indexPathsForVisibleRows,
            let lastPath = pathsForVisibleRows.last else { return }

        //compare the section for the header that just disappeared to the section
        //for the bottom-most cell in the table view
        if lastPath.section >= section {
            print("the next header is stuck to the top")
        }

    }

    //pulling down
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {

        //lets ensure there are visible rows.  Safety first!
        guard let pathsForVisibleRows = tableView.indexPathsForVisibleRows,
            let firstPath = pathsForVisibleRows.first else { return }

        //compare the section for the header that just appeared to the section
        //for the top-most cell in the table view
        if firstPath.section == section {
            print("the previous header is stuck to the top")
        }
    }
    
}
