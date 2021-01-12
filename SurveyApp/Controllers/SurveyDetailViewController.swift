//
//  SurveyDetailViewController.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 11/1/2564 BE.
//

import UIKit

class SurveyDetailViewController: UIViewController {
    
    var survey: Survey!
    weak var delegate: HomeViewController!
    var maskingView: UIView!
    var bgImageView: UIImageView!
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 20, height: 40))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        titleLabel.text = survey.title
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 20, height: 50))
        descriptionLabel.text = survey.description
        descriptionLabel.textColor = LIGHT_GRAY
        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
        descriptionLabel.numberOfLines = 2
        return descriptionLabel
    }()
    
    lazy var startSurveyBtn: UIButton = {
        let startSurveyBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 150 , y: UIScreen.main.bounds.height - 100, width: 130, height: 50))
        startSurveyBtn.setTitle("Start Survey", for: .normal)
        startSurveyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        startSurveyBtn.setTitleColor(.black, for: .normal)
        startSurveyBtn.backgroundColor = .white
        startSurveyBtn.addCorners(radius: 10)
        return startSurveyBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.backItem?.title = nil
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
    }
    
    func setUpView() {
        view.addSubview(bgImageView)
        view.addSubview(maskingView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startSurveyBtn)
    }
}
