package com.example.eminencetel

import java.io.IOException
import retrofit2.Call
import retrofit2.Retrofit
import okhttp3.ResponseBody
import okhttp3.RequestBody
import retrofit2.http.POST
import retrofit2.http.Body
import retrofit2.http.Path
import org.json.JSONObject

interface BuzzerServiceInterface {
    @POST("safetyStatus")
    fun safetyStatus(@Body request:RequestBody): Call<ResponseBody?>
}