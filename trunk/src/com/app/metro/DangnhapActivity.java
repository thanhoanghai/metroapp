package com.app.metro;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

import com.app.customui.DialogFilterGenre;
import com.app.model.GenreObject;
import com.app.utils.Utils;

public class DangnhapActivity extends Activity {

	private TextView listTrungTam;
	private TextView listNganh;
	
	private DialogFilterGenre dialogTrungTam;
	private Button bntDangnhap;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dangnhap);

		listTrungTam = (TextView) findViewById(R.id.dangnhap_tx_list_trungtam);
		listNganh = (TextView) findViewById(R.id.dangnhap_tx_list_nganh);
		bntDangnhap = (Button) findViewById(R.id.dangnhap_bnt_dangnhap);
		bntDangnhap.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Utils.gotoSanpham(DangnhapActivity.this);
			}
		});
		
		initDialog();
		
		listTrungTam.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				if(dialogTrungTam!=null)
					dialogTrungTam.show();
			}
		});
		listNganh.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
			}
		});

	}
	
	private void initDialog()
	{
		GenreObject[] item = new GenreObject[1];
		dialogTrungTam = new DialogFilterGenre(DangnhapActivity.this, item);
	}

}
