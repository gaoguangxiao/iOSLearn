//
//  Publisher.swift
//  021_Swift的Combine
//
//  Created by 高广校 on 2023/12/21.
//

import Foundation
import Combine

//发布者
/**
 
 public protocol Publisher<Output, Failure> {

     /// The kind of values published by this publisher.
     associatedtype Output

     /// The kind of errors this publisher might publish.
     ///
     /// Use `Never` if this `Publisher` does not publish errors.
     associatedtype Failure : Error

     /// Attaches the specified subscriber to this publisher.
     ///
     /// Implementations of ``Publisher`` must implement this method.
     ///
     /// The provided implementation of ``Publisher/subscribe(_:)-4u8kn``calls this method.
     ///
     /// - Parameter subscriber: The subscriber to attach to this ``Publisher``, after which it can receive values.
     func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
 }
 
 */
