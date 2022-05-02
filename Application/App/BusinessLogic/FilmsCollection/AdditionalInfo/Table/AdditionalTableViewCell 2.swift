//
//  AdditionalTableViewCell.swift
//  Application
//
//  Created by Kirill Titov on 09.06.2021.
//

import UIKit


class AdditionalTableViewCell: UITableViewCell {

    let review: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()

    lazy var rmReview: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(by model: AdditionalInfoViewModel, row: Int) {
        review.text = model.film.reviews?[row].text
    }

    private func layout() {
        contentView.addSubviews(review, rmReview)
        rmReview.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(review.snp.trailing).offset(16)
            $0.width.equalTo(rmReview.snp.height)
        }
        review.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(8)
        }
    }
    
}
