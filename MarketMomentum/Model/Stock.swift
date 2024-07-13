
struct Stock: Codable, Identifiable {
    let id: String
    let symbol: String
    let description: String
    let price: Double
}
