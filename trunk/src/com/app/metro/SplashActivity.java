package com.app.metro;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

import com.app.utils.Utils;

public class SplashActivity extends Activity {

	private Handler moveActivity = new Handler();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splash);

		moveActivity.postDelayed(moveScene, 2000);
	}

	private Runnable moveScene = new Runnable() {

		@Override
		public void run() {

			Utils.gotoDangnhap(SplashActivity.this);
			finish();

		}
	};

}
