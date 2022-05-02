//
//  Error.swift
//  Application
//
//  Created by Kirill Titov on 08.06.2021.
//

protocol ErrorParser: Error {
    @discardableResult
    func parser(parseError: Error) -> Error
}

class ErrorHandler: ErrorParser, showAlert {
    func parser(parseError: Error) -> Error {
        guard let error = parseError.asAFError else { return parseError }
        let description = "⚠️ -> " + (error.errorDescription ?? "")
        switch true {
        case error.isResponseSerializationError:
            showAlert(message: "")
            print(description)
        case error.isSessionTaskError:
            showAlert(message: "No conection")
            print(description)
        case error.isCreateURLRequestError:
            print(description)
        case error.isInvalidURLError:
            print(description)
        case error.isCreateUploadableError:
            print(description)
//        case
        default:
            print(description)
        }
        return error
    }
}
