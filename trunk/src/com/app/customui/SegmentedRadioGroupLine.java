/*
 * Copyright (C) 2011 Make Ramen, LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.app.customui;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.RadioGroup;

import com.app.metro.R;

public class SegmentedRadioGroupLine extends RadioGroup {

	public SegmentedRadioGroupLine(Context context) {
		super(context);
	}

	public SegmentedRadioGroupLine(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	@Override
	protected void onFinishInflate() {
		super.onFinishInflate();
		changeButtonsImages();
	}

	private void changeButtonsImages() {
		int count = super.getChildCount();

		if (count > 1) {
			for (int i = 0; i < count; i++) {
				super.getChildAt(i)
						.setBackgroundResource(R.drawable.bg_segment_line_selector);
			}
		}
	}
}