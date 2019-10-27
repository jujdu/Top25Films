//
//  TopFilmsInteractor.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 27.10.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol TopFilmsBusinessLogic {
  func makeRequest(request: TopFilms.Model.Request.RequestType)
}

class TopFilmsInteractor: TopFilmsBusinessLogic {

  var presenter: TopFilmsPresentationLogic?
  var service: TopFilmsService?
  
  func makeRequest(request: TopFilms.Model.Request.RequestType) {
    if service == nil {
      service = TopFilmsService()
    }
  }
  
}
