package com.app.adapter;

import java.util.ArrayList;

import android.content.Context;
import android.graphics.Paint;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListAdapter;
import android.widget.TextView;

import com.app.metro.MetroApplication;
import com.app.metro.R;
import com.app.model.SanphamObject;
import com.nostra13.universalimageloader.core.ImageLoader;

public class SanphamFragmentAdapter extends BaseAdapter implements ListAdapter {

	private LayoutInflater mInflater;
	private ArrayList<SanphamObject> listObject;

	private ImageLoader mImageLoader;
	private Context mContext;

	public SanphamFragmentAdapter(Context context) {
		super();
		if (mInflater == null)
			mInflater = LayoutInflater.from(context);

		mContext = context;
		
		mImageLoader = MetroApplication.getInstance().getImageLoader();
	}

	public void addItem(SanphamObject item) {
		if (listObject == null)
			listObject = new ArrayList<SanphamObject>();
		listObject.add(item);
	}
	
	public void clearData()
	{
		listObject.clear();
		notifyDataSetChanged();
	}

	private class ViewHolder {
		public TextView name;
		public TextView description;
		public TextView giamphantram;
		public TextView price1;
		public TextView price2;
		public TextView priceVat;
		public ImageView img;
		public ImageView icon_giamgia;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = convertView;
		final ViewHolder holder;

		if (convertView == null) {
			view = mInflater.inflate(R.layout.sanpham_fragment_item, null);
			holder = new ViewHolder();
			holder.name = (TextView) view
					.findViewById(R.id.sanpham_fragment_item_name);
			holder.description = (TextView) view
					.findViewById(R.id.sanpham_fragment_item_description);
			holder.giamphantram = (TextView) view
					.findViewById(R.id.sanpham_fragment_item_giamphantram);
			holder.price1 = (TextView) view
					.findViewById(R.id.sanpham_fragment_item_price1);
			holder.price2 = (TextView) view
					.findViewById(R.id.sanpham_fragment_item_price2);
			holder.priceVat = (TextView) view
					.findViewById(R.id.sanpham_fragment_item_price_vat);
			
			holder.img = (ImageView) view
					.findViewById(R.id.sanpham_fragment_item_img);
			holder.icon_giamgia = (ImageView) view
					.findViewById(R.id.sanpham_fragment_item_icon_giamgia);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		SanphamObject item = listObject.get(position);
		holder.name.setText(item.name);
		holder.description.setText(item.description);
		if(item.price_1!=null && item.price_1.length() > 2)
		{
			holder.giamphantram.setText(mContext.getResources().getString(R.string.textgiamgia) + " " + item.sale_off);
			holder.price1.setText(item.price_1 );
			holder.price1.setPaintFlags(holder.price1.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
			holder.icon_giamgia.setVisibility(View.VISIBLE);
		}else
		{
			holder.giamphantram.setText("");
			holder.price1.setText("");
			holder.icon_giamgia.setVisibility(View.INVISIBLE);
		}
		
		holder.price2.setText(item.price_2 );
		holder.priceVat.setText("-GTGT " + item.price_vat);
		mImageLoader.displayImage(item.photo, holder.img);

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