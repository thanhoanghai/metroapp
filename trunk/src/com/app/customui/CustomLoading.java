package com.app.customui;

import android.content.Context;
import android.graphics.drawable.AnimationDrawable;
import android.util.AttributeSet;
import android.widget.ImageView;

/**
 * 
 * @author chinhqt
 * 
 */
public class CustomLoading extends ImageView {

	public CustomLoading(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		init();
	}

	public CustomLoading(Context context, AttributeSet attrs) {
		super(context, attrs);
		init();
	}

	public CustomLoading(Context context) {
		super(context);
		init();
	}

	private void init() {
		AnimationDrawable frameAnimation = (AnimationDrawable) getDrawable();
		frameAnimation.setCallback(this);
		frameAnimation.setVisible(true, true);
		frameAnimation.start();
	}

}