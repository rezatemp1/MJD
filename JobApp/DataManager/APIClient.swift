//
//  DataManager.swift
//  Apply MJD
//
//  Created on 12/12/16.
//  Copyright © 2016 MJD Interactive. All rights reserved.
//

import Foundation


public enum NetworkErrorType: Error {
    case noConnection
    case badMatch
    case otherServerError
    case notAuthorized
    case serviceUnavailable
    case localIssue
    case serverOffline
    case invalidRequest

    var description: String {
        switch self {
        case .noConnection:
            return "No Internet Connection"
        case .badMatch:
            return "Bad Data"
        case .notAuthorized:
            return "Invalid Account"
        case .serviceUnavailable:
            return "Temporarily Unavailable"
        case .invalidRequest:
            return "Invalid Request"

        default:
            return "Server Error"
        }

    }
}

private enum RequestType: String {
    case POST
    case GET
    case DELETE
    case HEAD
}


/**
 API Client is a general purpose class for accessing an API's endpoints. This is not meant to exhaustive or robust

 */
public struct APIClient {

    static let baseURL: URL! = URL(string:"https://careers.mjdinteractive.com")
    static let apiPath = "/data"

    static let catsPath = "/cats.json"

    fileprivate static func url(forComponent component: String) -> URL? {
        let combinedPath = "\(apiPath)\(component)"
        return baseURL.appendingPathComponent(combinedPath)
    }

    public static func getCats(completion: @escaping ([Cat]?, NetworkErrorType?) -> Void) {


        guard let path = url(forComponent: catsPath) else {
            completion(nil, NetworkErrorType.localIssue)
            return
        }

        var request = URLRequest(url: path)
        request.httpMethod = RequestType.GET.rawValue

        doRequest(request) { (json, error) in

                guard let json = json as? [String: [Data]] else {
                    completion(nil, error)
                    return
                }

                var cats: [Cat] = []
                guard let list = json["cats"] else {
                    completion(nil, .localIssue)
                    return
                }

                for item in list {
                    if let cat = Cat(data: item) {
                        cats.append(cat)
                    }
                }
                completion(cats, nil)

        }
    }




    fileprivate static func doRequest(_ request: URLRequest, completion: @escaping (_ json: Any?, _ error: NetworkErrorType?) -> Void) {

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in

            if let error = error as? NSError {
                if error.code == NSURLErrorNotConnectedToInternet {
                    completion(nil, .noConnection)
                } else {
                    completion(nil, .otherServerError)
                }
                return
            }

            let httpResponse = response as? HTTPURLResponse

            guard let code = httpResponse?.statusCode else {
                completion(nil, .otherServerError)
                return
            }

            switch code {
            case 200:
                guard let data = data else {
                    completion(nil, nil)
                    return
                }

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

                    completion(json as Any?, nil)

                } catch {
                    completion(nil, nil)
                }
            default:
                completion(nil, .otherServerError)
            }
        }

        dataTask.resume()
    }

}


extension APIClient {

    public static func loadImage(url: URL, completion: @escaping (UIImage?, NetworkErrorType?) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = RequestType.GET.rawValue

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            DispatchQueue.main.async {

                if error != nil {
                    completion(nil, .otherServerError)
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, .otherServerError)
                    return
                }
                let code = httpResponse.statusCode



                if Int(code / 100) != 2 {
                    completion(nil, .otherServerError)
                    return
                }


                guard let data = data else {
                    completion(nil, .otherServerError)
                    return
                }
                let im = UIImage(data: data)
                completion(im, nil)
            }
        }
        
        dataTask.resume()
        
        completion(nil, nil)
    }
}




