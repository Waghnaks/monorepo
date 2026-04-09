package ai.funfox.auth_phone

import android.app.Activity
import android.content.Intent
import android.content.IntentSender
import com.google.android.gms.auth.api.identity.GetPhoneNumberHintIntentRequest
import com.google.android.gms.auth.api.identity.Identity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class AuthPhonePlugin : FlutterPlugin,
    MethodChannel.MethodCallHandler,
    ActivityAware,
    PluginRegistry.ActivityResultListener {

    companion object {
        private const val channelName = "auth_phone/phone_number_hint"
        private const val phoneNumberHintRequestCode = 48231
    }

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var activityBinding: ActivityPluginBinding? = null
    private var pendingResult: MethodChannel.Result? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, channelName)
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "requestPhoneNumberHint" -> requestPhoneNumberHint(result)
            else -> result.notImplemented()
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        activityBinding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        detachFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        detachFromActivity()
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
    ): Boolean {
        if (requestCode != phoneNumberHintRequestCode) {
            return false
        }

        val methodResult = pendingResult ?: return false
        pendingResult = null

        if (resultCode != Activity.RESULT_OK || data == null) {
            methodResult.success(null)
            return true
        }

        val currentActivity = activity
        if (currentActivity == null) {
            methodResult.success(null)
            return true
        }

        runCatching {
            Identity.getSignInClient(currentActivity).getPhoneNumberFromIntent(data)
        }.onSuccess { phoneNumber ->
            methodResult.success(phoneNumber)
        }.onFailure {
            methodResult.success(null)
        }

        return true
    }

    private fun requestPhoneNumberHint(result: MethodChannel.Result) {
        val currentActivity = activity
        if (currentActivity == null || pendingResult != null) {
            result.success(null)
            return
        }

        val request = GetPhoneNumberHintIntentRequest.builder().build()
        val signInClient = Identity.getSignInClient(currentActivity)

        signInClient.getPhoneNumberHintIntent(request)
            .addOnSuccessListener { pendingIntent ->
                try {
                    pendingResult = result
                    currentActivity.startIntentSenderForResult(
                        pendingIntent.intentSender,
                        phoneNumberHintRequestCode,
                        null,
                        0,
                        0,
                        0,
                    )
                } catch (_: IntentSender.SendIntentException) {
                    pendingResult = null
                    result.success(null)
                }
            }
            .addOnFailureListener {
                result.success(null)
            }
    }

    private fun detachFromActivity() {
        activityBinding?.removeActivityResultListener(this)
        activityBinding = null
        activity = null
    }
}
