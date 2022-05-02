//
//  LoginView.swift
//  Application
//
//  Created by Kirill Titov on 04.06.2021.
//

import UIKit
import SnapKit

class LoginView: UIView {

    // MARK: - PARAMETRES
    
    let title: UILabel = {
        let label = UILabel()
        
        label.text = "Авторизация"
        label.font = UIFont(name: "Title 1", size: 18)
        
        return label
    }()
    
    let loginTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .line
        field.placeholder = "login"
        
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .line
        field.placeholder = "password"
        field.isSecureTextEntry = true
        
        return field
    }()
    
    lazy var applyButton: UIButton = {
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
        addSubviews(loginTextField, passwordTextField, title, applyButton)
    }
    
    private func makeConstraints() {
        title.snp.makeConstraints {
            $0.leading.equalTo(loginTextField.snp.leading)
        }
        loginTextField.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.centerY.centerX.equalToSuperview()
            $0.top.equalTo(title.snp.bottom).offset(16)
        }
        passwordTextField.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.top.equalTo(loginTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        applyButton.snp.makeConstraints {
            $0.centerX.equalTo(loginTextField)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
        }
    }
}
