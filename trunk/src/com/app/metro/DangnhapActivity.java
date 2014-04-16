package com.app.metro;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.app.constantmetro.GlobalSingleton;
import com.app.customui.DialogFilterGenre;
import com.app.customui.DialogFilterGenre.FinishDialogListener;
import com.app.model.BranchListObject;
import com.app.model.SignInObject;
import com.app.utils.URLProvider;
import com.app.utils.Utils;
import com.google.gson.Gson;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;

public class DangnhapActivity extends Activity {
	
	//X-Authorization-Token: <token>

	private TextView txtBranch;
	private TextView listNganh;

	private DialogFilterGenre dialogBranch;
	private BranchListObject branchListObject;
	private Button bntDangnhap;

	private LinearLayout linearContent;
	private ImageView imgLoading;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dangnhap);

		imgLoading = (ImageView) findViewById(R.id.dangnhap_loading);
		linearContent = (LinearLayout) findViewById(R.id.dangnhap_linear_content);

		txtBranch = (TextView) findViewById(R.id.dangnhap_tx_list_trungtam);
		listNganh = (TextView) findViewById(R.id.dangnhap_tx_list_nganh);
		bntDangnhap = (Button) findViewById(R.id.dangnhap_bnt_dangnhap);
		bntDangnhap.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				signInMetro();
			}
		});

		txtBranch.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if (dialogBranch != null)
					dialogBranch.show();
			}
		});
		listNganh.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
			}
		});

		getListBranchMetro();
	}

	private void initDialog() {
		dialogBranch = new DialogFilterGenre(DangnhapActivity.this,
				branchListObject.data);
		dialogBranch.setListenerFinishedDialog(new FinishDialogListener() {
			@Override
			public void onFinishEditDialog(String idGenre, String title) {
				// TODO Auto-generated method stub
				txtBranch.setText(title);
			}
		});
	}

	private void getListBranchMetro() {
		String link = URLProvider.getBranchMetro();
		AsyncHttpClient client = new AsyncHttpClient();
		client.get(link, new AsyncHttpResponseHandler() {
			@Override
			public void onSuccess(String response) {
				try {
					Gson gson = new Gson();
					branchListObject = gson.fromJson(response,
							BranchListObject.class);
					txtBranch.setText(branchListObject.data[0].name);
					initDialog();
					setVisibleContent();
				} catch (Exception ex) {
				}
			}

			@Override
			public void onFailure(Throwable error, String content) {
				super.onFailure(error, content);
			}
		});
	}

	private void signInMetro() {
		setInvisibleContent();
		String link = URLProvider.getLinkSignIn();
		AsyncHttpClient client = new AsyncHttpClient();
		client.post(link, URLProvider.getParamsSignIn("Nganh Hang 1"),
				new AsyncHttpResponseHandler() {
					@Override
					public void onSuccess(String response) {
						try {
							Gson gson = new Gson();
							SignInObject object = gson.fromJson(response,
									SignInObject.class);
							if (object.code == 200)
							{	
								GlobalSingleton.getSingleton().token = object.data.token;
								Utils.gotoSanpham(DangnhapActivity.this);
							}
							else
								setVisibleContent();
						} catch (Exception ex) {
							setVisibleContent();
						}
					}
					@Override
					public void onFailure(Throwable error, String content) {
						super.onFailure(error, content);
						setVisibleContent();
					}
				});
	}

	private void setVisibleContent() {
		linearContent.setVisibility(View.VISIBLE);
		imgLoading.setVisibility(View.INVISIBLE);
	}

	private void setInvisibleContent() {
		linearContent.setVisibility(View.INVISIBLE);
		imgLoading.setVisibility(View.VISIBLE);
	}
}
