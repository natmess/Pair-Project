//
//  MagicViewController.swift
//  PairProject
//
//  Created by Oniel Rosario on 1/9/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit

class MagicViewController: UIViewController {
    @IBOutlet weak var MagicCollection: UICollectionView!
    var magicCards = [MagicCard](){
        didSet {
            DispatchQueue.main.async {
                self.MagicCollection.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Magic Cards"
        MagicCollection.dataSource = self
        MagicCollection.delegate = self
        getMagicCards()
       
    }
    
    func getMagicCards() {
        magicAPIClient.getMagics { (appError, magicCards) in
            if let appError = appError {
                print(appError)
            } else if let magicCards = magicCards {
                self.magicCards = magicCards
            }
        }
    }
}

extension MagicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagicCell", for: indexPath) as? MagicCollectionViewCell else { return UICollectionViewCell() }
        let card = magicCards[indexPath.row]
        cell.configureCell(magicCard: card)
        return cell
    }
    
    
}

extension MagicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 130, height: 200)
    }
}
