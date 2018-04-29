//
//  StandardCell.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

class StandardCell: UITableViewCell {

    @IBOutlet private weak var icon: UIButton!
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tagScrollView: UIScrollView!
    @IBOutlet private weak var tagStackView: UIStackView!

    @IBOutlet private weak var iconToContentStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var iconWidthConstraint: NSLayoutConstraint!

    var status: String?

    var tapIconAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.icon.setTitle(nil, for: .normal)
        self.icon.setTitleColor(ColourPalettePrimary.blue, for: .normal)
        self.icon.titleLabel?.font = UIFont.iconFont(ofSize: 26)

        self.mainLabel.textColor = ColourPalettePrimary.blue
        self.mainLabel.font = AppFont.systemFont(forTextStyle: .body, weight: .semibold)
        self.mainLabel.text = nil
        self.mainLabel.attributedText = nil

        self.descriptionLabel.textColor = ColourPaletteSecondary.darkGray
        self.descriptionLabel.font = AppFont.systemFont(forTextStyle: .subheadline)
        self.descriptionLabel.text = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.icon.setTitle(nil, for: .normal)
        self.mainLabel.text = nil
        self.mainLabel.attributedText = nil
        self.descriptionLabel.text = nil
        self.tagStackView.arrangedSubviews.forEach {$0.removeFromSuperview()}
        self.status = nil
        self.tapIconAction = nil
    }

    func configure(icon: String? = nil,
                   text: String?,
                   description: String?,
                   tags: [Tag]?) {

        self.configure(icon: icon,
                       text: NSAttributedString(string: text ?? ""),
                       description: description,
                       tags: tags)
    }

    func configure(icon: String? = nil,
                   text: NSAttributedString?,
                   description: String?,
                   tags: [Tag]?) {

        self.icon.setTitle(icon, for: .normal)
        self.mainLabel.attributedText = text ?? NSAttributedString(string: "")
        self.descriptionLabel.text = description ?? ""

        self.icon.isHidden = (icon == nil || icon?.isEmpty == true)
        self.iconWidthConstraint.constant = (self.icon.isHidden == true) ? 0 : 28
        self.iconToContentStackViewConstraint.constant = (self.icon.isHidden == true) ? 0 : 10

        self.descriptionLabel.isHidden = (description == nil || description?.isEmpty == true)
        self.configureTags(tags)
    }

    private func configureTags(_ tags: [Tag]?) {

        guard let tags = tags, tags.isEmpty == false else {
            self.tagScrollView.isHidden = true
            return
        }
        self.tagScrollView.isHidden = false

        tags.forEach {
            let tagLabel = UILabel(frame: .zero)
            tagLabel.text = " \($0.name ?? "") "
            tagLabel.font = AppFont.systemFont(forTextStyle: .caption2)
            tagLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tagLabel.backgroundColor = UIColor(hex: $0.color) ?? ColourPaletteSecondary.darkGray
            tagLabel.layer.masksToBounds = true
            tagLabel.layer.cornerRadius = 3
            self.tagStackView.addArrangedSubview(tagLabel)
        }
    }

    @IBAction private func tapIcon() {
        tapIconAction?()
    }
}
