import Foundation

protocol APIToDomainConvertable {
  associatedtype DomainModel
  
  var domainModel: DomainModel { get }
}
