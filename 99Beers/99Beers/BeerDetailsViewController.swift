//
//  BeerDetailsViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/19/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit

class BeerDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: 375, height: 680)
    }
}
