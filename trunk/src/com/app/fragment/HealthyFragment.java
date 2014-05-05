package com.app.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;

import com.app.customui.SegmentedRadioGroupLine;
import com.app.metro.R;

public class HealthyFragment extends Fragment {

	private SegmentedRadioGroupLine segment;

	private WebView webView;
	private ImageView loading;
	private String[] listLink = { "http://metro.qptek.com/healthy/info" // thongtinduan
			, "http://metro.qptek.com/healthy/partners" // doi tac thuc hien
			, "http://metro.qptek.com/healthy/activity" // hoat dong
			, "http://metro.qptek.com/healthy/documents" // tai lieu
			, "http://metro.qptek.com/healthy/contact" // lien he
	};

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
		webView.loadUrl(listLink[0]);

		segment = (SegmentedRadioGroupLine) view.findViewById(R.id.healthy_segment);
		segment.check(R.id.healthy_seagment_segment_bnt_thongtinduan);
		segment.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				if (checkedId == R.id.healthy_seagment_segment_bnt_thongtinduan) {
					loading.setVisibility(View.VISIBLE);
					webView.loadUrl(listLink[0]);
				} else if (checkedId == R.id.healthy_seagment_segment_bnt_doitac) {
					loading.setVisibility(View.VISIBLE);
					webView.loadUrl(listLink[1]);
				} else if (checkedId == R.id.healthy_seagment_segment_bnt_hoatdong) {
					loading.setVisibility(View.VISIBLE);
					webView.loadUrl(listLink[2]);
				} else if (checkedId == R.id.healthy_seagment_segment_bnt_tailieu) {
					loading.setVisibility(View.VISIBLE);
					webView.loadUrl(listLink[3]);
				} else if (checkedId == R.id.healthy_seagment_segment_bnt_lienhe) {
					loading.setVisibility(View.VISIBLE);
					webView.loadUrl(listLink[4]);
				}
			}
		});

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
