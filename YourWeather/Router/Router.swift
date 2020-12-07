//
//  Router.swift
//  YourWeather
//
// The reference to the sources I have been inspired by for the code in this file is in the README.md

import Foundation
import SwiftUI
import Combine

class Router: ObservableObject {
    @Published var currentView = "home"
}
