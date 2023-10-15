//
//  Modules.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public enum MicroTargetType: String, CaseIterable {
    case demo = "Demo"
    case interface = "Interface"
    case implement = ""
    case tests = "Tests"
    case testing = "Testing"
    
    public func dependencies() -> [MicroTargetType] {
        switch self {
        case .demo: return [.implement, .interface]
        case .interface: return []
        case .implement: return [.interface]
        case .tests: return [.testing]
        case .testing: return [.interface]
        }
    }
}

public enum Module {
    case product(Product)
    case app(App)
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
    
    public typealias AppPackage = (Product, App)
    public typealias FeaturePackage = (Product, Feature)
    public typealias DomainPackage = (Product, Domain)
    public typealias CorePackage = (Product, Core)
    public typealias SharedPackage = (Product, Shared)
}

public extension Module {
    static func appPackages(_ product: Product) -> [AppPackage] {
        switch product {
        case .Off: 
            return []
        }
    }
    
    static func featurePackages(_ product: Product) -> [FeaturePackage] {
        switch product {
        case .Off: 
            return [
                (.Off, .Empty)
            ]
        }
    }
    
    static func domainPackages(_ product: Product) -> [DomainPackage] {
        switch product {
        case .Off: 
            return []
        }
    }
    
    static func corePackages(_ product: Product) -> [CorePackage] {
        switch product {
        case .Off:
            return []
        }
    }
    
    static func sharedPackages(_ product: Product) -> [SharedPackage] {
        switch product {
        case .Off:
            return [
                (.Off, .DesignSystem),
                (.Off, .Util),
                (.Off, .Foundation),
                (.Off, .ThirdPartyLib)
            ]
        }
    }
}

// MARK: Product

public extension Module {
    enum Product: String, CaseIterable {
        case Off
        
        public static let name: String = "Product"
    }
}

// MARK: App

public extension Module {
    enum App: String, CaseIterable {
        case IOS
        case Watch
        case WatchExtension
        
        public static let name: String = "App"
    }
}


// MARK: Feature

public extension Module {
    enum Feature: String, CaseIterable {
        case Empty
        
        public static let name: String = "Feature"
        
        public var microTargetTypes: [MicroTargetType] {
            return MicroTargetType.allCases
        }
        
        func interfaceDependencies(_ product: Product) -> [FeaturePackage] {
            switch product {
            case .Off: return []
            }
        }
    }
}

// MARK: Domain

public extension Module {
    enum Domain: String, CaseIterable {
        case Empty
        
        public static let name: String = "Domain"
        
        public var microTargetTypes: [MicroTargetType] {
            return [.implement, .interface, .testing, .tests]
        }
    }
}

// MARK: Core

public extension Module {
    enum Core: String, CaseIterable {
        case Empty
        
        public static let name: String = "Core"
        
        public var microTargetTypes: [MicroTargetType] {
            return [.implement, .interface, .testing, .tests]
        }
    }
}

// MARK: Shared

public extension Module {
    enum Shared: String, CaseIterable {
        case Foundation
        case Util
        case DesignSystem
        case ThirdPartyLib
        
        public static let name: String = "Shared"
        
        public var microTargetTypes: [MicroTargetType] {
            return [.implement, .interface]
        }
    }
}

