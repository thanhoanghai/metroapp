package com.app.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.app.adapter.SanphamFragmentAdapter;
import com.app.constantmetro.GlobalSingleton;
import com.app.customui.LoadMoreListView;
import com.app.metro.R;
import com.app.model.SanphamListObject;
import com.app.utils.URLProvider;
import com.google.gson.Gson;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;

public class SanphamFragment extends Fragment {

	private LoadMoreListView listview;
	private SanphamFragmentAdapter adapter;
	private int page = 1;
	private int per_page = 10;
	private String branch = "1";

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

		listview = (LoadMoreListView) view
				.findViewById(R.id.sanpham_fragment_listview);
		adapter = new SanphamFragmentAdapter(getActivity());
		listview.setAdapter(adapter);

		loadProduct();

		return view;
	}

	private void loadProduct() {
		String link = URLProvider.getListProduct(page, per_page, branch);
		AsyncHttpClient client = new AsyncHttpClient();
		client.addHeader("X-Authorization-Token",
				GlobalSingleton.getSingleton().token);
		client.get(link, new AsyncHttpResponseHandler() {
			@Override
			public void onSuccess(String response) {
				try {
					Gson gson = new Gson();
					SanphamListObject object = gson.fromJson(response,
							SanphamListObject.class);
					for (int i = 0; i < object.data.product.length; i++) {
						adapter.addItem(object.data.product[i]);
					}
					adapter.notifyDataSetChanged();
				} catch (Exception ex) {
				}
			}
			@Override
			public void onFailure(Throwable error, String content) {
				super.onFailure(error, content);
			}
		});
	}
}
