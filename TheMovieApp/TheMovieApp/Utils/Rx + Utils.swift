//
//  Rx + Utils.swift
//  TheMovieApp
//
//  Created by Alexandre Vassinievski Ribeiro on 22/02/19.
//  Copyright © 2019 Alexandre Vassinievski Ribeiro. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectiveC

private var disposeBagContext: UInt8 = 0

extension Reactive where Base: Any {
    func synchronizedBag<T>( _ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
}

public extension Reactive where Base: Any {
    
    /// a unique DisposeBag that is related to the Reactive.Base instance only for Reference type
    public var disposeBag: DisposeBag {
        get {
            return synchronizedBag {
                if let disposeObject = objc_getAssociatedObject(base, &disposeBagContext) as? DisposeBag {
                    return disposeObject
                }
                let disposeObject = DisposeBag()
                objc_setAssociatedObject(base, &disposeBagContext, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return disposeObject
            }
        }
        
        set {
            synchronizedBag {
                objc_setAssociatedObject(base, &disposeBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

extension Observable where Element: Error {
    
    func mapError<T: Decodable>(_ type: T.Type) -> Observable<T?> {
        
        return self.map { error in
            if let errorResponse = error as? MoyaError,
                let data = errorResponse.response?.data {
                let result = try? JSONDecoder().decode(type, from: data)
                return result
            } else {
                return nil
            }
        }
    }
    
}

