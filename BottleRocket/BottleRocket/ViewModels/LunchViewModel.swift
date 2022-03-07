//
//  LunchViewModel.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import Foundation

class LunchViewModel {
    private let networkManager: NetworkManager
    private (set) var restaurants = [Restaurant]()
    @Published private (set) var restaurantImages = [Data]()
    @Published private (set) var restaurantSelected: Restaurant?
    
    init(networkManager: NetworkManager = NetworkManager()){
        self.networkManager = networkManager
        
    }

    func getRestaurantDetails(){
        let url = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
        networkManager
            .getModel(RestaurantsResponse.self, from: url) { [weak self] result in
                switch result {
                case .success(let response):
                    let results = response.restaurants
                    self?.restaurants = results
                    self?.downloadRestaurantImages()
                case .failure(let error):
                    // printing error in console
                    print(error)
                }
            }
    }
    
    
    private func downloadRestaurantImages() {
        let group = DispatchGroup()
        var temp = [Data]()
        for(restaurant) in self.restaurants {
            group.enter()
            networkManager.getData(from: restaurant.backgroundImageURL) { result in
                switch result {
                case .success( let data):
                    temp.append(data)
                case.failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.restaurantImages = temp
        }
    }

    func selectRestaurant(row: Int){
        let restaurant = restaurants[row]
        restaurantSelected = restaurant
    }

}
