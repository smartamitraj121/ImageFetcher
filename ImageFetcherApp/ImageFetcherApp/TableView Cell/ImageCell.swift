//
//  ImageCell.swift
//  ImageFetcherApp
//
//  Created by Amit Kumar on 09/06/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    let canadaImgView = CustomImageView()
    let titleLbl = UILabel()
    let descriptionLbl = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    var minHeight: CGFloat?
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUi() {
        canadaImgView.layer.cornerRadius = 50
        canadaImgView.layer.masksToBounds = false
        self.contentView.addSubview(canadaImgView)
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(descriptionLbl)
        self.selectionStyle = .none
        canadaImgView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        canadaImgView.clipsToBounds = true
        canadaImgView.contentMode = .scaleAspectFit
        canadaImgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        canadaImgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        canadaImgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        canadaImgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        
        titleLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: self.canadaImgView.leadingAnchor, constant: 120).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 16).isActive = true
        titleLbl.numberOfLines = 0
        
        descriptionLbl.topAnchor.constraint(equalTo: self.titleLbl.topAnchor, constant: 30).isActive = true
        descriptionLbl.leadingAnchor.constraint(equalTo: self.canadaImgView.leadingAnchor, constant: 120).isActive = true
        descriptionLbl.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 16).isActive = true
        //descriptionLbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        descriptionLbl.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: self.contentView.bottomAnchor, multiplier: 0).isActive = true
        descriptionLbl.numberOfLines = 0
        
    }
}
