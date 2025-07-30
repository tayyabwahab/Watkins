package com.example.stepcounterapp.presentation.ui

import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.CountDownTimer
import android.util.Log
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.stepcounterapp.R
import com.example.stepcounterapp.data.repository.StepCounterRepo
import com.example.stepcounterapp.data.utils.*
import com.example.stepcounterapp.databinding.ActivityMainBinding
import com.example.stepcounterapp.presentation.viewmodel.StepCounterViewModel
import java.math.MathContext
import java.math.RoundingMode

class MainActivity : AppCompatActivity() {

    private var activityRecognitionGranted = false
    private var maxMeters: Int = 0
    private var stepsTaken = "0"
    private var metersTraveled = "0"
    private var timeTaken = "0"
    private var isVersion1 = false
    private var isMale = false
    private lateinit var userName: String
    private lateinit var myPreferenceManager: MyPreferenceManager
    private val stepCounterViewModel: StepCounterViewModel by viewModels {
    StepCounterViewModel.StepCounterVMFactory(
        StepCounterRepo(this, maxMeters, MyPreferenceManager(this).getBoolean(KEY_VERSION_1)),
        application,
        MyPreferenceManager(this).getBoolean(KEY_VERSION_1)
    )}
    private val binding: ActivityMainBinding by lazy {
        ActivityMainBinding.inflate(layoutInflater)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        myPreferenceManager = MyPreferenceManager(this)
        userName = myPreferenceManager.getString(KEY_USER_NAME)!!
        isVersion1 = myPreferenceManager.getBoolean(KEY_VERSION_1)
        isMale = myPreferenceManager.getBoolean(KEY_IS_MALE)
        maxMeters = intent.getIntExtra(DIRECTION_GOAL_METERS, 0)
        setupUI()
    }

    private fun setupUI() {
        binding.tvUserName.text = userName

        stepCounterViewModel.currentTotalSteps.observe(this) {
            binding.tvBottomStepsTaken.text = it.toString()
            binding.tvBottomMetersTravelled.text = (it * FOOT_TO_METER).toBigDecimal(
                MathContext(
                    3,
                    RoundingMode.HALF_EVEN
                )
            ).toPlainString()

            stepsTaken = binding.tvBottomStepsTaken.text.toString()
            metersTraveled = binding.tvBottomMetersTravelled.text.toString()
        }


        stepCounterViewModel.animationType.observe(this) {

            if(!isVersion1)
            {
                binding.walkAnimationGif.setImageResource(
                    when (it) {
                        AnimationType.SIT_DOWN -> {
                            R.drawable.sit_down
                        }
                        AnimationType.WALKING -> {
                            R.drawable.walk
                        }
                        AnimationType.WALK_BACK_WARD -> {
                            R.drawable.walk_backward
                        }
                        else -> {
                            R.drawable.stand_up_and_walk
                        }
                    }
                )
            }else if(isMale){
                binding.walkAnimationGif.setImageResource(R.drawable.walk)
            }else{
                binding.walkAnimationGif.setImageResource(R.drawable.women_walking)
            }


            if (it == AnimationType.SIT_DOWN) {
                binding.walkAnimationGif.postOnAnimation {
                    val intent = Intent(this@MainActivity, ResultActivity::class.java)
                    intent.putExtra(KEY_STEPS_TAKEN, stepsTaken)
                    intent.putExtra(KEY_TIME_TAKEN, timeTaken)
                    intent.putExtra(KEY_METERS_TRAVELED, metersTraveled)
                    intent.putExtra(KEY_USER_NAME, userName)
                    startActivity(intent)
                    finish()
                }
            }
        }
        stepCounterViewModel.timer.observe(this) {
            binding.tvBottomTimer.text = it
            timeTaken = it

        }
    }

    override fun onResume() {
        super.onResume()
        activityRecognitionPermission()
    }

    private fun activityRecognitionPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            if (ContextCompat.checkSelfPermission(
                    this,
                    android.Manifest.permission.ACTIVITY_RECOGNITION
                ) == PackageManager.PERMISSION_DENIED
            ) {

                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(android.Manifest.permission.ACTIVITY_RECOGNITION),
                    1
                )
            } else {
                activityRecognitionGranted = true
            }
        } else {

            if (ContextCompat.checkSelfPermission(
                    this,
                    "com.google.android.gms.permission.ACTIVITY_RECOGNITION"
                ) == PackageManager.PERMISSION_DENIED
            ) {

                ActivityCompat.requestPermissions(
                    this,
                    arrayOf("com.google.android.gms.permission.ACTIVITY_RECOGNITION"),
                    1
                )
            } else {
                activityRecognitionGranted = true
            }
        }
    }

}
