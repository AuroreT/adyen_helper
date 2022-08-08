package com.auroret.adyen_helper

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.adyen.checkout.cse.CardEncrypter
import com.adyen.checkout.cse.UnencryptedCard
import java.util.*

/** AdyenHelperPlugin */
class AdyenHelperPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "adyen_helper")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method) {
      "encryptCreditCard" -> {
        encryptCardNumber(call, result)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun encryptCardNumber(call: MethodCall, result: MethodChannel.Result) {
    val map = call.arguments as HashMap<String, Any>?
    if(map != null) {
      try {
        val cardNumber = map["number"].toString()
        val expiryMonth = map["expiryMonth"].toString()
        val expiryYear = map["expiryYear"].toString()
        val cvc = map["cvc"].toString()
        val holderName = map["holderName"].toString()
        val adyenKey = map["adyenKey"].toString()

        val unencryptedCard = UnencryptedCard.Builder()
          .setNumber(cardNumber)
          .setExpiryMonth(expiryMonth)
          .setExpiryYear(expiryYear)
          .setCvc(cvc)
          .setHolderName(holderName)
          .build()

        val encryptedCard = CardEncrypter.encryptFields(unencryptedCard, adyenKey)
        val resultMap: HashMap<String, String> = HashMap()
        encryptedCard.encryptedExpiryMonth?.let { resultMap.put("EncryptedExpiryMonth", it) }
        encryptedCard.encryptedExpiryYear?.let { resultMap.put("EncryptedExpiryYear", it) }
        encryptedCard.encryptedCardNumber?.let { resultMap.put("EncryptedCardNumber", it) }
        encryptedCard.encryptedSecurityCode?.let { resultMap.put("EncryptedSecurityCode", it) }

        result.success(resultMap)
      } catch (e: Exception) {
        result.error("Adyen encryption", e.message, "")
      }
    } else {
      result.error("No arguments", "", "")
    }
  }
}
