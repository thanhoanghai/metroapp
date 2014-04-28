package com.app.model;

import com.google.gson.annotations.SerializedName;

public class NganhListObject {

	@SerializedName("code")
	public int code;

	@SerializedName("message")
	public String message;

	@SerializedName("data")
	public NganhObject[] data;
}
