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

import com.app.adapter.DialgoFilterGenreAdapter;
import com.app.metro.R;
import com.app.model.GenreObject;

public class DialogFilterGenre extends Dialog implements
		android.view.View.OnClickListener {
	public interface FinishDialogListener {
		void onFinishEditDialog(String idGenre, String title);
	}

	private FinishDialogListener mListener;
	private Button bntCancel;

	private GridView gridview;
	private GenreObject[] listObject;
	private DialgoFilterGenreAdapter adapter;

	public DialogFilterGenre(Activity context, GenreObject[] list) {
		super(context, R.style.ThemeDialogCustom);
		listObject = list;
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.dialog_filter_genre);
		getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT,
				ViewGroup.LayoutParams.WRAP_CONTENT);

		gridview = (GridView) findViewById(R.id.dialog_filter_genre_gridview_filter);
		adapter = new DialgoFilterGenreAdapter(getContext());
		adapter.setList(listObject);
		gridview.setAdapter(adapter);

		gridview.setOnItemClickListener(new OnItemClickListener() {
			public void onItemClick(AdapterView<?> parent, View v,
					int position, long id) {
				mListener.onFinishEditDialog(adapter.getItem(position).id,
						adapter.getItem(position).name);
				exitDialog();
			}
		});

		bntCancel = (Button) findViewById(R.id.dialog_filter_genre_bnt_cancel);
		bntCancel.setOnClickListener(this);

	}

	public void exitDialog() {
		this.dismiss();
	}

	public void showDialog() {
		this.show();
	}

	public void setListenerFinishedDialog(FinishDialogListener t) {
		mListener = t;
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.dialog_filter_genre_bnt_cancel:
			this.dismiss();
			break;
		default:
			break;
		}
		this.dismiss();
	}
}
