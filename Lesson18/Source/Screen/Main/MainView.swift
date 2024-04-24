//
//  MainView.swift
//  Lesson18
//
//  Created by user on 18.04.2024.
//

import UIKit

protocol MainViewOutput: AnyObject {
    
}

class MainView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var output: MainViewOutput?
}
