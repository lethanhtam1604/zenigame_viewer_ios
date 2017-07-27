//
//  Router.swift
//  zenigame_viewer
//
//  Created by Kaoru Tsutsumishita on 2017/05/22.
//  Copyright © 2017年 BANDAI NAMCO Entertainment Inc. All rights reserved.
//

import Alamofire
import Foundation

enum Router: URLRequestConvertible {
    static let host = "zenigame.com"
    static let baseURLString = "https://\(Router.host)"

    case login(String, String)
    case getUser(Int)
    case getChannel()
    case getFavoriteChannel(Int)
    case getTVProgram()
    case getEvent()
    case getGacha()
    case getHomeReponses()

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .getUser:
            return .get
        case .getChannel:
            return .get
        case .getFavoriteChannel:
            return .get
        case .getTVProgram:
            return .get
        case .getEvent:
            return .get
        case .getGacha:
            return .get
        case .getHomeReponses:
            return .get
        }
    }

    var path: String {
        switch self {
        case .login(_, _):
            return "/login"
        case .getUser(let id):
            return "/users/\(id)"
        case .getChannel():
            return "/channels"
        case .getFavoriteChannel(let userId):
            return "/favorite_channels/\(userId)"
        case .getTVProgram():
            return "/tv_programs"
        case .getEvent():
            return "/event"
        case .getGacha():
            return "/gacha"
        case .getHomeReponses():
            return "/home_responses"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .login(let mail, let password):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["mail": mail, "password": password])
        case .getUser(_):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: [:])
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: [:])
        }

        return urlRequest
    }

}
