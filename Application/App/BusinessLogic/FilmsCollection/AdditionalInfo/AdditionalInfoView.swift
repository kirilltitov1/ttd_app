//
//  AdditionalInfoView.swift
//  Application
//
//  Created by Kirill Titov on 09.06.2021.
//

import UIKit

class AdditionalInfoView: UIView {
    
    let rightBox = UIView()
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let genre: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let boxOffice: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let ageRating: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let rating: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let date: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let image: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "film.fill"))
        view.tintColor = .black
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        return view
    }()
    let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .line
        field.placeholder = "отзыв"
        return field
    }()
    
    let addReview: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewHierarchy()
        makeConstraints()
        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(by film: Film) {
        self.title.text = "Название: " + film.name
        self.genre.text = "Жанр: \(film.genres?.first?.name ?? "Комедия")"
        self.boxOffice.text = "Кассовый сбор: " + String(film.boxOffice)
        self.ageRating.text = "Возрастное ограничение: " + String(film.ageRating)
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        format.dateStyle = .short
        format.timeStyle = .short
        let date = format.date(from: film.date)
        self.date.text = "Дата: " + format.string(from: date ?? Date())
        image.loadImageUsingUrlString(urlString: film.image ?? "")
    }
    
    func viewHierarchy() {
        addSubviews(image, rightBox, textField, addReview)
        rightBox.addSubviews(title, genre, boxOffice, ageRating, date)
    }
    func makeConstraints() {
        
        image.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.height.equalTo(170)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(16)
            $0.width.equalTo(200)
        }
        
        addReview.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom)
        }
        
        rightBox.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalTo(image.snp.trailing).inset(-8)
        }
        
        date.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(ageRating.snp.bottom).offset(16)
        }
        
        ageRating.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(boxOffice.snp.bottom).offset(16)
        }
        boxOffice.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(genre.snp.bottom).offset(16)
        }
        genre.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(16)
        }
        title.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
    }
}
