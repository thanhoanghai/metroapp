package com.app.metro;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.app.adapter.MyPagerAdapter;
import com.app.customui.SegmentedRadioGroup;

public class SanPhamActivity extends FragmentActivity {

	private SegmentedRadioGroup segment;
	private ViewPager pager;
	private MyPagerAdapter adapter;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sanpham_activity);

		pager = (ViewPager) findViewById(R.id.pager);
		adapter = new MyPagerAdapter(getSupportFragmentManager());
		pager.setAdapter(adapter);
		pager.setOnPageChangeListener(new OnPageChangeListener() {
			public void onPageScrollStateChanged(int state) {
			}

			public void onPageScrolled(int position, float positionOffset,
					int positionOffsetPixels) {
			}

			public void onPageSelected(int position) {
				if (position == 0) {
					segment.check(R.id.sanpham_activity_segment_bnt_metro);
				} else
					segment.check(R.id.sanpham_activity_segment_bnt_healthy);
			}
		});

		segment = (SegmentedRadioGroup) findViewById(R.id.sanpham_activity_segment);
		segment.check(R.id.sanpham_activity_segment_bnt_metro);
		segment.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				if (checkedId == R.id.sanpham_activity_segment_bnt_metro) {
					pager.setCurrentItem(0);
				} else if (checkedId == R.id.sanpham_activity_segment_bnt_healthy) {
					pager.setCurrentItem(1);
				}
			}
		});

	}

}
