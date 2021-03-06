import UIKit

class ShowCarController: UIViewController {

    private var mainView: ShowCarView!
    private lazy var detailCarUsecase: DetailCarUsecase =
        DetailCarUsecaseFactory.make(presenter: self.mainView.presenter)

    init(brandCar: BrandCar) {
        super.init(nibName: nil, bundle: nil)
        mainView = ShowCarView(parentView: view)
        detailCarUsecase.detail(byCode: brandCar.code, andYear: brandCar.year)
        title = brandCar.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(Log.initCoder(from: ShowCarController.self))
    }

}
