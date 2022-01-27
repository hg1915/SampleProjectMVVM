

import Foundation

class DetailViewModel{
    var apiResultUpdated:()->Void = {}
    
    let apiClient = GifAPIClient()
    
    var gifDetails : SearchResult?
    
    
    func fetchGifDetails(id:String){
        apiClient.requestGifDetails(id: id) { result in
            self.gifDetails = result
            self.apiResultUpdated()
        }
    }
}
