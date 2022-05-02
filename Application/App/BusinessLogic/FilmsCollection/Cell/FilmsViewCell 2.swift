//
//  KinoView.swift
//  Application
//
//  Created by Kirill Titov on 03.06.2021.
//

import UIKit
import SnapKit

class FilmsViewCell: UICollectionViewCell {
    
    // MARK: - PARAMS
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(.black).withAlphaComponent(0.5)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "film.fill"))
        image.tintColor = .black
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let ageRating: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewHierarchy()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SETUP
    public func setupCellWith(viewModel: FilmsCellViewModel) {
        title.text = viewModel.film.name
        ageRating.text = String(viewModel.film.ageRating)
        image.loadImageUsingUrlString(urlString: viewModel.film.image ?? "" )
    }
    
    // MARK: - LAYOUT
    
    private func viewHierarchy() {
        addSubview(image)
        image.addSubview(shadowView)
        shadowView.addSubviews(title, ageRating)
    }
    
    private func makeConstraints() {
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        ageRating.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
