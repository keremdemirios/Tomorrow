//
//  PlansTableViewCell.swift
//  Tomorrow
//
//  Created by Kerem Demır on 10.05.2023.
//

import Foundation
import UIKit

final class PlansTableViewCell: UITableViewCell {
    static let cellIdentifier = "CustomPlansTableViewCell"
    
    public var planLabel:UILabel = {
        let planLabel = UILabel()
        planLabel.translatesAutoresizingMaskIntoConstraints = false
        planLabel.textColor = .label
        planLabel.textAlignment = .left
        planLabel.font = .systemFont(ofSize: 20, weight: .medium)
        return planLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configure(){
        addConstraints()
    }
    
    private func addConstraints(){
        contentView.addSubview(planLabel)
        NSLayoutConstraint.activate([
            planLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            planLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
}

