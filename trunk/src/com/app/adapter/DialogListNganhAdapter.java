package com.app.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.TextView;

import com.app.metro.R;
import com.app.model.NganhObject;

public class DialogListNganhAdapter extends BaseAdapter implements ListAdapter {

	private LayoutInflater mInflater;
	private NganhObject[] listObject;

	public DialogListNganhAdapter(Context context) {
		super();
		if (mInflater == null)
			mInflater = LayoutInflater.from(context);
		// mContext = context;
	}

	public void setList(NganhObject[] list) {
		listObject = list;
	}

	private class ViewHolder {
		public TextView title;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = convertView;
		final ViewHolder holder;

		if (convertView == null) {
			view = mInflater.inflate(R.layout.dialog_list_nganh_item, null);
			holder = new ViewHolder();

			holder.title = (TextView) view
					.findViewById(R.id.dialog_list_nganh_item_title);
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		NganhObject item = listObject[position];
		holder.title.setText(item.name);

		return view;
	}

	@Override
	public int getCount() {
		if (listObject != null)
			return listObject.length;
		return 0;
	}

	@Override
	public NganhObject getItem(int position) {
		if (listObject != null)
			return listObject[position];
		return null;
	}

	@Override
	public long getItemId(int position) {
		return 0;
	}
}