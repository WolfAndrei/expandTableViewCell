//
//  HeaderView.swift
//  expandTableViewCell
//
//  Created by Andrei Volkau on 12.01.2021.
//

import UIKit

protocol ExpandDelegateProtocol: class {
    func expand(state: HeaderView.HeaderState, section: Int)
}

class HeaderView: UIView {
    
    //MARK: - Nested types
    enum HeaderState {
        case expanded, compact
    }
    
    //MARK: - View lifecycle
    
   init(state: HeaderState) {
        self.state = state
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
           
            expandButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            expandButton.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 0),
            expandButton.widthAnchor.constraint(equalToConstant: 40),
            expandButton.heightAnchor.constraint(equalToConstant: 40),
          
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            separatorView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20)
        ])
    }
    
    //MARK: - Properties
    
    weak var delegate: ExpandDelegateProtocol?
    private var state: HeaderState
    
    //MARK: - UI elements
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "ellipsis.bubble")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
   private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var expandButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(expand), for: .touchUpInside)
        return btn
    }()
    
    private let separatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .lightGray
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - Actions
    
    @objc func expand() {
        animateButton()
        delegate?.expand(state: state, section: self.tag)
        if state == .compact {
            state = .expanded
        } else {
            state = .compact
        }
    }
    
    //MARK: - Private
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(label)
        addSubview(expandButton)
        addSubview(separatorView)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expand)))
    }
    
    private func animateButton() {
        UIView.animate(withDuration: 0.3) {
            if self.state == .compact {
                self.expandButton.transform = CGAffineTransform(rotationAngle: -0.5 * CGFloat.pi)
            } else {
                self.expandButton.transform = .identity
            }
        }
    }
    
    //MARK: - Public
    
    public func configureCell(withData data: SectionProtocol) {
        label.text = data.title
        expandButton.transform = (state == .compact) ? .identity : CGAffineTransform(rotationAngle: -0.5 * CGFloat.pi)
    }
    
}


