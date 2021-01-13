//
//  CustomLabel.swift
//  expandTableViewCell
//
//  Created by Andrei Volkau on 13.01.2021.
//

import UIKit

class CustomLabel: UILabel {
    
    private var horizontalInsets: CGFloat!
    private var verticalInsets: CGFloat!
    
    convenience init(font: UIFont, numberOfLines: Int = 0, horizontalInsets: CGFloat = 0, verticalInsets: CGFloat = 0) {
        self.init(frame: .zero)
        self.horizontalInsets = horizontalInsets
        self.verticalInsets = horizontalInsets
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        return super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width  += self.horizontalInsets + self.horizontalInsets
        size.height += self.verticalInsets + self.verticalInsets
        return size
    }
    
}
