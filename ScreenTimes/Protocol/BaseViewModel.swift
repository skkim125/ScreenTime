//
//  ViewModelType.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/15/24.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
