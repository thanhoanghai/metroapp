package com.app.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.TextView;

import com.app.metro.R;
import com.app.model.GenreObject;

public class DialgoFilterGenreAdapter extends BaseAdapter implements
		ListAdapter {

	private LayoutInflater mInflater;
	private GenreObject[] listObject;

	public DialgoFilterGenreAdapter(Context context) {
		super();
		if (mInflater == null)
			mInflater = LayoutInflater.from(context);
		// mContext = context;
	}

	public void setList(GenreObject[] list) {
		listObject = list;
	}

	private class ViewHolder {
		public TextView title;
		public TextView address;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = convertView;
		final ViewHolder holder;

		if (convertView == null) {
			view = mInflater.inflate(R.layout.dialog_filter_genre_item, null);
			holder = new ViewHolder();

			holder.title = (TextView) view
					.findViewById(R.id.dialog_filter_genre_item_title);
			holder.address = (TextView) view
					.findViewById(R.id.dialog_filter_genre_item_des);
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		GenreObject item = listObject[position];
		holder.title.setText(item.name);
		holder.address.setText(item.address);

		return view;
	}

	@Override
	public int getCount() {
		if (listObject != null)
			return listObject.length;
		return 0;
	}

	@Override
	public GenreObject getItem(int position) {
		if (listObject != null)
			return listObject[position];
		return null;
	}

	@Override
	public long getItemId(int position) {
		return 0;
	}
}