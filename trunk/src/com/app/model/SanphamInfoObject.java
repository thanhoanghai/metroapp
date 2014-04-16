package com.app.model;

import com.google.gson.annotations.SerializedName;

public class SanphamInfoObject {

	@SerializedName("total_pages")
	public String total_pages;

	@SerializedName("current_page")
	public String current_page;

	@SerializedName("items_per_page")
	public String items_per_page;

	@SerializedName("product")
	public SanphamObject[] product;

}
