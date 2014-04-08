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
import com.app.model.GenreObject;

public class DialgoFilterGenreAdapter extends BaseAdapter implements
		ListAdapter {

	private LayoutInflater mInflater;
	private ArrayList<GenreObject> listObject = new ArrayList<GenreObject>();

	private int indexCurrent = 0;
	private Context mContext;

	public DialgoFilterGenreAdapter(Context context) {
		super();
		if (mInflater == null)
			mInflater = LayoutInflater.from(context);
		mContext = context;
	}

	public void setIndexCurrent(int i) {
		indexCurrent = i;
		notifyDataSetChanged();
	}

	public void setList(GenreObject[] list) {
		for (int i = 0; i < list.length; i++) {
			listObject.add(list[i]);
		}
	}
	
	private class ViewHolder {
		public TextView title;
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
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

//		GenreObject item = listObject.get(position);
//		holder.title.setText(item.Name);
//		if (indexCurrent == position) {
//			holder.title.setSelected(true);
//		} else {
//			holder.title.setSelected(false);
//		}

		return view;
	}

	@Override
	public int getCount() {
		return 10;
	}

	@Override
	public GenreObject getItem(int position) {
		return listObject.get(position);
	}

	@Override
	public long getItemId(int position) {
		return 0;
	}
}