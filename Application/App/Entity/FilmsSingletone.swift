//
//  FilmsSingletone.swift
//  Application
//
//  Created by Kirill Titov on 15.06.2021.
//

import Foundation

class FilmsSingleton {
    
    // MARK: - Parameters
    
    var imageURL: [String] = [
        "https://s1.afisha.ru/mediastorage/ae/cd/04e5f755f744445ebda5c652cdae.jpg",
        "https://kinochannel.ru/wp-content/uploads/2020/03/Angely-i-demony_poster-718x1024.jpg",
        "https://a.d-cd.net/6a62e1u-960.jpg",
        "https://www.film.ru/sites/default/files/movies/posters/41393222-1121425.jpg",
        "https://n1s1.hsmedia.ru/21/d4/e5/21d4e57b60e3e3df56661233bb22422d/690x1077_0xac120003_6087471251573819621.jpg",
        "https://www.startfilm.ru/images/base/film/f_661598/big_startfilmru1389265.jpg",
        "https://pbs.twimg.com/media/D9H8qo8XsAcAyaN.jpg",
        "https://www.startfilm.ru/images/base/film/f_120119/big_startfilmru1266411.jpg",
        "https://avatars.mds.yandex.net/get-zen_doc/3481765/pub_5ee2f47efeea096b04375435_5ee2fa94b0abff2489fd732f/scale_1200",
        "https://inoekino.com/public/images/upload/dBlPlpMcnM.jpg",
        "https://kassa.rambler.ru/s/StaticContent/P/Aimg/1806/08/180608235139009.jpg"
    ]
    
    // MARK: - Shared
    
    static var instance: [String] = {
        let instance = FilmsSingleton().imageURL
        
        return instance
    }()

    // MARK: - private init
    
    private init() {}
}

