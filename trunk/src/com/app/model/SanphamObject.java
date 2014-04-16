package com.app.model;

import com.google.gson.annotations.SerializedName;

public class SanphamObject {

	@SerializedName("id")
	public String id;

	@SerializedName("name")
	public String name;

	@SerializedName("description")
	public String description;

	@SerializedName("price_1")
	public String price_1;

	@SerializedName("price_2")
	public String price_2;

	@SerializedName("sale_off")
	public String sale_off;

	@SerializedName("photo")
	public String photo;

}
