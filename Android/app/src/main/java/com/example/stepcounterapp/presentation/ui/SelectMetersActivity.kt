package com.example.stepcounterapp.presentation.ui

import android.content.Intent
import android.media.MediaPlayer
import android.os.Bundle
import android.os.CountDownTimer
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.stepcounterapp.R
import com.example.stepcounterapp.data.utils.DIRECTION_GOAL_METERS
import com.example.stepcounterapp.data.utils.KEY_VERSION_1
import com.example.stepcounterapp.data.utils.MyPreferenceManager
import com.example.stepcounterapp.databinding.ActivitySelectMetersBinding

class SelectMetersActivity : AppCompatActivity() {

    private val binding: ActivitySelectMetersBinding by lazy {
        ActivitySelectMetersBinding.inflate(layoutInflater)
    }
    private var mediaPlayer: MediaPlayer? = null
    private var counter = 3
    private var goalMeters = 6
    private var isVersion1 = false
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        initData()
    }

    private fun initData() {
        isVersion1 = MyPreferenceManager(this).getBoolean(KEY_VERSION_1)
        binding.ivBack.setOnClickListener {
            onBackPressed()
        }
        binding.imgArrowUp.setOnClickListener {
            goalMeters++
            binding.tvGoalMeters.text = "$goalMeters M"
        }

        binding.imgArrowDown.setOnClickListener {
            if(isVersion1){
                if (goalMeters > 3) {
                    goalMeters--
                } else {
                    Toast.makeText(this, "You can't go below 3 Meters.", Toast.LENGTH_SHORT).show()
                }
                binding.tvGoalMeters.text = "$goalMeters M"
            }else{
                if (goalMeters > 6) {
                    goalMeters--
                } else {
                    Toast.makeText(this, "You can't go below 6 Meters.", Toast.LENGTH_SHORT).show()
                }
                binding.tvGoalMeters.text = "$goalMeters M"
            }

        }

        binding.btn10Meters.setOnClickListener {
            goalMeters += 10
            binding.tvGoalMeters.text = "$goalMeters M"
        }

        binding.btn20Meters.setOnClickListener {
            goalMeters += 20
            binding.tvGoalMeters.text = "$goalMeters M"
        }


        binding.viewCircle.setOnClickListener {
            it.isClickable = false
            countDown(it)
        }
    }

    override fun onResume() {
        super.onResume()
        if (isVersion1) {
            goalMeters = 3
        } else {
            goalMeters = 6
        }
        binding.tvCountDown.textSize = 38f
        binding.tvCountDown.text = "START"
        binding.tvGoalMeters.text = "$goalMeters M"
        counter = 3


    }


    private fun countDown(btn: View) {
        object : CountDownTimer(1000, 1000) {
            override fun onTick(p0: Long) {

            }

            override fun onFinish() {

                mediaPlayer = when (counter) {
                    3 -> {
                        MediaPlayer.create(this@SelectMetersActivity, R.raw.three)
                    }
                    2 -> {
                        MediaPlayer.create(this@SelectMetersActivity, R.raw.two)
                    }
                    1 -> {
                        MediaPlayer.create(this@SelectMetersActivity, R.raw.one)
                    }
                    else -> {
                        null
                    }
                }
                mediaPlayer?.start()

                if (counter >= 1) {
                    binding.tvCountDown.text = counter.toString()
                    binding.tvCountDown.textSize = 80F
                    countDown(btn)
                } else {
                    val intent = Intent(this@SelectMetersActivity, MainActivity::class.java)
                    intent.putExtra(DIRECTION_GOAL_METERS, goalMeters)
                    startActivity(intent)
                    btn.isClickable = true

                }

                counter--
            }
        }.start()

    }


}