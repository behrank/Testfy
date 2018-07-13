//
//  MainViewController.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright (c) 2018 Be Moebil. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class
{
    func displayTweets(_ data:Main.FeedViewModel)
    func displayMoreTweets(_ data:Main.FeedViewModel)
    func displayLoading()
    func removeLoading()
}

class MainViewController: BaseViewController, MainDisplayLogic
{
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    var currentItemCount = 0
    var isClearBtnHit = false
    var isSearchActive = false
    var queryHolder = ""
    fileprivate let searchView = SearchView.fromNib()
    
    @IBOutlet weak var tableTweets: UITableView!
    
    // MARK: Object lifecycle
    var viewModel = [TweetModel]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MainWorker().doSetup(self)
    
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MainWorker().doSetup(self)
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        searchView.prepareUI()
        tableTweets.register(UINib(nibName: TWEETCELL, bundle: nil), forCellReuseIdentifier: TWEETCELL_REUSE)
        tableTweets.tableFooterView = nil
        interactor?.getToken()
        self.hideNavBarBorder()
        self.showLoading()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.titleView = searchView
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MainViewController {
    func displayTweets(_ data: Main.FeedViewModel) {
        viewModel = data.data ?? []
        
        DispatchQueue.main.async {
            self.tableTweets.reloadData {
                debugPrint("Tweets reloaded")
                self.popNetworkActivity()
                self.tableTweets.isHidden = false

            }
        }
    }
    func displayMoreTweets(_ data: Main.FeedViewModel) {
        
        tableTweets.setContentOffset(tableTweets.contentOffset, animated: false)

        if data.data?.count == 0 {
            return
        }
        
        var arr = [IndexPath]()
        let rowCount = tableTweets.numberOfRows(inSection: 0)
        
        for x in 0...data.data!.count-1 {
            arr.append(IndexPath(row: (rowCount + x), section: 0))
        }
        
        viewModel.append(contentsOf: data.data!)
        currentItemCount = currentItemCount + data.data!.count
        
        self.popNetworkActivity()
        DispatchQueue.main.async {
            self.tableTweets.insertRows(at: arr, with: UITableViewRowAnimation.none)
        }
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.count - 20
    }
    func displayLoading(){
        self.showLoading()
    }
    func removeLoading() {
        self.hideLoading()
    }
}
extension MainViewController:UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableTweets.dequeueReusableCell(withIdentifier: TWEETCELL_REUSE, for: indexPath) as! TweetCell
        cell.viewModel = viewModel[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentCell = cell as! TweetCell
        currentCell.imgUrl = viewModel[indexPath.row].user?.profileImageUrl
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetail(data: viewModel[indexPath.row])
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //Infinite loader
        if indexPaths.contains(where: isLoadingCell) {
            self.pushNetworkActivity()
            if isSearchActive {
                interactor?.getTweetsBySearch(Main.GetSearchFeed.Request.init(text: queryHolder, sinceTweetId: viewModel.last!.id!))
            }
            else{
                interactor?.getMoreFeed(Main.GetMoreFeed.Request.init(sinceTweetId: viewModel.last!.id!))
            }
        }
    }
    
}
extension MainViewController:SearchViewDelegate {
    func makeSearchWith(text: String) {
        if isClearBtnHit {
            tableTweets.reloadData()
            isClearBtnHit = false
            return
        }
        viewModel.removeAll()
        tableTweets.isHidden = true
        tableTweets.reloadData()
        queryHolder = text
        isSearchActive = true
        self.pushNetworkActivity()
        interactor?.getTweetsBySearch(Main.GetSearchFeed.Request.init(text: queryHolder))
    }
    
    func clearDataContainers() {
        self.tableTweets.backgroundView = nil
        isClearBtnHit = true
        viewModel.removeAll()
        tableTweets.reloadData()
        isSearchActive = false
        queryHolder = ""
        interactor?.getFeed()
    }
}
