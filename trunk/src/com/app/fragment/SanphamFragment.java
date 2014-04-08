package com.app.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.app.adapter.SanphamFragmentAdapter;
import com.app.customui.LoadMoreListView;
import com.app.metro.R;

public class SanphamFragment extends Fragment {
	
	private LoadMoreListView listview;
	private SanphamFragmentAdapter adapter;
	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// Inflate the layout for this fragment
		View view = inflater.inflate(R.layout.sanpham_fragment, container,
				false);

		listview = (LoadMoreListView) view.findViewById(R.id.sanpham_fragment_listview);
		adapter = new SanphamFragmentAdapter(getActivity());
		listview.setAdapter(adapter);
		
		return view;
	}
}
