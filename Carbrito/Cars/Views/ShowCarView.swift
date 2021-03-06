import UIKit

final class ShowCarView: UIView, CarbritoView {

    var emptyView: EmptyView!

    private let nameLabel = ShowCarViewLabelFactory.make(text: String.ShowCarView.Label.name)
    private let carNameLabel = ShowCarViewValueLabelFactory.make()
    private let codeLabel = ShowCarViewLabelFactory.make(text: String.ShowCarView.Label.code)
    private let carCodeLabel = ShowCarViewValueLabelFactory.make()
    private let yearLabel = ShowCarViewLabelFactory.make(text: String.ShowCarView.Label.year)
    private let carYearLabel = ShowCarViewValueLabelFactory.make()
    private let brandLabel = ShowCarViewLabelFactory.make(text: String.ShowCarView.Label.brand)
    private let carBrandLabel = ShowCarViewValueLabelFactory.make()
    private let priceLabel = ShowCarViewLabelFactory.make(text: String.ShowCarView.Label.price)
    private let carPriceLabel = ShowCarViewValueLabelFactory.make()
    private let taxLabel = ShowCarViewLabelFactory.make(text: String.ShowCarView.Label.tax)
    private let carTaxLabel = ShowCarViewValueLabelFactory.make()

    private let itemsStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 24
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var labelAndValueStack: UIStackView {
        let stack = UIStackView()
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private var divider: UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .divider
        return view
    }

    private(set) lazy var presenter: GenericPresenter<Car> = GenericPresenterFactory<Car>.make({ cars in
        self.present(cars: cars)
    }, presentError, presentEmpty)

    init(parentView: UIView) {
        super.init(frame: .zero)
        setupView(parentView: parentView)
        setupItemsStackView()
        setupLabels()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(Log.initCoder(from: ShowCarView.self))
    }

    private func setupItemsStackView() {
        addSubview(itemsStackView)
        let margin: CGFloat = 16
        itemsStackView.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        itemsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        itemsStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
        itemsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
    }

    private func setupLabels() {
        let labels = [
            [nameLabel, carNameLabel], [codeLabel, carCodeLabel], [yearLabel, carYearLabel],
            [brandLabel, carBrandLabel], [priceLabel, carPriceLabel], [taxLabel, carTaxLabel]
        ]
        labels.forEach { labels in
            let labelStack = labelAndValueStack
            labelStack.addArrangedSubview(labels.first!)
            labelStack.addArrangedSubview(labels.last!)
            itemsStackView.addArrangedSubview(labelStack)
        }
    }

    private func present(cars: [Car]) {
        DispatchQueue.main.async {
            let car = cars[0]
            self.carNameLabel.text = car.name
            self.carCodeLabel.text = car.code
            self.carYearLabel.text = car.year
            self.carBrandLabel.text = car.brand
            self.carPriceLabel.text = self.price(price: car.price)
            self.carTaxLabel.text = "\(car.tax)%"
            self.presentValues()
        }
    }

    private func presentValues() {
        UIView.animate(withDuration: 0.35, animations: {
            self.carNameLabel.alpha = 1
            self.carCodeLabel.alpha = 1
            self.carYearLabel.alpha = 1
            self.carBrandLabel.alpha = 1
            self.carPriceLabel.alpha = 1
            self.carTaxLabel.alpha = 1
        })
    }

    private func price(price: Float) -> String {
        let price = NSNumber(value: price)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: price) ?? ""
    }

}
