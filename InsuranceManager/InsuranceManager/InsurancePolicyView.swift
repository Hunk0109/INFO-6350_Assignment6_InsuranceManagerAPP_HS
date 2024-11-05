import UIKit

class InsurancePolicyView: UIView {
    private let idTextField = UITextField()
    private let customerIdTextField = UITextField()
    private let policyTypeTextField = UITextField()
    private let premiumAmountTextField = UITextField()
    private let startDateTextField = UITextField()
    private let endDateTextField = UITextField()
    private let addButton = UIButton(type: .system)
    private let updateButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let viewAllButton = UIButton(type: .system)
    private let feedbackLabel = UILabel()
    private let backButton = UIButton(type: .system) // Back button

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white

        configureTextField(idTextField, placeholder: "Enter Policy ID", isNumeric: true)
        configureTextField(customerIdTextField, placeholder: "Enter Customer ID", isNumeric: true)
        configureTextField(policyTypeTextField, placeholder: "Enter Policy Type")
        configureTextField(premiumAmountTextField, placeholder: "Enter Premium Amount", isNumeric: true)
        configureTextField(startDateTextField, placeholder: "Enter Start Date (yyyy-MM-dd)")
        configureTextField(endDateTextField, placeholder: "Enter End Date (yyyy-MM-dd)")

        setupButton(addButton, title: "Add Policy", action: #selector(addPolicy))
        setupButton(updateButton, title: "Update Policy", action: #selector(updatePolicy))
        setupButton(deleteButton, title: "Delete Policy", action: #selector(deletePolicy))
        setupButton(viewAllButton, title: "View All Policies", action: #selector(viewAllPolicies))

        // Setup Back Button
        setupButton(backButton, title: "Back", action: #selector(goBack))

        feedbackLabel.textAlignment = .center
        feedbackLabel.numberOfLines = 0
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(feedbackLabel)

        layoutElements()
    }

    private func configureTextField(_ textField: UITextField, placeholder: String, isNumeric: Bool = false) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        if isNumeric {
            textField.keyboardType = .numberPad
        }
        self.addSubview(textField)
    }

    private func setupButton(_ button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        self.addSubview(button)
    }

    private func layoutElements() {
        NSLayoutConstraint.activate([
            idTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            idTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            idTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            customerIdTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customerIdTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20),
            customerIdTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            policyTypeTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            policyTypeTextField.topAnchor.constraint(equalTo: customerIdTextField.bottomAnchor, constant: 20),
            policyTypeTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            premiumAmountTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            premiumAmountTextField.topAnchor.constraint(equalTo: policyTypeTextField.bottomAnchor, constant: 20),
            premiumAmountTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            startDateTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startDateTextField.topAnchor.constraint(equalTo: premiumAmountTextField.bottomAnchor, constant: 20),
            startDateTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            endDateTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            endDateTextField.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: 20),
            endDateTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: endDateTextField.bottomAnchor, constant: 30),
            addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            updateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15),
            updateButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 15),
            deleteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            viewAllButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewAllButton.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 15),
            viewAllButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            feedbackLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            feedbackLabel.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 20),
            feedbackLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }

    @objc private func addPolicy() {
           guard let customerIdString = customerIdTextField.text, let customerId = Int(customerIdString),
                 let policyType = policyTypeTextField.text, !policyType.isEmpty,
                 let premiumAmountString = premiumAmountTextField.text,
                 let premiumAmount = Double(premiumAmountString),
                 let startDateString = startDateTextField.text, !startDateString.isEmpty,
                 let endDateString = endDateTextField.text, !endDateString.isEmpty else {
               feedbackLabel.text = "Please fill in all fields correctly."
               return
           }

           // Validate date format and check start date before end date
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           
           guard let startDate = dateFormatter.date(from: startDateString),
                 let endDate = dateFormatter.date(from: endDateString) else {
               feedbackLabel.text = "Please enter valid dates in the format yyyy-MM-dd."
               return
           }
           
           guard startDate <= endDate else {
               feedbackLabel.text = "End date cannot be before start date."
               return
           }

           let newPolicy = InsurancePolicyPlan(id: Database.shared.getAllInsurancePolicies().count + 1,
                                               customerId: customerId,
                                               policyType: policyType,
                                               premiumAmount: premiumAmount,
                                               startDate: startDateString,
                                               endDate: endDateString)

           Database.shared.addInsurancePolicy(newPolicy)
           feedbackLabel.text = "Added Policy for Customer ID: \(customerId)"
           clearTextFields()
       }
    
    @objc private func updatePolicy() {
        guard let idString = idTextField.text, let id = Int(idString) else {
            feedbackLabel.text = "Please enter a valid Policy ID."
            return
        }

        // Retrieve existing policy
        guard let existingPolicyIndex = Database.shared.getAllInsurancePolicies().firstIndex(where: { $0.id == id }) else {
            feedbackLabel.text = "Policy ID: \(id) not found."
            return
        }
        
        var policyToUpdate = Database.shared.getAllInsurancePolicies()[existingPolicyIndex]

        // Update fields only if they are filled
        if let policyType = policyTypeTextField.text, !policyType.isEmpty {
            policyToUpdate.policyType = policyType
        }
        
        if let premiumAmountString = premiumAmountTextField.text, let premiumAmount = Double(premiumAmountString) {
            policyToUpdate.premiumAmount = premiumAmount
        }
        
        if let endDate = endDateTextField.text, !endDate.isEmpty {
            // Validate date format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let startDate = dateFormatter.date(from: policyToUpdate.startDate),
                  let endDateDate = dateFormatter.date(from: endDate) else {
                feedbackLabel.text = "Please enter a valid end date in the format yyyy-MM-dd."
                return
            }

            guard startDate <= endDateDate else {
                feedbackLabel.text = "End date cannot be before start date."
                return
            }
            
            policyToUpdate.endDate = endDate
        }

        // Update the policy in the database
        Database.shared.updateInsurancePolicy(id: id, policyType: policyToUpdate.policyType, premiumAmount: policyToUpdate.premiumAmount, endDate: policyToUpdate.endDate)

        feedbackLabel.text = "Updated Policy ID: \(id)"
        clearTextFields()
    }


    @objc private func deletePolicy() {
        guard let idString = idTextField.text, let id = Int(idString) else {
            feedbackLabel.text = "Please enter a valid Policy ID."
            return
        }

        let resultMessage = Database.shared.deleteInsurancePolicy(id: id)
        feedbackLabel.text = resultMessage
        clearTextFields()
    }

    @objc private func viewAllPolicies() {
        let policies = Database.shared.getAllInsurancePolicies()
        var displayText = "All Insurance Policies:\n"
        for policy in policies {
            displayText += "ID: \(policy.id), Customer ID: \(policy.customerId), Type: \(policy.policyType), Premium: \(policy.premiumAmount), Start: \(policy.startDate), End: \(policy.endDate)\n"
        }
        
        feedbackLabel.text = displayText.isEmpty ? "No policies found." : displayText
    }

    @objc private func goBack() {
        self.removeFromSuperview()
    }

    private func clearTextFields() {
        idTextField.text = ""
        customerIdTextField.text = ""
        policyTypeTextField.text = ""
        premiumAmountTextField.text = ""
        startDateTextField.text = ""
        endDateTextField.text = ""
    }
}
