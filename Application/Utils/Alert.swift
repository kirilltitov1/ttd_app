//
//  Alert.swift
//  Application
//
//  Created by Kirill Titov on 08.06.2021.
//

import UIKit

protocol showAlert {}

extension showAlert {
    func showAlert(message: String?) {
        let alertC = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        UIApplication.shared.windows.filter { $0.isKeyWindow }
            .first?
            .rootViewController?
            .present(alertC, animated: true, completion: nil)
    }
}
