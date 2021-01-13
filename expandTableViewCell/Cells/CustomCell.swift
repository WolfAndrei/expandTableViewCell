//
//  CustomCell.swift
//  expandTableViewCell
//
//  Created by Andrei Volkau on 13.01.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    var state: HeaderView.HeaderState?
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: topAnchor),
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    //MARK: - Static
    
    static let cellId = "CustomCellId"
    
    //MARK: - Private vars
    
    private let horizontalMargins: CGFloat = 20
    private let vericalMargins: CGFloat = 10
    
    //MARK: - UI Elements
    
    private lazy var detailLabel: CustomLabel = {
        let label = CustomLabel(font: .systemFont(ofSize: 16), numberOfLines: 0, horizontalInsets: horizontalMargins, verticalInsets: vericalMargins)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Private
    
    private func setupUI() {
        addSubview(detailLabel)
        isUserInteractionEnabled = false
    }
    
    //MARK: - Public
    
    public func configureCell(withData data: RowProtocol) {
        detailLabel.text = data.title
    }
    
}

