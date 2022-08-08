import Flutter
import UIKit
import Adyen

public class SwiftAdyenHelperPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "adyen_helper", binaryMessenger: registrar.messenger())
    let instance = SwiftAdyenHelperPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if(call.method == "encryptCreditCard") {
          self.encryptCardNumber(call: call, result: result)
      } else {
          result(FlutterMethodNotImplemented)
          return
      }
  }

  private func encryptCardNumber(call: FlutterMethodCall, result: FlutterResult) {
      if let args = call.arguments as? Dictionary<String, Any>,
         let cardNumber = args["number"] as? String,
         let expiryMonth = args["expiryMonth"] as? String,
         let expiryYear = args["expiryYear"] as? String,
         let securityCode = args["cvc"] as? String,
         let adyenKey = args["adyenKey"] as? String,
         let holder = args["holderName"] as? String {

          do {
              let encryptedCard: EncryptedCard = try CardEncryptor.encrypt(card: Card(number: cardNumber, securityCode: securityCode, expiryMonth: expiryMonth, expiryYear: expiryYear, holder: holder), with: adyenKey)

              var encryptedResults = [String : String]()
              encryptedResults["EncryptedExpiryMonth"] = encryptedCard.expiryMonth
              encryptedResults["EncryptedExpiryYear"] = encryptedCard.expiryYear
              encryptedResults["EncryptedCardNumber"] = encryptedCard.number
              encryptedResults["EncryptedSecurityCode"] = encryptedCard.securityCode

              result(encryptedResults)
          } catch {
             result(FlutterError.init(code: "Adyen encryption", message: error.localizedDescription, details: nil))
          }
       } else {
          result(FlutterError.init(code: "No arguments", message: nil, details: nil))
       }
    }
}
