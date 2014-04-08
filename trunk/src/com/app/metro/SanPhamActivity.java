package com.app.metro;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTransaction;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.app.customui.SegmentedRadioGroup;
import com.app.fragment.HealthyFragment;
import com.app.fragment.SanphamFragment;

public class SanPhamActivity extends FragmentActivity {

	private SegmentedRadioGroup segment;
	private SanphamFragment sanphamFragment;
	private HealthyFragment healthyFragment;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sanpham_activity);
		
		segment = (SegmentedRadioGroup) findViewById(R.id.sanpham_activity_segment);

		segment.check(R.id.sanpham_activity_segment_bnt_metro);
		segment.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				if (checkedId == R.id.sanpham_activity_segment_bnt_metro) {
					changeFragment(0);
				} else if (checkedId == R.id.sanpham_activity_segment_bnt_healthy) {
					changeFragment(1);
				}
			}
		});

		changeFragment(0);
	}

	private void changeFragment(int i) {
		FragmentTransaction fragmentTransaction = getSupportFragmentManager()
				.beginTransaction();
		if (i == 0) {
			if(sanphamFragment == null)
				 sanphamFragment = new SanphamFragment();
			fragmentTransaction.replace(R.id.sanpham_activity_fragment_content,
					sanphamFragment);
			fragmentTransaction.commit();
		} else if (i == 1) {
			if(healthyFragment == null)
				healthyFragment = new HealthyFragment();
			fragmentTransaction.replace(R.id.sanpham_activity_fragment_content,
					healthyFragment);
			fragmentTransaction.commit();
		}
	}
}
