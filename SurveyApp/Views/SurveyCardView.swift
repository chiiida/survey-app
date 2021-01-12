//
//  SurveyCardView.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 7/1/2564 BE.
//

import UIKit
import SkeletonView

class SurveyCardView: UIView {
    var survey: Survey!
    
    lazy var maskingView: UIView = {
        let splashView = UIView()
        splashView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return splashView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let url = URL(string: survey.cover_image_url)!
        bgImageView.loadUrl(url: url)
        return bgImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = survey.title
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        return titleLabel
    }()

    lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = survey.description
        descriptionLabel.textColor = LIGHT_GRAY
        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0)
        descriptionLabel.numberOfLines = 2
        return descriptionLabel
    }()
    
    lazy var surveyDetailBtn: UIButton = {
        let takeSurveyBtn = UIButton()
        takeSurveyBtn.setImage(UIImage(named: "arrow"), for: .normal)
        takeSurveyBtn.imageView?.contentMode = .scaleAspectFit
        takeSurveyBtn.contentVerticalAlignment = .fill
        takeSurveyBtn.contentHorizontalAlignment = .fill
        takeSurveyBtn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        takeSurveyBtn.backgroundColor = .white
        return takeSurveyBtn
    }()
    
    init(survey: Survey, positionX: CGFloat) {
        super.init(frame: CGRect(x: positionX, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        self.survey = survey
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(bgImageView)
        addSubview(maskingView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(surveyDetailBtn)
        
        setUpLayout()
        setUpSkeleton()
        setUpActions()
    }
    
    func setUpLayout() {
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -170).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -130).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
    }
    
    func updateLayout() {
        maskingView.backgroundColor = DARK_GRAY.withAlphaComponent(0.4)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        
        descriptionLabel.rightAnchor.constraint(equalTo: surveyDetailBtn.rightAnchor, constant: -50).isActive = true
        
        surveyDetailBtn.frame = CGRect(x: UIScreen.main.bounds.width - 75, y: UIScreen.main.bounds.height - 165, width: 55, height: 55)
        surveyDetailBtn.circle()
        surveyDetailBtn.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        surveyDetailBtn.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 50).isActive = true
        surveyDetailBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func setUpSkeleton() {
        titleLabel.isSkeletonable = true
        titleLabel.linesCornerRadius = 10
        titleLabel.lastLineFillPercent = 50
        
        descriptionLabel.isSkeletonable = true
        descriptionLabel.linesCornerRadius = 10
    }
    
    func setUpActions() {
        surveyDetailBtn.addTarget(self, action: #selector(takeSurveyBtnWasTapped), for: .touchUpInside)
    }
    
    @objc private func takeSurveyBtnWasTapped() {
        let surveyDetailVC = SurveyDetailViewController()
        surveyDetailVC.survey = self.survey
        surveyDetailVC.bgImageView = self.bgImageView
        surveyDetailVC.maskingView = self.maskingView
        surveyDetailVC.delegate = (self.parentViewController as! HomeViewController)
        self.parentViewController?.navigationController?.pushViewController(surveyDetailVC, animated: true)
    }
    
}
