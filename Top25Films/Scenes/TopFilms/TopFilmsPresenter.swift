//
//  TopFilmsPresenter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 27.10.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol TopFilmsPresentationLogic {
  func presentData(response: TopFilms.Model.Response.ResponseType)
}

class TopFilmsPresenter: TopFilmsPresentationLogic {
  weak var viewController: TopFilmsDisplayLogic?
  
  func presentData(response: TopFilms.Model.Response.ResponseType) {
  
  }
  
}
