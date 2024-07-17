import SwiftUI

struct ContentView: View {
    @State private var stockSymbol = ""
    @State private var stock: Stock?
    
    var body: some View {
        ZStack {
            Color(mainBackgroundColor)
                .edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Enter stock symbol, e.g. AAPL", text: $stockSymbol)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.system(size: 24))
                
                Button(action: {
                    loadStockData(symbol: stockSymbol)
                }) {
                    Text("Search")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0))
                        .cornerRadius(10)
                }
                
                if let stock = stock {
                    VStack(alignment: .leading) {
                        Text("\(stock.price, specifier: "%.2f") $")
                            .font(.largeTitle)
                            .foregroundColor(mainFontColor)
                    }
                    
                }
            }
            .onAppear(perform: {
                DispatchQueue.main.async {
                    loadStockData(symbol: stockSymbol)
                }
            })
        }
    }
    
    private func loadStockData(symbol: String) {
        StockWebService().fetchStockData(symbol: symbol) { fetchedStock in
            self.stock = fetchedStock
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
