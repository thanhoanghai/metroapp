package com.app.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageView;

import com.app.metro.R;

public class HealthyFragment extends Fragment {

	private WebView webView;
	private ImageView loading;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// Inflate the layout for this fragment
		View view = inflater.inflate(R.layout.healthy_fragment, container,
				false);

		loading = (ImageView) view.findViewById(R.id.healthy_loading);

		webView = (WebView) view.findViewById(R.id.healthy_fragment_webview);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setWebViewClient(new MyWebViewClient());
		webView.loadUrl("http://www.google.com");

		return view;
	}

	private class MyWebViewClient extends WebViewClient {
		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			view.loadUrl(url);
			return true;
		}

		public void onPageFinished(WebView view, String url) {
			// do your stuff here
			loading.setVisibility(View.INVISIBLE);
		}
	}
}
