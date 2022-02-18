import Foundation

struct NewsApi {

     let ApiKey = "56639ef118c242cbaed60a806d781c3e"
     let baseUrlString = "https://newsapi.org/v2/"
     let topHeadline = "top-headlines?country=ua"
    
     var fullUrlPath: String  {
         "\(baseUrlString)\(topHeadline)&apiKey=\(ApiKey)"
    }
}
