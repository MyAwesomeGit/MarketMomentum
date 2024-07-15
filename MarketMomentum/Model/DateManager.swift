import Foundation

struct DateManager {
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Calculate the date of the previous day.
        // The API offers data up until the end of the previous day.
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.day! -= 1 // Subtract one day
        let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: components.date ?? Date())!
        // Return the date of one day ago as a string
        return dateFormatter.string(from: oneDayAgo)
    }
}
