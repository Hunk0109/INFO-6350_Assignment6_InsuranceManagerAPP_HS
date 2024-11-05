import UIKit

class MainView: UIView {
    private let showCustomerViewButton = UIButton(type: .system)
    private let showInsurancePolicyViewButton = UIButton(type: .system)
    private let showDisplayViewButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white

        showCustomerViewButton.setTitle("Customer Policies", for: .normal)
        showCustomerViewButton.addTarget(self, action: #selector(showCustomerView), for: .touchUpInside)
        showCustomerViewButton.frame = CGRect(x: 50, y: 100, width: 300, height: 50)
        self.addSubview(showCustomerViewButton)

        
        showInsurancePolicyViewButton.setTitle("Manage Insurance Policies", for: .normal)
        showInsurancePolicyViewButton.addTarget(self, action: #selector(showInsurancePolicyView), for: .touchUpInside)
        showInsurancePolicyViewButton.frame = CGRect(x: 50, y: 200, width: 300, height: 50)
        self.addSubview(showInsurancePolicyViewButton)

    }
    
    
    @objc private func showCustomerView() {
        let customerView = CustomerView(frame: self.bounds)
        self.addSubview(customerView)
    }
    @objc private func showInsurancePolicyView() {
        let insurancePolicyView = InsurancePolicyView(frame: self.bounds)
        self.addSubview(insurancePolicyView)
    }
}

#Preview{
    MainView()
}
