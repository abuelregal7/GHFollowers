//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Ahmed on 6/23/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    
    func didRequestFollowers(for username: String)
    
}

class FollowerListVC: UIViewController {

    enum Section {
        case main
    }
    
    //var followers: Follower!
    var followers: [Follower] = []
    var filteredFollower: [Follower] = []
    var username: String!
    var page            = 1
    var hasMoreFollower = true
    var isSearching     = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title         = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
        
                
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        //UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func configureViewController() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor                                   = UIColor.systemBackground
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func addButtonTapped() {
        
        print("add button tapped")
        
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
                
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        
                        self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        print("add button tapped//success//")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
                    print("add button tapped//error//")
                }
                
            case .failure(let error):
                
                self.presentGFAlertOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }

    func configureCollectionView() {
        
        //init collectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.creatThreeColumnFlowLayout(in: view))
        //add collectionView
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func configureSearchController() {
        
        let searchContoller                                   = UISearchController()
        searchContoller.searchResultsUpdater                  = self
        searchContoller.searchBar.delegate                    = self
        searchContoller.searchBar.placeholder                 = "Search for a username"
        searchContoller.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                       = searchContoller
        
    }
    
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            
           
            
            guard let self = self else { return }
            
            //#warning("Call Dismiss")
            self.dismissLoadingView()
            
            switch result{
                
            case .success(let followers):
                
                print("Followers.count = \(followers.count)")
                print(followers)
                
                if followers.count < 100 {
                    
                    self.hasMoreFollower = false
                    
                }
                
                //self.followers = followers
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                    
                }
                self.updateData(on: self.followers)
                
                
            case .failure(let error):
                
                self.presentGFAlertOnMainThread(title: "bad stuff happend", message: error.rawValue, buttonTitle: "OK")
                
            }
        }
    }
    func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
        
    }
    
    func updateData(on followers: [Follower]) {
        
        var snapshat = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshat.appendSections([.main])
        snapshat.appendItems(followers)
        DispatchQueue.main.async {
            
            self.dataSource.apply(snapshat, animatingDifferences: true)
            
        }
        
        
    }

}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.height
        
        print("offsetY: \(offsetY)")
        print("contentHeight: \(contentHeight)")
        print("height: \(height)")
        
        //offsetY > contentHeight - (height - 100)
        if offsetY > contentHeight - height {
            
            guard hasMoreFollower else { return }
            page += 1
            getFollowers(username: username, page: page)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filteredFollower : followers
        let follower    = activeArray[indexPath.item]
        let desVC       = UserInfoVC()
        desVC.username  = follower.login
        desVC.delegate  = self
        let navController = UINavigationController(rootViewController: desVC)
        present(navController, animated: true, completion: nil)
        
    }
    
}
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        isSearching = true
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollower = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollower)
            
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        print("Cancel")
        isSearching = false
        updateData(on: self.followers)
    }
    
}

extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        // get followers for that user
        self.username  = username
        title          = username
        page           = 1
        followers.removeAll()
        filteredFollower.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
}
