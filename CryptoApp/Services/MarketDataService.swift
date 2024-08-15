





import Foundation
import Combine


class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            print("Error in URL Section")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("CG-9x6QTSjZjLfcvZKBeqwGGfGQ", forHTTPHeaderField: "x-cg-demo-api-key")
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnGlobalData in
                self?.marketData = returnGlobalData.data
            })
    }
}
