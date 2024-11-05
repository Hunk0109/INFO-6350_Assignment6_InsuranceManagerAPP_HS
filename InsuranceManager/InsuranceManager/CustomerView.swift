import UIKit

class CustomerView: UIView {
    private let idTextField = UITextField()
    private let nameTextField = UITextField()
    private let ageTextField = UITextField()
    private let emailTextField = UITextField()
    private let addButton = UIButton(type: .system)
    private let updateButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let viewAllButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system) // Back button
    private let feedbackLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white

        configureTextField(idTextField, placeholder: "Enter Customer ID", isNumeric: true)
        configureTextField(nameTextField, placeholder: "Enter Name")
        configureTextField(ageTextField, placeholder: "Enter Age", isNumeric: true)
        configureTextField(emailTextField, placeholder: "Enter Email")

        setupButton(addButton, title: "Add Customer", action: #selector(addCustomer))
        setupButton(updateButton, title: "Update Customer", action: #selector(updateCustomer))
        setupButton(deleteButton, title: "Delete Customer", action: #selector(deleteCustomer))
        setupButton(viewAllButton, title: "View All Customers", action: #selector(viewAllCustomers))
        setupButton(backButton, title: "Back", action: #selector(goBack)) // Setup back button

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

            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            ageTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
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

            backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 15), // Positioning back button
            backButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),

            feedbackLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            feedbackLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            feedbackLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }

    @objc private func addCustomer() {
        guard let name = nameTextField.text, !name.isEmpty,
              let ageString = ageTextField.text, let age = Int(ageString),
              let email = emailTextField.text, !email.isEmpty else {
            feedbackLabel.text = "Please fill in all fields correctly."
            return
        }

        let newCustomer = Customer(id: Database.shared.getAllCustomers().count + 1, name: name, age: age, email: email)
        Database.shared.addCustomer(newCustomer)
        feedbackLabel.text = "Added Customer: \(name)"
        clearTextFields()
    }

    @objc private func updateCustomer() {
        guard let idString = idTextField.text, let id = Int(idString),
              let name = nameTextField.text, !name.isEmpty,
              let ageString = ageTextField.text, let age = Int(ageString) else {
            feedbackLabel.text = "Please fill in all fields correctly."
            return
        }

        if Database.shared.updateCustomer(id: id, name: name, age: age) {
            feedbackLabel.text = "Updated Customer ID: \(id)"
        } else {
            feedbackLabel.text = "Customer ID: \(id) not found."
        }
        clearTextFields()
    }

    @objc private func deleteCustomer() {
        guard let idString = idTextField.text, let id = Int(idString) else {
            feedbackLabel.text = "Please enter a valid Customer ID."
            return
        }

        let resultMessage = Database.shared.deleteCustomer(id: id)
        feedbackLabel.text = resultMessage
        clearTextFields()
    }

    @objc private func viewAllCustomers() {
        let customers = Database.shared.getAllCustomers()
        var displayText = "All Customers:\n"
        for customer in customers {
            displayText += "ID: \(customer.id), Name: \(customer.name), Age: \(customer.age), Email: \(customer.email)\n"
        }

        feedbackLabel.text = displayText.isEmpty ? "No customers found." : displayText
    }

    @objc private func goBack() {
        self.removeFromSuperview() // Remove the current view to go back
    }

    private func clearTextFields() {
        idTextField.text = ""
        nameTextField.text = ""
        ageTextField.text = ""
        emailTextField.text = ""
    }
}

#Preview {
    CustomerView()
}
