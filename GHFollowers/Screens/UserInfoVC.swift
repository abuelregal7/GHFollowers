//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Ahmed on 7/31/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGitFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView            = UIView()
    let itemViewOne           = UIView()
    let itemViewTwo           = UIView()
    var itemViews: [UIView]   = []
    let dateLable             = GFBodyLable(textAlignment: .center)
    
    var username: String!
    
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        print(username!)
        
        layouyUI()
        configureViewController()
        getUserInfo()
        
    }
    
    func configureViewController() {
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func getUserInfo() {
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result{
                
            case .success(let user):
                
                print(user)
                
                DispatchQueue.main.async {
                    
                    self.configureUIElements(with: user)
                    
                }
                
            case .failure(let error):
                
                self.presentGFAlertOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
        
    }
    
    func configureUIElements(with user: User) {
        
        
        let repoItemVC           = GFReposItemVC(user: user)
        repoItemVC.delegate      = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLable.text = "GitHub since \(user.createdAt.convertToDisplayformat())"
        
    }
    
    func layouyUI() {
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLable]
        for itemView in itemViews {
            
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
                
            ])
            
            
        }
//        view.addSubview(headerView)
//        view.addSubview(itemViewOne)
//        view.addSubview(itemViewTwo)
//
//        headerView.translatesAutoresizingMaskIntoConstraints  = false
//        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
//        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 20),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
            
        ])
        
    }
    
    func add(childVC: UIViewController, to ContainerView: UIView) {
        
        addChild(childVC)
        ContainerView.addSubview(childVC.view)
        childVC.view.frame = ContainerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        // show safari View controller
        print("hi i am tapped")
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid url", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGitFollowers(for user: User) {
        //dissmisVC
        //tell follower list screen the new user
        
        guard user.followers != 0 else {
            
            presentGFAlertOnMainThread(title: "NO Followers", message: "This user has no followers, what a shame😔.", buttonTitle: "So Sad")
            return
            
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
