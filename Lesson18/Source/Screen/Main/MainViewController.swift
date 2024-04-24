//
//  MainViewController.swift
//  Lesson18
//
//  Created by user on 18.04.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainView!
    var model: MainModelInput!
    
    var items: [ImageCellDisplayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        model.loadData()
    }
    
    private func setup() {
        
        model = MainModel(output: self)
        contentView.output = self
        
        let nib = UINib(nibName: ImageCollectionCell.reuseIdentifier, bundle: nil)
        contentView.collectionView.register(nib, forCellWithReuseIdentifier: ImageCollectionCell.reuseIdentifier)
        
        let sideWidth = view.bounds.size.width / 2.0
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: sideWidth, height: sideWidth)
        flowLayout.sectionInset = .zero
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        
        contentView.collectionView.collectionViewLayout = flowLayout
        
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    }
    
    func updateCell(at indexPath: IndexPath) {
        
        if let cell = contentView.collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
            
            let urlString = items[indexPath.row].imageUrl
            items[indexPath.row].imageData = model.getImageData(for: urlString)
            
            let displayModel = items[indexPath.row]
            cell.setup(with: displayModel)
        }
    }
}

// MARK: - MainViewOutput
extension MainViewController: MainViewOutput {
    
}

// MARK: - MainModelOutput
extension MainViewController: MainModelOutput {
    
    func dataDidLoad(with urls: [String]) {
        
        items = urls.compactMap { ImageCellDisplayModel(imageUrl: $0) }
        contentView.collectionView.reloadData()
    }
    
    func imageDataDidLoad(for indexPath: IndexPath) {
        updateCell(at: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.reuseIdentifier, for: indexPath) as? ImageCollectionCell else {
            assertionFailure()
            return UICollectionViewCell()
        }
        
        var displayModel = items[indexPath.row]
        displayModel.imageData = model.getImageData(for: displayModel.imageUrl)
        
        if displayModel.imageData == nil {
            model.loadData(for: displayModel.imageUrl, at: indexPath)
        }
        
        cell.setup(with: displayModel)
        
        return cell
    }
}

// MARK: - MainModelOutput
extension MainViewController: UICollectionViewDelegate {
    
}
