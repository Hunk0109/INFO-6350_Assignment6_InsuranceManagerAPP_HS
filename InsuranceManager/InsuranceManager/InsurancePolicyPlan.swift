import Foundation

class InsurancePolicyPlan {
    var id: Int
    var customerId: Int
    var policyType: String
    var premiumAmount: Double
    var startDate: String
    var endDate: String

    init(id: Int, customerId: Int, policyType: String, premiumAmount: Double, startDate: String, endDate: String) {
        self.id = id
        self.customerId = customerId
        self.policyType = policyType
        self.premiumAmount = premiumAmount
        self.startDate = startDate
        self.endDate = endDate
    }
}
