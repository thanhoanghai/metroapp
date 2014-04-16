package com.app.adapter;

import java.util.ArrayList;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.TextView;

import com.app.metro.R;
import com.app.model.SanphamObject;

public class SanphamFragmentAdapter extends BaseAdapter implements ListAdapter {

	private LayoutInflater mInflater;
	private ArrayList<SanphamObject> listObject;

	public SanphamFragmentAdapter(Context context) {
		super();
		if (mInflater == null)
			mInflater = LayoutInflater.from(context);
	}

	public void addItem(SanphamObject item) {
		if (listObject == null)
			listObject = new ArrayList<SanphamObject>();
		listObject.add(item);
	}

	private class ViewHolder {
		public TextView title;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = convertView;
		final ViewHolder holder;

		if (convertView == null) {
			view = mInflater.inflate(R.layout.sanpham_fragment_item, null);
			holder = new ViewHolder();

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		return view;
	}

	@Override
	public int getCount() {
		if (listObject != null)
			return listObject.size();
		return 0;
	}

	@Override
	public SanphamObject getItem(int position) {
		return listObject.get(position);
	}

	@Override
	public long getItemId(int position) {
		return 0;
	}
}