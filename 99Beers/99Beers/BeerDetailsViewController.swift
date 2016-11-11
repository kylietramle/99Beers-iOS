//
//  BeerDetailsViewController.swift
//  99Beers
//
//  Created by Kylie Tram Le on 10/19/16.
//  Copyright © 2016 Kylie Tram Le. All rights reserved.
//

import UIKit
import AlamofireImage

class BeerDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var beerNameText: UILabel!
    @IBOutlet weak var beerLogoImage: UIImageView!
    @IBOutlet weak var beerStyleText: UILabel!
    @IBOutlet weak var beerAbvText: UILabel!
    @IBOutlet weak var beerIbuText: UILabel!
    @IBOutlet weak var beerDescriptionText: UILabel!
    
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        
        if(beer?.beerLogo != nil) {
            let url = URL(string: beer!.beerLogo!)
            beerLogoImage.af_setImage(withURL: url!)
        }
        self.beerNameText.text = beer?.beerName
        self.beerStyleText.text = beer?.beerStyle
        self.beerAbvText.text = String(format:"%.1f", (beer?.abv)!)
        self.beerIbuText.text = String(format:"%.1f", (beer?.ibu)!)
        self.beerDescriptionText.text = beer?.beerDescription
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: 375, height: 680)
    }
}
