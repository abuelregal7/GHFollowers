//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Ahmed on 6/22/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    //GFButton(backgroundColor: .systemGreen, title: "Get Follwers")
    let logoImageView      = UIImageView()
    let usernameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Follwers", cornerRadius: 10)
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    var logoImageViewTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemBackground
        configureLogoImageView()
        configureTextField()
        configureButton()
        createDissmissKayboardTapedGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
        
    }
    
    func createDissmissKayboardTapedGesture() {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a user name. we need who to look for 😀.", buttonTitle: "Ok")
            print("No username")
            return
            
        }
        //view.endEditing(true)
        usernameTextField.resignFirstResponder()
        
        let followerListVC      = FollowerListVC(username: usernameTextField.text!)
//        let followerListVC      = FollowerListVC() 
//        followerListVC.username = usernameTextField.text
//        followerListVC.title    = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }
    
    func configureLogoImageView(){
        
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //logoImageView.image = UIImage(named: "gh-logo")!
        
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiphoneSE || DeviceTypes.isiphone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
        
            //logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        
        ])
    }
    
    func configureTextField(){
        
        view.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
        
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    func configureButton(){
        
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
    }
    

    

}

extension SearchVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tap return")
        pushFollowerListVC()
        return true
    }
    
}
