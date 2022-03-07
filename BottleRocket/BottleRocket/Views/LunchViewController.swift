//
//  ViewController.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import UIKit
import Combine

class LunchViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView?
    private let viewModel = LunchViewModel()
    private var subscribers = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinding()
        setUpCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailRestaurantViewController
        destination?.viewModel = viewModel
    }
    
    private func setUpBinding(){
        viewModel
            .$restaurantImages
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView?.reloadData()
            }
            .store(in: &subscribers)
        
        viewModel.getRestaurantDetails()
    }
    
    private func setUpCollectionView() {
        collectionView?.reloadData()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        let size = CGSize(width: width, height: 180) //128
        layout.itemSize = size
        layout.minimumLineSpacing = 0
        collectionView?.collectionViewLayout = layout
    }
    
}

extension LunchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell
        else { return UICollectionViewCell()}
        let row = indexPath.row
        let restaurant = viewModel.restaurants[row]
        cell.configureCell(restaurantName: restaurant.name, categoryType: restaurant.category, imageData: viewModel.restaurantImages[row])
        return cell
                
        
    }
}

extension LunchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectRestaurant(row: indexPath.row)
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}
