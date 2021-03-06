import UIKit

final class ChooseCarByBrandController: UIViewController {

    private var mainView: ChooseCarByBrandView!
    private var carsRouter: CarsRouter!
    private lazy var listCarByBrandUsecase: ListCarsByBrandUsecase = ListCarsByBrandUsecaseFactory.make(
        presenter: self.mainView.presenter)

    init(carsRouter: CarsRouter, brand: Brand) {
        self.carsRouter = carsRouter
        super.init(nibName: nil, bundle: nil)
        let actions = [ChooseCarAction.didSelectBrandCar: didSelectBrandCar]
        mainView = ChooseCarByBrandView(parentView: view, actions: actions)
        listCarByBrandUsecase.list(byBrandName: brand.name)
        title = String.Navigation.Title.chooseCarBrand
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(Log.initCoder(from: ChooseCarByBrandController.self))
    }

    private func didSelectBrandCar(brandCar: BrandCar) {
        carsRouter.carForm(withBrandCar: brandCar)
    }

}
