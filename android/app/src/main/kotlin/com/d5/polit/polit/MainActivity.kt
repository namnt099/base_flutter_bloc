package com.d5.polit.polit

import android.annotation.SuppressLint
import com.synodus.wallet.deleteAllWallet
import com.synodus.wallet.eraseWallet
import com.synodus.wallet.exportWallet
import com.synodus.wallet.getListWallet
import com.synodus.wallet.importWallet
import com.synodus.wallet.signTransactionETHToken
import com.synodus.wallet.signTransactionTronToken
import com.synodus.wallet.updateWalletName
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.security.KeyManagementException
import java.security.NoSuchAlgorithmException
import java.security.SecureRandom
import java.security.cert.CertificateException
import java.security.cert.X509Certificate
import javax.net.ssl.*

class MainActivity : FlutterFragmentActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }

    private var channel: MethodChannel? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter/trust_wallet")
        channel?.setMethodCallHandler { call, _ ->
            methodCallHandle(call)
        }
        disableSSLCertificateChecking()
    }

    private fun disableSSLCertificateChecking() {
        val trustAllCerts: Array<TrustManager> =
            arrayOf(@SuppressLint("CustomX509TrustManager") object : X509TrustManager {

                @SuppressLint("TrustAllX509TrustManager")
                @Throws(CertificateException::class)
                override fun checkClientTrusted(arg0: Array<X509Certificate?>?, arg1: String?) {
                }

                @SuppressLint("TrustAllX509TrustManager")
                @Throws(CertificateException::class)
                override fun checkServerTrusted(arg0: Array<X509Certificate?>?, arg1: String?) {
                }

                override fun getAcceptedIssuers(): Array<X509Certificate>? {
                    return null
                }
            })
        try {
            val sc: SSLContext = SSLContext.getInstance("TLS")
            sc.init(null, trustAllCerts, SecureRandom())
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.socketFactory)
            HttpsURLConnection.setDefaultHostnameVerifier { _, _ -> true }
        } catch (e: KeyManagementException) {
            e.printStackTrace()
        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        }
    }

    private fun methodCallHandle(call: MethodCall) {
        when (call.method) {
            "importWallet" -> {
                val hasMap = this.importWallet(
                    type = call.argument<String>("type") ?: return,
                    chainType = call.argument<String>("chainType") ?: return,
                    content = call.argument<String>("content") ?: return,
                    walletName = call.argument<String>("walletName") ?: return
                )
                channel?.invokeMethod("importWalletCallBack", hasMap)
            }

            "exportWallet" -> {
                val hasMap = this.exportWallet(
                    walletAddress = call.argument<String>("walletAddress") ?: return
                )
                channel?.invokeMethod("exportWalletCallBack", hasMap)
            }

            "eraseWallet" -> {
                val hasMap = this.eraseWallet(
                    walletName = call.argument<String>("walletName") ?: return
                )
                channel?.invokeMethod("eraseWalletCallBack", hasMap)
            }

            "deleteAllWallet" -> {
                val hasMap = this.deleteAllWallet()
                channel?.invokeMethod("deleteWalletByLogoutCallBack", hasMap)
            }

            "updateWalletName" -> {
                val hasMap = this.updateWalletName(
                    walletNameOld = call.argument<String>("walletNameOld") ?: return,
                    walletNameNew = call.argument<String>("walletNameNew") ?: return
                )
                channel?.invokeMethod("updateWalletNameCallBack", hasMap)
            }

            "getListWallet" -> {
                val hasMap = this.getListWallet()
                channel?.invokeMethod("getListWalletCallBack", hasMap)
            }

            "signTransactionETHToken" -> {
                val hasMap =
                    this.signTransactionETHToken(
                        walletAddress = call.argument<String>("walletAddress") ?: return,
                        tokenAddress = call.argument<String>("tokenAddress") ?: return,
                        toAddress = call.argument<String>("toAddress") ?: return,
                        nonce = call.argument<String>("nonce") ?: return,
                        chainId = call.argument<String>("chainId") ?: return,
                        gasPrice = call.argument<String>("gasPrice") ?: return,
                        gasLimit = call.argument<String>("gasLimit") ?: return,
                        gasFee = call.argument<String>("gasFee") ?: return,
                        amount = call.argument<String>("amount") ?: return,
                        symbol = call.argument<String>("symbol") ?: return,
                    )
                channel?.invokeMethod("signTransactionETHTokenCallBack", hasMap)
            }

            "signTransactionTronToken" -> {
                val hasMap =
                    this.signTransactionTronToken(
                        walletAddress = call.argument<String>("walletAddress") ?: return,
                        toAddress = call.argument<String>("toAddress") ?: return,
                        tokenAddress = call.argument<String>("tokenAddress") ?: return,
                        symbol = call.argument<String>("symbol") ?: return,
                        amount = call.argument<String>("amount") ?: return,
                        timestamp = call.argument<String>("timestamp") ?: return,
                        txTrieRoot = call.argument<String>("txTrieRoot") ?: return,
                        parentHash = call.argument<String>("parentHash") ?: return,
                        witnessAddress = call.argument<String>("witnessAddress") ?: return,
                        number = call.argument<String>("number") ?: return,
                        version = call.argument<Int>("version") ?: return
                    )
                channel?.invokeMethod("signTransactionTronTokenCallBack", hasMap)
            }
        }
    }
}