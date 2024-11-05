import UIKit

class DisplayView: UIView {
    private var outputTextView: UITextView = UITextView()
    private let backButton: UIButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white

        // Configure output text view
        outputTextView.layer.borderColor = UIColor.gray.cgColor
        outputTextView.layer.borderWidth = 1.0
        outputTextView.isEditable = false
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(outputTextView)

        // Configure back button
        backButton.setTitle("Back", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.addSubview(backButton)

        // Layout constraints
        
        NSLayoutConstraint.activate([
            outputTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            outputTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            outputTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            outputTextView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),

            backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func displayCustomers(_ customers: [Customer]) {
        outputTextView.text = customers.isEmpty ? "No customers found." : customers.map { "ID: \($0.id), Name: \($0.name), Age: \($0.age), Email: \($0.email)" }.joined(separator: "\n")
    }

    // Method to display all insurance policies
    func displayInsurancePolicies(_ policies: [InsurancePolicyPlan]) {
        outputTextView.text = policies.isEmpty ? "No policies found." : policies.map { "ID: \($0.id), Customer ID: \($0.customerId), Type: \($0.policyType), Premium: \($0.premiumAmount), Start: \($0.startDate), End: \($0.endDate)" }.joined(separator: "\n")
    }

    @objc private func goBack() {
        self.removeFromSuperview() // Remove the current view
    }
}
