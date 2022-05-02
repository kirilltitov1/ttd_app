//
//  MainView.swift
//  Application
//
//  Created by Kirill Titov on 05.06.2021.
//

import UIKit

class MainView: UIView {
    
    // MARK: - PARAMETRES
    
    lazy var registrationButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewHierarchy()
        makeConstraints()
        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    
    private func viewHierarchy() {
        addSubviews(registrationButton, loginButton)
    }
    
    private func makeConstraints() {
        registrationButton.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        loginButton.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(registrationButton.snp.bottom).offset(16)
        }
    }
}
