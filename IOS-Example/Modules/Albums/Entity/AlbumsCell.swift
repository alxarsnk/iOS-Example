//
//  AlbumsCell.swift
//  IOS-Example
//
//  Created by Александр Арсенюк on 25.04.2021.
//

import UIKit

class AlbumsCell: UITableViewCell {
    
    // MARK: - Internal properties
    
    private struct Appearance: Grid {
        let alphaComponent06: CGFloat = 0.06
        let opacity1: Float = 1
    }
    private let appearance = Appearance()
    
    override var reuseIdentifier: String? {
        return String(describing: self)
    }
    
    // MARK: - UI elements
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = appearance.xxsSpace
        view.layer.shadowRadius = appearance.xxsSpace
        view.layer.shadowColor = UIColor.black.withAlphaComponent(appearance.alphaComponent06).cgColor
        view.layer.shadowOpacity = appearance.opacity1
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название альбома"
        label.font = UIFont.systemFont(ofSize: appearance.xsSpace, weight: .regular)
        label.setColor(.gray)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setColor(.black)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }
    
    private func setupStyle() {
        selectionStyle = .none
        backgroundColor = .white
        layer.masksToBounds = false
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                .inset(appearance.xsSpace)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
                .offset(appearance.xsSpace)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
                .offset(appearance.xxsSpace)
            make.bottom.leading.trailing.equalToSuperview()
                .inset(appearance.xsSpace)
        }
    }
    
}

extension AlbumsCell {
    
    func configure(with viewModel: Album) {
        titleLabel.text = viewModel.title
    }
    
}
