//
//  Observer.swift
//  021_Swift的Combine
//
//  Created by 高广校 on 2023/12/21.
//

import Foundation

// 可观察协议
protocol Observable {
    associatedtype T: Observer
    mutating func attach(observer: T)
}

// 观察者协议
protocol Observer {
    associatedtype State
    func notify(_ state: State)
}

struct AnyObserver<S>: Observer {

    private let name: String

    init(name: String) {
        self.name = name
    }

    func notify(_ state: S) {
        print("\(name)'s state updated to \(state)")
    }
}

// 遵循可观察协议
struct AnyObservable<T: Observer>: Observable{

    var state: T.State {
        didSet {
            notifyStateChange()
        }
    }

    var observers: [T] = []

    init(_ state: T.State) {
        self.state = state
    }

    mutating func attach(observer: T) {
        observers.append(observer)
        observer.notify(state)
    }

    private func notifyStateChange() {
        for observer in observers {
            observer.notify(state)
        }
    }
}
