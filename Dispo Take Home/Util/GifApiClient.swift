import UIKit
import Alamofire

enum GifAPIEndPoints : String{
    case trending = "trending"
    case search = "search"
}

struct GifAPIClient {

    private let baseUrl = "https://api.giphy.com/v1/gifs/"
    
    func endPoint(endPoint: GifAPIEndPoints) -> String {
        return baseUrl+endPoint.rawValue
    }
    func endPoint(value: String) -> String {
        return baseUrl+value
    }
    
    
    func requestTrendingGifs( completion: @escaping ([SearchResult]?) -> Void) {
        let requestUrl = endPoint(endPoint: .trending)+"?api_key=\(Constants.giphyApiKey)&limit=25&rating=pg"
    
        AF.request(requestUrl).responseData(completionHandler: { data in
            if data.error == nil,let data = data.data{
                let result:ResponseModel? = parse(json: data)
                completion(result?.data)
            }else{
                debugPrint(data.error ?? "")
            }
        })
         
    }
    
    func requestGifDetails(id:String, completion: @escaping (SearchResult?) -> Void) {
        let requestUrl = endPoint(value: id)+"?api_key=\(Constants.giphyApiKey)"
        
        AF.request(requestUrl).responseData(completionHandler: { data in
            if data.error == nil,let data = data.data{
                let result:GifDetailModel? = parse(json: data)
                completion(result?.data)
            }else{
                debugPrint(data.error ?? "")
            }
        })
    }
    
    
    func requestSearchGifs(query:String, completion:@escaping ([SearchResult]?) -> Void) {
        let requestUrl = endPoint(endPoint: .search)+"?api_key=\(Constants.giphyApiKey)&q=\(query)&limit=25&offset=0&rating=g&lang=en"
      
        AF.request(requestUrl).responseData(completionHandler: { data in
            if data.error == nil,let data = data.data{
                let result:ResponseModel? = parse(json: data)
                completion(result?.data)
            }else{
                debugPrint(data.error ?? "")
            }
        })
    }
    

    private func parse<T:Codable>(json: Data)->T? {
        let decoder = JSONDecoder()
        if let jsonModel = try? decoder.decode(T.self, from: json) {
            return jsonModel
        }
        return nil
    }
}
