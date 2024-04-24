//
//  ImageCollectionCell.swift
//  Lesson18
//
//  Created by user on 18.04.2024.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCollectionCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    
    func setup(with displayModel: ImageCellDisplayModel) {
        
        guard let data = displayModel.imageData
        else {
            imageView.image = nil
            return
        }
        
        imageView.image = UIImage(data: data)
    }
}
