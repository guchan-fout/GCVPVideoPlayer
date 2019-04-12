//
//  HeroTableViewCell.swift
//  GCVideoPlayer
//
//  Created by gc on 2019/02/10.
//  Copyright © 2019 gc. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    let heroImageView:UIImageView = {
        let heroImg = UIImageView()
        heroImg.contentMode = .scaleAspectFill
        heroImg.translatesAutoresizingMaskIntoConstraints = false
        heroImg.layer.cornerRadius = 5
        heroImg.clipsToBounds = true
        return heroImg
    }()

    let heroNameLabel:UILabel = {
        let heroLabel = UILabel()
        heroLabel.font = UIFont.boldSystemFont(ofSize: 15)
        heroLabel.translatesAutoresizingMaskIntoConstraints = false
        return heroLabel
    }()

    let heroCompanyView:UIImageView = {
        let companyImg = UIImageView()
        companyImg.contentMode = .scaleAspectFit
        companyImg.translatesAutoresizingMaskIntoConstraints = false
        companyImg.layer.cornerRadius = 0
        companyImg.clipsToBounds = true
        return companyImg
    }()

    var heroInfo:HerosInfo? {
        didSet {
            guard heroInfo != nil else {return}
            if let name = heroInfo?.name {
                heroImageView.image = UIImage(named: name)
                heroNameLabel.text = name
            }
            if let company = heroInfo?.company{
                heroCompanyView.image = UIImage(named: company)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.contentView.addSubview(heroImageView)
        self.contentView.addSubview(heroNameLabel)
        self.contentView.addSubview(heroCompanyView)

        heroImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        heroImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        heroImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        heroImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true

        heroNameLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        heroNameLabel.leadingAnchor.constraint(equalTo:self.heroImageView.trailingAnchor, constant:10).isActive = true
        heroNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        heroNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        heroCompanyView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        heroCompanyView.leadingAnchor.constraint(equalTo:self.heroNameLabel.trailingAnchor, constant:10).isActive = true
        heroCompanyView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        heroCompanyView.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
