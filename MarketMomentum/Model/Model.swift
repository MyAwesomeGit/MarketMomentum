
import Foundation

class StockWebService {
    
    func fetchStockData(symbol: String, completion: @escaping (Stock?) -> Void) {
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(symbol)/range/1/day/2024-01-01/2024-12-31?apiKey=\(APIKey.apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let string = String(data: data, encoding: .utf8)
                print("API Response: \(string ?? "")")
                let decoder = JSONDecoder()
                let response = try decoder.decode(PolygonResponse.self, from: data)
                if let firstResult = response.results.first {
                    let stock = Stock(id: symbol, symbol: symbol, description: "", price: firstResult.c)
                    completion(stock)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed to decode stock data: \(error)")
                completion(nil)
            }
        }.resume()
    }
}


struct PolygonResponse: Codable {
    let results: [Agg]
    
    struct Agg: Codable {
        let c: Double
        // TODO: Include other necessary fields
    }
}
