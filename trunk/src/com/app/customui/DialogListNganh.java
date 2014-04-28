package com.app.customui;

import android.app.Activity;
import android.app.Dialog;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.GridView;

import com.app.adapter.DialogListNganhAdapter;
import com.app.metro.R;
import com.app.model.NganhObject;

public class DialogListNganh extends Dialog implements
		android.view.View.OnClickListener {
	public interface FinishDialogNganhListener {
		void onFinishNganhDialog(String idGenre, String title);
	}

	private FinishDialogNganhListener mListener;
	private Button bntCancel;

	private GridView gridview;
	private NganhObject[] listObject;
	private DialogListNganhAdapter adapter;

	public DialogListNganh(Activity context, NganhObject[] list) {
		super(context, R.style.ThemeDialogCustom);
		listObject = list;
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.dialog_list_nganh);
		getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT,
				ViewGroup.LayoutParams.WRAP_CONTENT);

		gridview = (GridView) findViewById(R.id.dialog_list_nganh_gridview_filter);
		adapter = new DialogListNganhAdapter(getContext());
		adapter.setList(listObject);
		gridview.setAdapter(adapter);

		gridview.setOnItemClickListener(new OnItemClickListener() {
			public void onItemClick(AdapterView<?> parent, View v,
					int position, long id) {
				mListener.onFinishNganhDialog(adapter.getItem(position).id,
						adapter.getItem(position).name);
				exitDialog();
			}
		});

		bntCancel = (Button) findViewById(R.id.dialog_list_nganh_bnt_cancel);
		bntCancel.setOnClickListener(this);

	}

	public void exitDialog() {
		this.dismiss();
	}

	public void showDialog() {
		this.show();
	}

	public void setListenerFinishedDialog(FinishDialogNganhListener t) {
		mListener = t;
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.dialog_list_nganh_bnt_cancel:
			this.dismiss();
			break;
		default:
			break;
		}
		this.dismiss();
	}
}
