//
//  HomeViewController.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 7/1/2564 BE.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var surveys = [Survey]()
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let userProfileView = UIImageView()
    private let dateLabel = UILabel()
    private let dayLabel = UILabel()
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSurveys()
        setUpView()
        
        loadData { success in
            if success {
                self.updateView()
                self.hideLoadingAnimation()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        showLoadingAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        view.layoutSkeletonIfNeeded()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
    }
    
    func loadData(completion: @escaping (_ Success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let imageUrlString = "https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png"
            let imageUrl = URL(string: imageUrlString)!
            self.userProfileView.loadUrl(url: imageUrl)
            
//            if self.userProfileView.image != nil {
//                completion(true)
//            } else {
//                completion(false)
//            }
            completion(true)
        }
    }
    
    func loadSurveys() {
        SurveyService.instance.fetchSurveys { [weak self] surveys in
            DispatchQueue.main.async {
                self?.surveys = surveys
            }

            self?.setUpSurveyCardView(surveys: surveys)
            self?.pageControl.numberOfPages = surveys.count;
        }
        print(self.surveys)
    }
    
    func setUpView() {
        scrollView.frame = view.bounds
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounds = UIScreen.main.bounds
        scrollView.delegate = self
        
        pageControl.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 240, width: UIScreen.main.bounds.width, height: 50)
        pageControl.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 50)
        
        userProfileView.frame = CGRect(x: UIScreen.main.bounds.width - 55, y: 80, width: 35, height: 35)
        userProfileView.circle()
        
        dateLabel.frame = CGRect(x: 20, y: 60, width: 130, height: 5)
        
        dayLabel.frame = CGRect(x: 20, y: 90, width: 110, height: 5)
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(userProfileView)
        view.addSubview(dateLabel)
        view.addSubview(dayLabel)
        
//        setUpLayout()
        setUpSkeleton()
    }
    
    func updateView() {
        dateLabel.frame = CGRect(x: 20, y: 60, width: 200, height: 15)
        dateLabel.text = "MONDAY, JUNE 15"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        dateLabel.textColor = .white
        
        dayLabel.frame = CGRect(x: 20, y: 75, width: 150, height: 40)
        dayLabel.text = "Today"
        dayLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        dayLabel.textColor = .white
    }
    
    func setUpSkeleton() {
        SkeletonAppearance.default.multilineSpacing = 8
            
        userProfileView.isSkeletonable = true
        
        dateLabel.isSkeletonable = true
        dateLabel.linesCornerRadius = 10
        
        dayLabel.isSkeletonable = true
        dayLabel.linesCornerRadius = 10
    }
    
    func showLoadingAnimation() {
        let gradient = SkeletonGradient(baseColor: UIColor.midnightBlue)
        
        dateLabel.showAnimatedGradientSkeleton(usingGradient: gradient)
        dayLabel.showAnimatedGradientSkeleton(usingGradient: gradient)
        userProfileView.showAnimatedGradientSkeleton(usingGradient: gradient)
    }
    
    func hideLoadingAnimation() {
        dateLabel.hideSkeleton()
        dayLabel.hideSkeleton()
        userProfileView.hideSkeleton()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func setUpSurveyCardView(surveys: [Survey]) {
        for i in 0..<surveys.count {
            let positionX = UIScreen.main.bounds.width * CGFloat(i)
            let surveyCardView = SurveyCardView(survey: surveys[i], positionX: positionX)
            surveyCardView.isSkeletonable = true
            let gradient = SkeletonGradient(baseColor: UIColor.midnightBlue)
            surveyCardView.showAnimatedGradientSkeleton(usingGradient: gradient)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                surveyCardView.hideSkeleton()
                surveyCardView.updateLayout()
            }

            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(surveyCardView)
        }
    }
    
    func setUpLayout() {
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -190).isActive = true
        
        if #available(iOS 11.0, *) {
            dateLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        } else {
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        }
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true

        dayLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        dayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
    }

}
