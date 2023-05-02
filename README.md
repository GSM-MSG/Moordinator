# Moordinator

Navigation framework for iOS applications based on a Coordinator pattern

[Document](https://gsm-msg.github.io/Moordinator/documentation/moordinator/)

<br>

## Constents
- [Moordinator](#moordinator)
  - [Constents](#constents)
  - [Requirements](#requirements)
  - [Overview](#overview)
  - [Communication](#communication)
  - [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
  - [Usage](#usage)
    - [Quick Start](#quick-start)


## Requirements
- iOS 13.0+
- Swift 5+

<br>

## Overview
Navigation framework for iOS applications based on a Coordinator pattern

<br>

## Communication
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
 - If you want to contribute, submit a pull request.

<br>

## Installation

### Swift Package Manager
[Swift Package Manager](https://www.swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `Moordinator` into your Xcode project using Swift Package Manager, add it to the dependencies value of your Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/GSM-MSG/Moordinator.git", .upToNextMajor(from: "2.0.0"))
]
```

### Manually
If you prefer not to use either of the aforementioned dependency managers, you can integrate Moordinator into your project manually.

<br>

## Usage

### Quick Start

```swift
// create a path
import Moordinator

enum ExRoutePath: RoutePath {
    case main
}
```

```swift
// create a moordinator
import Moordinator
import Combine
import UIKit

final class MainMoordinator: Moordinator {
    private let rootVC = UINavigationController()

    var root: Presentable {
        rootVC
    }

    // navigation
    func route(to path: RoutePath) -> MoordinatorContributors {
        guard let path = path as? ExRoutePath else { return .none }
        switch path {
          case .main:
              let vc = UIViewController()
              rootVC.setViewControllers([vc], animated: true)
              return .one(.contribute(withNextPresentable: vc, withNextRouter: vc))
        }
        return .none
    }
}
```

[More](./MoordinatorExample/MoordinatorExample/)
