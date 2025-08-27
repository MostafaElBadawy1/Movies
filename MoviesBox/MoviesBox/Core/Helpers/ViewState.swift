//
//  ViewState.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case paginating
  //  case error(String)
}
// case loaded([MovieListItem])
