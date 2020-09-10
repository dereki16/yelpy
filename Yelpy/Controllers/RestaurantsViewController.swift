//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

struct Stars {
    
    static let dict = [
        0: Stars.zero,
        1: Stars.one,
        1.5: Stars.oneHalf,
        2: Stars.two,
        2.5: Stars.twoHalf,
        3: Stars.three,
        3.5: Stars.threeHalf,
        4: Stars.four,
        4.5: Stars.fourHalf,
        5: Stars.five
    ]

    static let zero = UIImage(named: "regular_0")
    static let one = UIImage(named: "regular_1")
    static let oneHalf = UIImage(named: "regular_1_half")
    static let two = UIImage(named: "regular_2")
    static let twoHalf = UIImage(named: "regular_2_half")
    static let three = UIImage(named: "regular_3")
    static let threeHalf = UIImage(named: "regular_3_half")
    static let four = UIImage(named: "regular_4")
    static let fourHalf = UIImage(named: "regular_4_half")
    static let five = UIImage(named: "regular_5")


}


class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create restaurant cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell

        let restaurant = restaurantsArray[indexPath.row]
        
        // set label to restaraunt name for each cell
        cell.label.text = restaurant["name"] as? String ?? ""
        
        // set category
        let categories = restaurant["categories"] as! [[String: Any]]
        cell.categoryLabel.text = categories[0]["title"] as? String
        
        // set phone number
        let phone = restaurant["display_phone"]
        cell.phoneLabel.text = phone as? String
        
        // set star rating
        let rating = restaurant["rating"] as! Double
        cell.starsImage.image = Stars.dict[rating]!

        // set reviews
        let reviews = restaurant["review_count"] as? Int
        cell.reviewsLabel.text = String(reviews!)
        
        // set image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        cell.layoutIfNeeded()
        


        return cell
    }
    
    
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        getAPIData()
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurantsArray = restaurants
            self.tableView?.reloadData() // reload data!
        }
    }
}
// ––––– TODO: Create tableView Extension and TableView Functionality



