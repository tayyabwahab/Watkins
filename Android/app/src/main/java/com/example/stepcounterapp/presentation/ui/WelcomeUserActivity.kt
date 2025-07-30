package com.example.stepcounterapp.presentation.ui

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.stepcounterapp.R
import com.example.stepcounterapp.data.utils.KEY_USER_NAME
import com.example.stepcounterapp.data.utils.MyPreferenceManager
import com.example.stepcounterapp.databinding.ActivityWelcomeUserBinding

class WelcomeUserActivity : AppCompatActivity() {
    private val binding: ActivityWelcomeUserBinding by lazy {
        ActivityWelcomeUserBinding.inflate(layoutInflater)
    }
    private var preferenceManager: MyPreferenceManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)

        setupUI()
    }

    private fun setupUI() {
        preferenceManager = MyPreferenceManager(this)
        val userName = preferenceManager!!.getString(KEY_USER_NAME)
        binding.tvUserName.text = userName
        binding.btnNext.setOnClickListener {
            startActivity(Intent(this, SelectMetersActivity::class.java))
        }
        binding.ivBack.setOnClickListener {
            onBackPressed()
        }
    }
}