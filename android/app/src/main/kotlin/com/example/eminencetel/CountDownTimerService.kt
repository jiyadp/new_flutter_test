package com.example.eminencetel

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import java.util.concurrent.TimeUnit
import android.media.MediaPlayer
import android.os.Binder
import android.os.Build
import android.os.CountDownTimer
import android.os.Handler
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import java.util.logging.StreamHandler
import android.os.Looper
import retrofit2.Retrofit
import okhttp3.ResponseBody
import okhttp3.RequestBody
import okhttp3.FormBody
import okhttp3.MediaType
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Call
import org.json.JSONObject






class CountDownTimerService : Service() {

    companion object {
        const val INTENT_EXTRA_DURATION = "DURATION"
        const val INTENT_EXTRA_INTERVAL = "INTERVAL"
        const val INTENT_EXTRA_EMAIL = "EMAIL"
        const val INTENT_EXTRA_USER_ID = "USER_ID"
        const val INTENT_EXTRA_EMPLOYEE_ID = "EMPOYEE_ID"
        const val INTENT_EXTRA_TASK_NO = "TASK_NO"
        const val INTENT_EXTRA_SITE_ID = "SITE_ID"
        const val INTENT_EXTRA_SITE_NAME = "SITE_NAME"
        const val INTENT_EXTRA_SITE_ADDRESS = "SITE_ADDRESS"
        const val INTENT_EXTRA_SITE_LATITUDE = "SITE_LATITUDE"
        const val INTENT_EXTRA_SITE_LONGITUDE = "SITE_LONGITUDE"

        const val ACTION_START_FOREGROUND_SERVICE = "ACTION_START_FOREGROUND_SERVICE"
        const val ACTION_STOP_FOREGROUND_SERVICE = "ACTION_STOP_FOREGROUND_SERVICE"
        const val ACTION_RESTART_FOREGROUND_SERVICE = "ACTION_RESTART_FOREGROUND_SERVICE"
        private const val CHANNEL_ID = "ForegroundCountdownServiceChannel"
        private const val NOTIFICATION_ID = 1
        private val CHANNEL = "callback_channel_from_service"
    }

    private var isTimerRunning = false
    private var isSafetyTimerRunning = false
    private var timer: CountDownTimer? = null
    private var safetyTimer: CountDownTimer? = null
    private var mediaPlayer:MediaPlayer?=null
    private lateinit var notificationBuilder:NotificationCompat.Builder
    private val notificationManager by lazy { getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager }
    private var isRunning = false
    private var handler: Handler? =null

    private var userId = ""
    private var email = ""
    private var employeeId = ""
    private var taskNo = ""
    private var siteId = ""
    private var siteName = ""
    private var siteAddress = ""
    private var latitude = ""
    private var longitude = ""

    // Staging
//    var baseUrl = "http://13.41.177.238:5000/api/";
    // Production
    var baseUrl = "https://epm.eminencetel.co.uk/api/";
    var retrofit: Retrofit = Retrofit.Builder().baseUrl(baseUrl).build()
    var service: BuzzerServiceInterface = retrofit.create(BuzzerServiceInterface::class.java)

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        handler = Handler(mainLooper)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (!isRunning) {
            // service was not previously running, do initial setup here
            isRunning = true;
        }

        notificationBuilder = createNotification("Starting countdown...")
        if (intent != null) {
            val durationInMinutes = intent.extras?.getLong(INTENT_EXTRA_DURATION) ?: 5L
            val intervalInMinutes = intent.extras?.getLong(INTENT_EXTRA_INTERVAL) ?: 5L
            userId = intent.extras?.getString(INTENT_EXTRA_USER_ID) ?: ""
            email = intent.extras?.getString(INTENT_EXTRA_EMAIL) ?: ""
            employeeId = intent.extras?.getString(INTENT_EXTRA_EMPLOYEE_ID) ?: ""
            taskNo = intent.extras?.getString(INTENT_EXTRA_TASK_NO) ?: ""
            siteId = intent.extras?.getString(INTENT_EXTRA_SITE_ID) ?: ""
            siteName = intent.extras?.getString(INTENT_EXTRA_SITE_NAME) ?: ""
            siteAddress = intent.extras?.getString(INTENT_EXTRA_SITE_ADDRESS) ?: ""
            latitude = intent.extras?.getString(INTENT_EXTRA_SITE_LATITUDE) ?: ""
            longitude = intent.extras?.getString(INTENT_EXTRA_SITE_LONGITUDE) ?: ""


            Log.d("TAG","intervalInMinutes = $intervalInMinutes")
            when (intent.action) {
                ACTION_STOP_FOREGROUND_SERVICE -> stopForegroundService()
                ACTION_RESTART_FOREGROUND_SERVICE -> {
                    handler?.removeCallbacksAndMessages(null)
                    if (isTimerRunning) {
                        timer?.cancel()
                    }
                    if (mediaPlayer?.isPlaying == true) {
                        mediaPlayer?.stop()
                    }
                    startTimer(durationInMinutes,intervalInMinutes)
                }
                else -> {
                    startForeground(NOTIFICATION_ID, notificationBuilder.build())
                    if (!isTimerRunning) {
                        startTimer(durationInMinutes,intervalInMinutes)
                    }
                }
            }
        }

        return START_STICKY
    }


    override fun onBind(p0: Intent?): IBinder? {
        return null
    }

    private fun startTimer(durationInMinutes: Long,intervalInMinutes: Long ) {
        isTimerRunning = true
        safetyTimer?.cancel()
        timer = object : CountDownTimer(TimeUnit.MINUTES.toMillis(durationInMinutes), 1000) {
            override fun onTick(millisUntilFinished: Long) {
                Log.d("ForegroundService", "Seconds remaining: ${millisUntilFinished / 1000}")
                notificationBuilder.setContentText("Seconds remaining: ${millisUntilFinished / 1000} seconds")
                notificationManager.notify(NOTIFICATION_ID, notificationBuilder.build())
                sendMessageToActivity("${millisUntilFinished/ 1000}")
            }

            override fun onFinish() {
                isTimerRunning = false
                playSound()
                notificationBuilder.setContentText("Are you safe ?")
                notificationManager.notify(NOTIFICATION_ID, notificationBuilder.build())
                intervalTimer(intervalInMinutes)
                handler?.postDelayed(object : Runnable {
                    override fun run() {
                        sendMessageToActivity("${0L}")
                        handler?.postDelayed(this, TimeUnit.SECONDS.toMillis(1))
                    }
                }, TimeUnit.SECONDS.toMillis(1))
            }
        }
        timer?.start()
    }

    private fun playSound(){
        mediaPlayer = MediaPlayer.create(this, R.raw.buzzer)
        mediaPlayer?.isLooping = true
        mediaPlayer?.start()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL_ID, "Safety Buzzer", NotificationManager.IMPORTANCE_DEFAULT)
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun createNotification(message: String): NotificationCompat.Builder {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle("Safety Buzzer")
            .setContentText(message)
            .setOnlyAlertOnce(true)
            .setAutoCancel(false)
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setContentIntent(pendingIntent)
    }

    private fun stopForegroundService() {
        timer?.cancel()
        safetyTimer?.cancel()
        isTimerRunning = false
        isSafetyTimerRunning = false
        mediaPlayer?.stop()
        // Stop foreground service and remove the notification.
        stopForeground(true)
        // Stop the foreground service.
        stopSelf()
        handler?.removeCallbacksAndMessages(null)
    }

    private fun sendMessageToActivity(msg: String) {
        val intent = Intent("CountDownUpdates")
        // You can also include some extra data.
        intent.putExtra("Status", msg)
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent)
    }

    private fun intervalTimer(intervalInMinutes:Long) {
        isSafetyTimerRunning = true
        safetyTimer = object : CountDownTimer(TimeUnit.MINUTES.toMillis(intervalInMinutes), 1000) {
            override fun onTick(millisUntilFinished: Long) {
                Log.d("ForegroundService", "Seconds remaining: ${millisUntilFinished / 1000}")
                notificationBuilder.setContentText("Safety alert will be sending in ${millisUntilFinished / 1000} seconds")
                notificationManager.notify(NOTIFICATION_ID, notificationBuilder.build())
                sendMessageToActivity("${millisUntilFinished/ 1000}")
            }

            override fun onFinish() {
                isSafetyTimerRunning = false
                notificationBuilder.setContentText("Safety alert message has been send!!!")
                notificationManager.notify(NOTIFICATION_ID, notificationBuilder.build())
                //TODO: API call should be invoked here
                triggerSafetyAPICall()
            }
        }
        safetyTimer?.start()
    }

    private fun triggerSafetyAPICall() {
        val requestBody: RequestBody = FormBody.Builder()
            .add("user_id", userId)
            .add("email", email)
            .add("employee_id", employeeId)
            .add("task_no", taskNo)
            .add("site_id", siteId)
            .add("site_name", siteName)
            .add("site_address", siteAddress)
            .add("latitude", latitude)
            .add("longitude", longitude).build()
        service.safetyStatus(requestBody).enqueue(object : Callback<ResponseBody?> {
            override fun onResponse(call: Call<ResponseBody?>, response: Response<ResponseBody?>) {
                val jsonData: String = response?.body()?.string() ?: "{'status':'message'}"
                Log.d("TAG","response from the api ${jsonData}  $email, $employeeId")
            }

            override fun onFailure(call: Call<ResponseBody?>?, t: Throwable?) {
                Log.d("TAG","response from the api failed ${t?.message}")
            }
        })
    }
}
