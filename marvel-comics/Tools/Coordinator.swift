//
//  Coordinator.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 10/12/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    var title: String { get }
}
