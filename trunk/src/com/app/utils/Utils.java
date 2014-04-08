package com.app.utils;

import android.content.Context;
import android.content.Intent;

import com.app.metro.DangnhapActivity;
import com.app.metro.SanPhamActivity;

public class Utils {

	public static void gotoDangnhap(Context mContext) {
		Intent intent = new Intent(mContext, DangnhapActivity.class);
		mContext.startActivity(intent);
	}
	public static void gotoSanpham(Context mContext) {
		Intent intent = new Intent(mContext, SanPhamActivity.class);
		mContext.startActivity(intent);
	}

}
