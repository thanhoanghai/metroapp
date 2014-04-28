package com.app.model;

import com.google.gson.annotations.SerializedName;

public class NganhObject {

	@SerializedName("id")
	public String id;
	@SerializedName("name")
	public String name;
	@SerializedName("description")
	public String description;
	@SerializedName("created_at")
	public String created_at;
	@SerializedName("updated_at")
	public String updated_at;
	@SerializedName("code")
	public String code;

}
