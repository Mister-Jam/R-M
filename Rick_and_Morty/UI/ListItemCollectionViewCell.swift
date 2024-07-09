//
//  ListItemCollectionViewCell.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import UIKit

final class ListItemCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ListItemCollectionViewCell.self)
    
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel(
        font: .preferredFont(forTextStyle: .title3),
        color: .labelDefault)
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubiews([imageView, titleLabel])
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        imageView.layer.masksToBounds = true
        imageView.positionView(
            topAnchor: contentView.topAnchor,
            leadingAnchor: contentView.leadingAnchor,
            trailingAnchor: contentView.trailingAnchor,
            padding: .init(top: 10, left: 8, bottom: 10, right: 8)
        )
        imageView.heightAnchor.constraint(
            equalTo: contentView.heightAnchor,
            multiplier: 0.85
        ).isActive = true
        titleLabel.positionView(
            topAnchor: imageView.bottomAnchor,
            leadingAnchor: contentView.leadingAnchor,
            trailingAnchor: contentView.trailingAnchor,
            padding: .init(top: 10, left: 8, bottom: .zero, right: 8))
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
        titleLabel.layer.masksToBounds = true
    }
    
    func setupCellData(with model: ListItemCellModel) {
        imageView.setImage(with: model.characterImage, placeholderImage: .rickLogo)
        titleLabel.text = model.characterTitle
    }
}
