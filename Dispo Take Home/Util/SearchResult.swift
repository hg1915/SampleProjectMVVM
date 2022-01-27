import UIKit


struct ResponseModel : Codable{
    var data: [SearchResult]
}

struct GifDetailModel : Codable{
    var data: SearchResult
}

struct SearchResult : Codable{
    var id: String
    var source : String
    //var gifUrl: URL
    var title: String
    var rating : String
    var images : Images
    
    
    struct Images : Codable{
        var downsized : Downsized
        
        struct Downsized : Codable{
            var width : String
            var height: String
            var url : String
        }
    }
}
