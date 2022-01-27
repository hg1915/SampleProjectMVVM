

import Foundation

class MainViewModel{
    //other options include delegate patterns, publlished vars
    var apiResultUpdated:()->Void = {}
    
    let apiClient = GifAPIClient()
    
    var searchResults : [SearchResult] = []
    
    func fetchTrending(){
        apiClient.requestTrendingGifs { searchResults in
            self.searchResults = searchResults ?? []
            self.apiResultUpdated()
        }
    }
    func searchGif(query:String){
        apiClient.requestSearchGifs(query: query) { searchResults in
            self.searchResults = searchResults ?? []
            self.apiResultUpdated()
        }
    }
}
