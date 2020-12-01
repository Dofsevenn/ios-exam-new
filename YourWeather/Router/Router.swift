//
//  Router.swift
//  YourWeather
//
//  Created by Kjetil Skyldstad Bjelldokken on 10/11/2020.
//

import Foundation
import SwiftUI
import Combine

class Router: ObservableObject {
    @Published var currentView = "home"
}
