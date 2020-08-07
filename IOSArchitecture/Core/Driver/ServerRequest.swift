//
//  ServerRequest.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 22/07/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

public enum RequestVerbType {
    case get
    case patch
    case post
    case put
    case delete
    case unknown
}

public typealias GBTHandlerCompletion = (_ jsonResponse: Any?, _ error: NSError?) -> Void

class ServerRequest: NSObject {
    
    init(driver: DriverProtocol, completion: @escaping GBTHandlerCompletion) {
        super.init()
        /*
        self.driver = driver
        self.completion = completion

        needsJSON = true
        isAuthenticationRequest = false
        duringRenewRequest = false
        dataResponse = NSMutableData()
        sessionInvalidated = false

        NeoGbtServerRequest.registerServerRequest(serverRequest: self)*/
    }
    
    var currentSession: URLSession?
    
    // MARK:
    func get(url: URL, headers: [String: String]?, delegate: URLSessionDelegate) {
        makeRequest(withMethod: "GET", url: url, headers: headers, delegate: delegate)
    }

    func patch(url: URL, data: Any?, headers: [String: String]?, delegate: URLSessionDelegate) {
        makeRequest(withMethod: "PATCH", url: url, data: data, headers: headers, delegate: delegate)
    }

    func post(url: URL, data: Any?, headers: [String: String]?, delegate: URLSessionDelegate) {
        makeRequest(withMethod: "POST", url: url, data: data, headers: headers, delegate: delegate)
    }

    func put(url: URL, data: Any?, headers: [String: String]?, delegate: URLSessionDelegate) {
        makeRequest(withMethod: "PUT", url: url, data: data, headers: headers, delegate: delegate)
    }
    
    func delete(url: URL, data: Any?, headers: [String: String]?, delegate: URLSessionDelegate) {
        makeRequest(withMethod: "DELETE", url: url, data: data, headers: headers, delegate: delegate)
    }
    
    private func makeRequest(withMethod method: String, url: URL, data: Any? = nil, headers: [String: String]?, delegate: URLSessionDelegate) {
        var request = URLRequest(url: url)
        self.currentSession = URLSession(configuration: URLSessionConfiguration.default, delegate: delegate, delegateQueue: nil)

        request.httpMethod = method
        request.allHTTPHeaderFields = headers

        if data != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: data!, options: JSONSerialization.WritingOptions.prettyPrinted)
        }

        (self.currentSession!.dataTask(with: request)).resume()
    }
    
    // MARK:
    var requestType: RequestVerbType = .unknown // HTTP verbs
    var badParametersError: NSError?            // in case of bad parameters, return this error
    var endpointURL: URL?
    var headers: [String: String]?
    var data: Any?
    
    var completion: GBTHandlerCompletion!
    
    func setRequestParameters(requestType: RequestVerbType, badParametersError: NSError?, endpointURL: URL, headers: [String: String]?, data: Any?) {
        self.requestType = requestType
        self.badParametersError = badParametersError
        self.endpointURL = endpointURL
        self.headers = headers
        self.data = data
    }
    
    private func header(header: [String : String]?) -> [String : String]? {
        return header
    }
    
    func invoke() {
        guard badParametersError == nil else {
            completion(nil, badParametersError)
            return
        }

        switch requestType {
        case .get:
            get(url: endpointURL!, headers: header(header: self.headers), delegate: self)
        case .patch:
            patch(url: endpointURL!, data: data, headers: header(header: self.headers), delegate: self)
        case .post:
            post(url: endpointURL!, data: data, headers: header(header: self.headers), delegate: self)
        case .put:
            put(url: endpointURL!, data: data, headers: header(header: self.headers), delegate: self)
        case .delete:
            delete(url: endpointURL!, data: data, headers: header(header: self.headers), delegate: self)
        case .unknown:
            return
               // completion(nil, NeoGbtDriverUtils.createNeoCriticalError(errCode: kNeoNetworkFatal, description: "ERROR: the request verb is not set", reason: "Unknown verb"))
        }
    }
}


extension ServerRequest: URLSessionDelegate {
}
