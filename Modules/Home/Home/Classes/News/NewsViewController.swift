//
//  NewsViewController.swift
//  Home
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import UIKit
import Common
import SnapKit
import RxSwift
import Kingfisher
import SkeletonView

class NewsViewController: UIViewController {
    public var viewModel: NewsViewModel!
    
    private let disposeBag = DisposeBag()
    private var newsArray: [News] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isSkeletonable = true
        return tableView
    }()
    
    private let searchView = UIView()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.font = Fonts.medium(size: 13)
        searchBar.searchTextField.textColor = Colors.black
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindViewModel()
        initData()
    }
    
    @objc private func refreshData() {
        viewModel.input.refresh.onNext(())
    }
}

extension NewsViewController: BaseViewController {
    public typealias ViewModel = NewsViewModel
    
    public func bindViewModel() {
        viewModel
            .output
            .newsArray
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] (newsArray, page) in
                    guard let self = self else {
                        return
                    }
                    if page == 1 {
                        self.newsArray = newsArray
                    } else {
                        self.newsArray.append(contentsOf: newsArray)
                    }
                    self.tableView.reloadData()
                    if self.newsArray.isEmpty {
                        self.tableView.backgroundView = NewsEmptyView()
                    } else {
                        self.tableView.backgroundView = nil
                    }
                }, onError: { [weak self] error in
                    self?.showAlert(message: error.localizedDescription)
                }
            ).disposed(by: disposeBag)
        
        viewModel
            .output
            .showLoading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] isShow in
                    if isShow {
                        self?.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                        self?.tableView.showAnimatedGradientSkeleton()
                    } else {
                        self?.tableView.hideSkeleton()
                    }
                }
            ).disposed(by: disposeBag)
    }
    
    public func setupViews() {
        title = "News"
        
        view.backgroundColor = .white
        [searchView, tableView].forEach {
            view.addSubview($0)
        }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.refreshControl = refreshControl
        tableView.estimatedRowHeight = 316
        
        searchView.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.leading.equalTo(8)
            make.trailing.bottom.equalTo(-8)
            make.height.equalTo(40)
        }
    }
    
    public func initData() {
        viewModel.input.searchText.onNext(nil)
    }
}

extension NewsViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(newsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsTableViewCell"
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.onNextDetail.onNext(newsArray[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // if only half of screen height until bottom => loadmore
        if scrollView.contentOffset.y + (scrollView.bounds.height * 3 / 2) > scrollView.contentSize.height {
            viewModel.input.loadmore.onNext(())
        }
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.searchText.onNext(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        viewModel.input.searchText.onNext(nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

