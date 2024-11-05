import Foundation

class Database {
    static let shared = Database()
    
    private var customers: [Customer] = []
    private var insurancePolicies: [InsurancePolicyPlan] = []
    
    private init() {}
    
    // CRUD Operations for Customers
    func addCustomer(_ customer: Customer) {
        customers.append(customer)
    }
    
    func updateCustomer(id: Int, name: String, age: Int) -> Bool {
        if let index = customers.firstIndex(where: { $0.id == id }) {
            customers[index].name = name
            customers[index].age = age
            return true
        }
        return false
    }
    
    func deleteCustomer(id: Int) -> String {
        if insurancePolicies.contains(where: { $0.customerId == id }) {
            return "Cannot delete customer with active insurance policies."
        }
        customers.removeAll { $0.id == id }
        return "Deleted customer successfully."
    }
    
    func getAllCustomers() -> [Customer] {
        return customers
    }
    
    // CRUD Operations for Insurance Policy Plans
    func addInsurancePolicy(_ policy: InsurancePolicyPlan) {
        insurancePolicies.append(policy)
    }
    
    func updateInsurancePolicy(id: Int, policyType: String, premiumAmount: Double, endDate: String) -> Bool {
        if let index = insurancePolicies.firstIndex(where: { $0.id == id }) {
            insurancePolicies[index].policyType = policyType
            insurancePolicies[index].premiumAmount = premiumAmount
            insurancePolicies[index].endDate = endDate
            return true
        }
        return false
    }
    
    func deleteInsurancePolicy(id: Int) -> String {
        guard let policy = insurancePolicies.first(where: { $0.id == id }) else {
            return "Policy ID: \(id) not found."
        }
        
        if isPolicyActive(policy: policy) {
            return "Cannot delete active policy."
        }
        
        insurancePolicies.removeAll { $0.id == id }
        return "Deleted policy successfully."
    }
    
    
    func getAllInsurancePolicies() -> [InsurancePolicyPlan] {
        return insurancePolicies
    }
    
    private func isPolicyActive(policy: InsurancePolicyPlan) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let endDate = formatter.date(from: policy.endDate) else { return false }
        return Date() < endDate
    }
}
