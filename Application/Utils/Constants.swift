//
//  Constants.swift
//  Application
//
//  Created by Kirill Titov on 08.06.2021.
//

import Foundation


final class Constants {
    
    final class Path {
        static let address = "http://127.0.0.1:8080/" //"https://b1acab050420.ngrok.io/" //
        static let films    = "http://127.0.0.1:8080/films/allFilms"
        static func genre(by filmID: String) -> String {
            return "http://127.0.0.1:8080/films/" + String(filmID) + "/genres"
        }
        
        final class User {
            // MARK: - createUser
            static func createUser(
            ) -> String {
                return "\(address)createUser"
            }
            // MARK: - findUser
            static func findUser(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash
            ) -> String {
                return "\(address)\(email)/\(password)/findUser"
            }
        }
        
        final class Films {
            // MARK: - allFilms
            static func allFilms(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash
            ) -> String {
                return "\(address)\(email)/\(password)/allFilms"
            }
            
            // MARK: - filmGenres
            static func filmGenres(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash,
                filmID: String
            ) -> String {
                return "\(address)\(email)/\(password)/\(filmID)/filmGenres"
            }
            // MARK: - filmActors
            static func filmActors(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash,
                filmID: String
            ) -> String {
                return "\(address)\(email)/\(password)/\(filmID)/filmActors"
            }
            // MARK: - filmReviews
            static func filmReviews(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash,
                filmID: String
            ) -> String {
                return "\(address)\(email)/\(password)/\(filmID)/filmReviews"
            }
            static func filmByPrefix(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash,
                prefix: String
            ) -> String {
                return "\(address)\(email)/\(password)/filmLike/\(prefix)"
            }
        }
        
        final class Reviews {
            // MARK: - addReview
            static func filmReviews(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash,
                userID: String = UserSingleton.instance.id ?? "",
                filmID: String,
                text: String
            ) -> String {
                return "\(address)\(email)/\(password)/\(filmID)/\(userID)/\(text)/addReview"
            }
            // MARK: - (delete)
            static func deleteReview(
                _ email: String = UserSingleton.instance.email,
                _ password: String = UserSingleton.instance.passwordHash,
                reviewID: String
            ) -> String {
                return "\(address)\(email)/\(password)/\(reviewID)"
            }
        }
    }
}
