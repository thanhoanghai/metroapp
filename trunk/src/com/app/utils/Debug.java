package com.app.utils;


import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.app.constantmetro.Constants;

public class Debug {
	private static final boolean DEBUGER = Constants.STATUS_DEBUG;

	public static void log(String tag, String content) {
		if (DEBUGER) {
			Log.d(tag, content + "");
		}
	}

	public static void log(String content) {
		if (DEBUGER) {
			Log.d("debug", content + "");
		}
	}

	public static void logError(String tag, String content) {
		if (DEBUGER) {
			Log.e(tag, content + "");
		}
	}

	public static void logError(String content) {
		if (DEBUGER) {
			Log.e("debugError", content + "");
		}
	}

	public static void toast(Context mContext, String s) {
		Toast.makeText(mContext, s, Toast.LENGTH_LONG).show();
	}

}