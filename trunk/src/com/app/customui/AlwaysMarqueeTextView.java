package com.app.customui;

import android.content.Context;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.widget.TextView;

public class AlwaysMarqueeTextView extends TextView {
	public AlwaysMarqueeTextView(Context paramContext) {
		super(paramContext);
	}

	public AlwaysMarqueeTextView(Context paramContext,
			AttributeSet paramAttributeSet) {
		super(paramContext, paramAttributeSet);
	}

	public AlwaysMarqueeTextView(Context paramContext,
			AttributeSet paramAttributeSet, int paramInt) {
		super(paramContext, paramAttributeSet, paramInt);
	}

	public boolean isFocused() {
		return true;
	}

	protected void onFocusChanged(boolean paramBoolean, int paramInt,
			Rect paramRect) {
	}
}