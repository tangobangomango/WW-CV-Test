//
//  WWCollectionViewCell.swift
//  WW-CV-Test
//
//  Created by Ed Katzman on 4/25/20.
//  Copyright © 2020 TDG. All rights reserved.
//

import UIKit
import PaddingLabel

class WWCollectionViewCell: UICollectionViewCell {
    
    var label = PaddingLabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        addImageView()
        addLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder) has not been implemented.")
    }
    
    func config() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addLabel() {
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
//        label.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.sizeToFit()
        
        
    }
    
    func addImageView() {
        
        imageView.backgroundColor = UIColor.systemYellow
//        imageView.contentMode = UIView.ContentMode.scaleToFill
        imageView.frame.size.width = self.frame.size.width
        imageView.frame.size.height = self.frame.size.height
        
        addSubview(imageView)
        
    }
}
