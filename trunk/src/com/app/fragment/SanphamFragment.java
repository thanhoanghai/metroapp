package com.app.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.app.adapter.SanphamFragmentAdapter;
import com.app.constantmetro.Constants;
import com.app.constantmetro.GlobalSingleton;
import com.app.customui.DialogFilterGenre;
import com.app.customui.DialogFilterGenre.FinishDialogListener;
import com.app.customui.DialogListNganh;
import com.app.customui.DialogListNganh.FinishDialogNganhListener;
import com.app.customui.LoadMoreListView;
import com.app.customui.LoadMoreListView.OnLoadMoreListener;
import com.app.metro.R;
import com.app.model.BranchListObject;
import com.app.model.NganhListObject;
import com.app.model.SanphamListObject;
import com.app.utils.Debug;
import com.app.utils.Pref;
import com.app.utils.URLProvider;
import com.google.gson.Gson;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;

public class SanphamFragment extends Fragment {

	private LoadMoreListView listview;
	private SanphamFragmentAdapter adapter;
	private int page = 1;
	private int per_page = 10;
	private String idMetro = "1";
	private String idNganh = GlobalSingleton.getSingleton().idNganh;
	private ImageView imgLoading;
	private TextView textTitle;

	private TextView tvMetro;
	private TextView tvNganh;

	private DialogFilterGenre dialogBranch;
	private BranchListObject branchListObject;
	private DialogListNganh dialogNganh;
	private NganhListObject nganhListObject;
	private boolean statusLoadMore = true;

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

		imgLoading = (ImageView) view.findViewById(R.id.sanpham_loading);
		textTitle = (TextView) view
				.findViewById(R.id.sanpham_fragment_tv_title);
		textTitle.setText(getActivity().getResources().getString(
				R.string.ex_anphu));
		listview = (LoadMoreListView) view
				.findViewById(R.id.sanpham_fragment_listview);
		listview.setOnLoadMoreListener(new OnLoadMoreListener() {
			@Override
			public void onLoadMore() {
				// TODO Auto-generated method stub
				loadMoreData();
			}
		});

		tvMetro = (TextView) view
				.findViewById(R.id.sanpham_fragment_top_tv_metro);
		tvMetro.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (dialogBranch != null)
					dialogBranch.show();
			}
		});
		tvNganh = (TextView) view
				.findViewById(R.id.sanpham_fragment_top_tv_nganh);
		tvNganh.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (dialogNganh != null)
					dialogNganh.show();
			}
		});
		if (adapter == null) {
			adapter = new SanphamFragmentAdapter(getActivity());
			loadProduct();
		} else {
			imgLoading.setVisibility(View.INVISIBLE);
		}
		listview.setAdapter(adapter);

		initDialogMetro();
		initDialogNganh();

		return view;
	}
	
	
	private void loadMoreData()
	{
		if(statusLoadMore)
		{
			//page = page + 1;
			loadProduct();
		}
	}

	private void loadProduct() {
		imgLoading.setVisibility(View.VISIBLE);
		String link = URLProvider.getListProduct(page, per_page, idMetro,
				idNganh);
		Debug.logError(link);
		AsyncHttpClient client = new AsyncHttpClient();
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
					if (page == 1)
					{	imgLoading.setVisibility(View.INVISIBLE);
						textTitle.setText(object.data.branch_promotion);
					}
					if(page >= object.data.current_page)
					{
						statusLoadMore = false;
						listview.setVisibleFooterView(View.INVISIBLE);
					}
					listview.onLoadMoreComplete();
				} catch (Exception ex) {
				}
			}

			@Override
			public void onFailure(Throwable error, String content) {
				super.onFailure(error, content);
			}
		});
	}

	private void initDialogMetro() {
		try {
			tvMetro.setText(GlobalSingleton.getSingleton().nameMetro);
			String response = Pref.getStringObject(Constants.DATA_METRO,
					getActivity());
			Gson gson = new Gson();
			branchListObject = gson.fromJson(response, BranchListObject.class);
			dialogBranch = new DialogFilterGenre(getActivity(),
					branchListObject.data);
			dialogBranch.setListenerFinishedDialog(new FinishDialogListener() {
				@Override
				public void onFinishEditDialog(String idGenre, String title) {
					// TODO Auto-generated method stub
					tvMetro.setText(title);
					idMetro = idGenre;
					resetLoadcontent();
				}
			});
		} catch (Exception ex) {
		}
	}

	private void initDialogNganh() {
		try {
			tvNganh.setText(GlobalSingleton.getSingleton().nameNganh);
			String response = Pref.getStringObject(Constants.DATA_NGANH,
					getActivity());
			Gson gson = new Gson();
			nganhListObject = gson.fromJson(response, NganhListObject.class);

			dialogNganh = new DialogListNganh(getActivity(),
					nganhListObject.data);
			dialogNganh
					.setListenerFinishedDialog(new FinishDialogNganhListener() {
						@Override
						public void onFinishNganhDialog(String idGenre,
								String title) {
							tvNganh.setText(title);
							idNganh = idGenre;
							resetLoadcontent();
						}
					});
		} catch (Exception ex) {
		}
	}
	
	private void resetLoadcontent()
	{
		statusLoadMore = true;
		listview.setVisibleFooterView(View.VISIBLE);
		page = 1;
		adapter.clearData();
		loadProduct();
	}
}
