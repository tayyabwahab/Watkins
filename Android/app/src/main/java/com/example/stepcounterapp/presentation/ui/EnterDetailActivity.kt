package com.example.stepcounterapp.presentation.ui

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.animation.Animation
import android.view.animation.TranslateAnimation
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.stepcounterapp.R
import com.example.stepcounterapp.data.utils.KEY_IS_MALE
import com.example.stepcounterapp.data.utils.KEY_USER_NAME
import com.example.stepcounterapp.data.utils.MyPreferenceManager
import com.example.stepcounterapp.databinding.ActivityEnterDetailBinding

class EnterDetailActivity : AppCompatActivity() {
    private val binding: ActivityEnterDetailBinding by lazy {
        ActivityEnterDetailBinding.inflate(layoutInflater)
    }

    private var selectedTab = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)

        val preferenceManager = MyPreferenceManager(this)
        preferenceManager.putBoolean(KEY_IS_MALE,true)
        binding.tvMale.setOnClickListener {
            selectTab(1)
            preferenceManager.putBoolean(KEY_IS_MALE,true)
        }

        binding.tvFemale.setOnClickListener {
            selectTab(2)
            preferenceManager.putBoolean(KEY_IS_MALE,false)
        }

        binding.btnDirectionCounter.setOnClickListener {
            if (binding.etEnterName.text.toString().isNotEmpty()) {
                preferenceManager.putString(
                    KEY_USER_NAME,
                    binding.etEnterName.text.toString()
                )
                startActivity(Intent(this, WelcomeUserActivity::class.java))
            } else {
                Toast.makeText(this, "Please enter name", Toast.LENGTH_SHORT).show()
            }
        }

    }

    private fun selectTab(tabNumber: Int) {
        var slideTo = 0F

        val selectedItem: TextView
        val nonSelectedItem: TextView

        if (tabNumber == 1) {
            selectedItem = binding.tvMale
            nonSelectedItem = binding.tvFemale
            slideTo = ((tabNumber - selectedTab) * selectedItem.width).toFloat()

        } else {
            selectedItem = binding.tvFemale
            nonSelectedItem = binding.tvMale
            slideTo = ((tabNumber - selectedTab) * selectedItem.width).toFloat()

        }

        val translateAnimation: TranslateAnimation = TranslateAnimation(0F, slideTo, 0F, 0F)
        translateAnimation.duration = 150

        nonSelectedItem.startAnimation(translateAnimation)

        translateAnimation.setAnimationListener(object : Animation.AnimationListener {
            override fun onAnimationStart(p0: Animation?) {

            }

            override fun onAnimationEnd(p0: Animation?) {
                selectedItem.setBackgroundResource(R.drawable.rectangle_dark_blue_bg)
                selectedItem.setTextColor(Color.WHITE)
                nonSelectedItem.setBackgroundColor(resources.getColor(android.R.color.transparent))
                nonSelectedItem.setTextColor(resources.getColor(R.color.dark_blue))

            }

            override fun onAnimationRepeat(p0: Animation?) {
            }

        })

        selectedTab = tabNumber

    }

}