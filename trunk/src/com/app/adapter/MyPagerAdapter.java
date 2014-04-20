package com.app.adapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import com.app.fragment.HealthyFragment;
import com.app.fragment.SanphamFragment;

public class MyPagerAdapter extends FragmentPagerAdapter {

	private final String[] TITLES = { "hello", "haha" };

	public MyPagerAdapter(FragmentManager fm) {
		super(fm);
	}

	@Override
	public CharSequence getPageTitle(int position) {
		return TITLES[position];
	}

	@Override
	public int getCount() {
		return TITLES.length;
	}

	private SanphamFragment sanpham;
	private HealthyFragment healthy;

	@Override
	public Fragment getItem(int position) {
		switch (position) {
		case 0:
			sanpham = new SanphamFragment();
			return sanpham;
		case 1:
			healthy = new HealthyFragment();
			return healthy;
		default:
			break;
		}
		return null;
	}

}