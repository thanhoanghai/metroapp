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
import com.app.customui.DialogListNganh;
import com.app.customui.DialogListNganh.FinishDialogNganhListener;
import com.app.model.BranchListObject;
import com.app.model.NganhListObject;
import com.app.model.SignInObject;
import com.app.utils.Debug;
import com.app.utils.URLProvider;
import com.app.utils.Utils;
import com.google.gson.Gson;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;

public class DangnhapActivity extends Activity {

	private TextView txtBranch;
	private TextView listNganh;

	private DialogFilterGenre dialogBranch;
	private BranchListObject branchListObject;
	private Button bntDangnhap;
	
	private DialogListNganh dialogNganh;
	private NganhListObject nganhListObject;

	private LinearLayout linearContent;
	private ImageView imgLoading;
	
	private String id_Nganh;
	private String id_Metro;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dangnhap);

		imgLoading = (ImageView) findViewById(R.id.dangnhap_loading);
		linearContent = (LinearLayout) findViewById(R.id.dangnhap_linear_content);
		linearContent.setVisibility(View.INVISIBLE);

		txtBranch = (TextView) findViewById(R.id.dangnhap_tx_list_trungtam);
		listNganh = (TextView) findViewById(R.id.dangnhap_tx_list_nganh);

		bntDangnhap = (Button) findViewById(R.id.dangnhap_bnt_dangnhap);
		bntDangnhap.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				//signInMetro();
				gotoNextScreen();
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
				if(dialogNganh!=null)
					dialogNganh.show();
			}
		});

		getListNganh();
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
				id_Metro = idGenre;
			}
		});
	}
	private void initDialogNganh()
	{
		dialogNganh = new DialogListNganh(DangnhapActivity.this, nganhListObject.data);
		dialogNganh.setListenerFinishedDialog(new FinishDialogNganhListener() {
			@Override
			public void onFinishNganhDialog(String idGenre, String title) {
				listNganh.setText(title);
				id_Nganh = idGenre;
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
					id_Metro = branchListObject.data[0].id;
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
	private void getListNganh() {
		String link = URLProvider.getNganhMetro();
		AsyncHttpClient client = new AsyncHttpClient();
		client.get(link, new AsyncHttpResponseHandler() {
			@Override
			public void onSuccess(String response) {
				try {
					Gson gson = new Gson();
					nganhListObject = gson.fromJson(response,
							NganhListObject.class);
					listNganh.setText(nganhListObject.data[0].name);
					id_Nganh = nganhListObject.data[0].id;
					initDialogNganh();
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
		client.post(link,
				URLProvider.getParamsSignIn(listNganh.getText().toString()),
				new AsyncHttpResponseHandler() {
					@Override
					public void onSuccess(String response) {
						try {
							Gson gson = new Gson();
							SignInObject object = gson.fromJson(response,
									SignInObject.class);
							if (object.code == 200) {
								GlobalSingleton.getSingleton().token = object.data.token;
								gotoNextScreen();
							} else {
								setVisibleContent();
								Debug.toast(DangnhapActivity.this,
										object.message);
							}
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

	private void gotoNextScreen() {
		GlobalSingleton.getSingleton().idMetro = id_Metro;
		GlobalSingleton.getSingleton().idNganh = id_Nganh;
		Utils.gotoSanpham(DangnhapActivity.this);
		finish();
	}
}
