//
//  HomeViewController.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 7/1/2564 BE.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
//    private let surveys = [Survey]()
    
    let surveys: [Survey] = [
        Survey(id: "1", title: "Working from home Check-in", description: "We would like to know how you feel about our work from home We would like to know how you feel about working from home", cover_image_url: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l"),
        Survey(id: "1", title: "Careers bah bah bah For Bah Bah", description: "We would like to know how you feel about working from home We would like to know how you feel about working from home", cover_image_url: "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_l"),
        Survey(id: "1", title: "Working from home Check-in", description: "We would like to know how you feel about working from home We would like to know how you feel about working from home", cover_image_url: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l"),
        Survey(id: "1", title: "Careers bah bah bah For Bah Bah", description: "We would like to know how you feel about working from home We would like to know how you feel about working from home", cover_image_url: "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_l")
    ]
    
    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpSurveyCardView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
    }
    
    func setUpView() {
        scrollView.frame = view.bounds
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounds = UIScreen.main.bounds
        scrollView.delegate = self
        
        pageControl.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 250, width: UIScreen.main.bounds.width, height: 50);
        pageControl.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 50)
        pageControl.numberOfPages = surveys.count;
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        
        setUpLayout()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func setUpSurveyCardView() {
        for i in 0..<surveys.count {
            let positionX = UIScreen.main.bounds.width * CGFloat(i)
            let surveyCardView = SurveyCardView(survey: surveys[i], positionX: positionX)
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(surveyCardView)
        }
    }
    
    func setUpLayout() {
        pageControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -190).isActive = true
    }

}
