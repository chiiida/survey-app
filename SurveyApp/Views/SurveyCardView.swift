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
    
    lazy var splashView: UIView = {
        let splashView = UIView()
        splashView.backgroundColor = DARK_GRAY.withAlphaComponent(0.4)
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
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
    
    lazy var takeSurveyBtn: UIButton = {
        let takeSurveyBtn = UIButton()
        takeSurveyBtn.frame = CGRect(x: UIScreen.main.bounds.width - 75, y: UIScreen.main.bounds.height - 165, width: 55, height: 55)
        takeSurveyBtn.circle()
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
        addSubview(splashView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(takeSurveyBtn)
        
        setUpLayout()
        setUpActions()
    }
    
    func setUpLayout() {
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -170).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        titleLabel.isSkeletonable = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: takeSurveyBtn.leftAnchor, constant: -50).isActive = true
        descriptionLabel.isSkeletonable = true

        takeSurveyBtn.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        takeSurveyBtn.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 50).isActive = true
        takeSurveyBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    func setUpActions() {
        takeSurveyBtn.addTarget(self, action: #selector(takeSurveyBtnWasTapped), for: .touchUpInside)
    }
    
    @objc private func takeSurveyBtnWasTapped() {
        print(survey.id)
    }
    
}
