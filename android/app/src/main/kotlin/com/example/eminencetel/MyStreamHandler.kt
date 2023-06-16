package com.example.eminencetel

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink

class MyStreamHandler : EventChannel.StreamHandler {

    private var eventSink: EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventSink?) {
        this.eventSink = eventSink
        // Start emitting data to the event sink
        // You can emit data asynchronously, for example using a separate thread
        // or by subscribing to some other source of data and forwarding it to the event sink
    }

    override fun onCancel(arguments: Any?) {
        this.eventSink = null
        // Stop emitting data to the event sink
        // You should clean up any resources you used for emitting data
    }

    fun sendData(data: String) {
        eventSink?.success(data)
    }
}