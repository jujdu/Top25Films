//
//  TopFilmsViewController.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 27.10.2019.
//  Copyright (c) 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol TopFilmsDisplayLogic: class {
  func displayData(viewModel: TopFilms.Model.ViewModel.ViewModelData)
}

class TopFilmsViewController: UIViewController, TopFilmsDisplayLogic {

  var interactor: TopFilmsBusinessLogic?
  var router: (NSObjectProtocol & TopFilmsRoutingLogic)?

  // MARK: Object lifecycle
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = TopFilmsInteractor()
    let presenter             = TopFilmsPresenter()
    let router                = TopFilmsRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func displayData(viewModel: TopFilms.Model.ViewModel.ViewModelData) {

  }
  
}
