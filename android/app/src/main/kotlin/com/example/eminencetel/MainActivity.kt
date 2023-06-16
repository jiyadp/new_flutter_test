package com.example.eminencetel

import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.content.Intent
import android.content.BroadcastReceiver
import android.content.IntentFilter
import android.Manifest
import android.content.ContextWrapper
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.widget.TextView
import android.widget.Toast
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_DURATION
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_INTERVAL
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_EMAIL
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_USER_ID
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_EMPLOYEE_ID
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_TASK_NO
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_SITE_ID
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_SITE_NAME
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_SITE_ADDRESS
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_SITE_LATITUDE
import com.example.eminencetel.CountDownTimerService.Companion.INTENT_EXTRA_SITE_LONGITUDE
import android.R.attr.name
import android.app.NotificationChannel
import android.app.NotificationManager
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.lifecycle.MutableLiveData
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.embedding.engine.FlutterEngine
import com.example.eminencetel.MyStreamHandler
import android.util.Log


class MainActivity: FlutterActivity() {

    private val CHANNEL = "callback_channel"
    private lateinit var flutterEngine: FlutterEngine
    private val CHANNEL_ID = "ForegroundCountdownServiceChannel"
    private val NOTIFICATION_ID = 1
    private val notificationManager by lazy { getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager }
    private lateinit var serviceIntent: Intent

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        this.flutterEngine = flutterEngine
        super.configureFlutterEngine(flutterEngine)
        Log.d("MainActivity","configureFlutterEngine invoked")

        serviceIntent = Intent(this, CountDownTimerService::class.java)
        createNotificationChannel()
        initServiceMethods()
    }


    private fun initServiceMethods() {
        Log.d("MainActivity","initServiceMethods invoked")
        val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "my_event_channel")
        val streamHandler = MyStreamHandler()
        eventChannel.setStreamHandler(streamHandler)
        val mMessageReceiver: BroadcastReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                val message = intent.getStringExtra("Status")
                message?.let {
                    streamHandler.sendData(message)
                }
            }
        }
        LocalBroadcastManager.getInstance(this).registerReceiver(mMessageReceiver, IntentFilter("CountDownUpdates"))

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            val duration = call.argument("duration") as String?
            val interval = call.argument("interval") as String?
            val userId = call.argument("userId") as String?
            val email = call.argument("email") as String?
            val employeeId = call.argument("employeeId") as String?
            val taskNo = call.argument("taskNo") as String?
            val siteId = call.argument("siteId") as String?
            val siteName = call.argument("siteName") as String?
            val siteAddress = call.argument("siteAddress") as String?
            val latitude = call.argument("latitude") as String?
            val longitude = call.argument("longitude") as String?

            val durationInMinutes = duration?.toLong() ?: 0L
            val intervalInMinutes = interval?.toLong() ?: 0L

            when (call.method) {
                "startService","restartService" -> {
                    Log.d("TAG","started Service $durationInMinutes -- $intervalInMinutes")

                    // Start the service using Intent
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        val action = if (call.method == "startService") {
                            CountDownTimerService.ACTION_START_FOREGROUND_SERVICE
                        } else {
                            CountDownTimerService.ACTION_RESTART_FOREGROUND_SERVICE
                        }
                        serviceIntent?.action = action
                        serviceIntent?.putExtra(INTENT_EXTRA_DURATION, durationInMinutes)
                        serviceIntent?.putExtra(INTENT_EXTRA_INTERVAL, intervalInMinutes)
                        serviceIntent?.putExtra(INTENT_EXTRA_EMAIL, email)
                        serviceIntent?.putExtra(INTENT_EXTRA_USER_ID, userId)
                        serviceIntent?.putExtra(INTENT_EXTRA_EMPLOYEE_ID, employeeId)
                        serviceIntent?.putExtra(INTENT_EXTRA_TASK_NO, taskNo)
                        serviceIntent?.putExtra(INTENT_EXTRA_SITE_ID, siteId)
                        serviceIntent?.putExtra(INTENT_EXTRA_SITE_NAME, siteName)
                        serviceIntent?.putExtra(INTENT_EXTRA_SITE_ADDRESS, siteAddress)
                        serviceIntent?.putExtra(INTENT_EXTRA_SITE_LATITUDE, latitude)
                        serviceIntent?.putExtra(INTENT_EXTRA_SITE_LONGITUDE, longitude)
                        startService(serviceIntent!!)
                    } else {
                        Toast.makeText(this, "Required Android Oreo", Toast.LENGTH_SHORT).show()
                    }
                }
                "stopService" -> {
                    val durationInMinutes = 0L
                    Log.d("TAG","stop Service $durationInMinutes")
                    // Start the service using Intent
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        serviceIntent?.action = CountDownTimerService.ACTION_STOP_FOREGROUND_SERVICE
                        serviceIntent?.putExtra(INTENT_EXTRA_DURATION, 0L)
                        serviceIntent?.putExtra(INTENT_EXTRA_INTERVAL, 0L)
                        startService(serviceIntent!!)
                    } else {
                        Toast.makeText(this, "Required Android Oreo", Toast.LENGTH_SHORT).show()
                    }
                }
                "getMessageFromFlutter" -> {
                    val message = call.arguments as String
                    Toast.makeText(this@MainActivity, message, Toast.LENGTH_LONG).show()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL_ID, "Safety Buzzer", NotificationManager.IMPORTANCE_DEFAULT)
            notificationManager.createNotificationChannel(channel)
            shouldShowRequestPermissionRationale(Manifest.permission.POST_NOTIFICATIONS)
            requestNotificationPermission()
        }
    }

    private fun requestNotificationPermission() {
        if (!notificationManager.isNotificationPolicyAccessGranted) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.POST_NOTIFICATIONS), 0)
            }
        }
    }

}
