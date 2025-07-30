package com.example.stepcounterapp.presentation.ui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.stepcounterapp.data.utils.KEY_METERS_TRAVELED
import com.example.stepcounterapp.data.utils.KEY_STEPS_TAKEN
import com.example.stepcounterapp.data.utils.KEY_TIME_TAKEN
import com.example.stepcounterapp.data.utils.KEY_USER_NAME
import com.example.stepcounterapp.databinding.ActivityResultBinding

class ResultActivity : AppCompatActivity() {
    private val binding: ActivityResultBinding by lazy {
        ActivityResultBinding.inflate(layoutInflater)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)


        val stepsTaken = intent.getStringExtra(KEY_STEPS_TAKEN)
        val timeTaken = intent.getStringExtra(KEY_TIME_TAKEN)
        val metersTravelled = intent.getStringExtra(KEY_METERS_TRAVELED)
        val userName = intent.getStringExtra(KEY_USER_NAME)
        binding.tvUserName.text = userName
        binding.tvSteps.text = stepsTaken
        binding.tvTime.text = timeTaken
        binding.tvMeters.text = metersTravelled


        binding.ivBack.setOnClickListener {
            onBackPressed()
        }
    }
}