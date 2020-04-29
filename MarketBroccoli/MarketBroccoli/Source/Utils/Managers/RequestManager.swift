//
//  RequestManager.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//
 
 import Foundation
 import Alamofire
 
 class RequestManager {
  static let shared = RequestManager()
  
  func homeImageRequest(
    completion: @escaping (Result<HomeImages, AFError>) -> Void) {
    AF.request(
      RequestHome.mainImages.endPoint,
      method: .get
    ).validate(statusCode: [200])
      .responseDecodable(of: HomeImages.self) { res in
        completion(res.result)
    }
  }
  
  func MDRequest(
    count: Int? = nil,
    completion: @escaping (Result<MDItems, AFError>) -> Void) {
    if let count = count {
      AF.request(
        RequestHome.md.endPoint,
        method: .get,
        parameters: HomeGetQueryModel(count: count),
        encoder: URLEncodedFormParameterEncoder.default
      ).validate(statusCode: [200])
        .responseDecodable(of: MDItems.self) { res in
          completion(res.result)
      }
    } else {
      AF.request(
        RequestHome.md.endPoint,
        method: .get
      ).validate(statusCode: [200])
        .responseDecodable(of: MDItems.self) { res in
          completion(res.result)
      }
    }
  }
  
  func homeRequest(
    url: RequestHome,
    method requestMethod: HTTPMethod,
    count: Int? = nil,
    completion: @escaping (Result<HomeItems, AFError>) -> Void) {
    if let count = count {
      AF.request(
        url.endPoint,
        method: requestMethod,
        parameters: HomeGetQueryModel(count: count),
        encoder: URLEncodedFormParameterEncoder.default
      ).validate(statusCode: [200])
        .responseDecodable(of: HomeItems.self) { res in
          completion(res.result)
      }
    } else {
      AF.request(
        url.endPoint,
        method: requestMethod
      ).validate(statusCode: [200])
        .responseDecodable(of: HomeItems.self) { res in
          completion(res.result)
      }
    }
  }
  
  func detailRequest(
    url: RequestDetail,
    method requestMethod: HTTPMethod,
    productId: Int,
    completion: @escaping (Result<ProductModel, AFError>) -> Void) {
    AF.request(
      url.endPoint + "\(productId)/",
      method: requestMethod)
      .validate(statusCode: [200])
      .responseDecodable(of: ProductModel.self) { res in
        completion(res.result)
    }
  }
  
  func categoryRequest(
    url: RequestCategory,
    method requestMethod: HTTPMethod,
    categoryId: Int,
    completion: @escaping (Result<CategoryModel2, AFError>) -> Void) {
      AF.request(
        url.endPoint + "\(categoryId)/",
        method: requestMethod)
        .validate(statusCode: [200])
        .responseDecodable(of: CategoryModel2.self) { res in
          completion(res.result)
      }
  }
  
  private init() {}
 }
 
 // class SignupRequestManager {
 //  static let shared = SignupRequestManager()
 //
 //  func signUpRequest(
 //    url: RequestSignup,
 //    method requestMethod: HTTPMethod,
 //    encoder: ParameterEncoder,
 //    headers: [String: String],
 //    completion: @escaping (Result<MainModel, AFError>) -> Void) {
 //    AF.request(url.endPoint, method: requestMethod)
 //      .validate(statusCode: [200])
 //      .responseDecodable { res in
 //        completion(res.result)
 //    }
 //  }
 //    private init() {}
 // }
