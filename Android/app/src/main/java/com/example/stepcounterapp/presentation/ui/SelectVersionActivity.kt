package com.example.stepcounterapp.presentation.ui

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.stepcounterapp.R
import com.example.stepcounterapp.data.utils.KEY_VERSION_1
import com.example.stepcounterapp.data.utils.MyPreferenceManager
import com.example.stepcounterapp.databinding.ActivitySelectVersionBinding
import com.example.stepcounterapp.databinding.ActivityWelcomeUserBinding

class SelectVersionActivity : AppCompatActivity() {
    private val binding: ActivitySelectVersionBinding by lazy {
        ActivitySelectVersionBinding.inflate(layoutInflater)
    }
    private var preferenceManager: MyPreferenceManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)

        preferenceManager = MyPreferenceManager(this)


        binding.btnVersion1.setOnClickListener {
            val intent = Intent(this, EnterDetailActivity::class.java)
            startActivity(intent)
            preferenceManager?.putBoolean(KEY_VERSION_1, true)
        }

        binding.btnVersion2.setOnClickListener {
            val intent = Intent(this, EnterDetailActivity::class.java)
            preferenceManager?.putBoolean(KEY_VERSION_1, false)
            startActivity(intent)
        }
    }
}