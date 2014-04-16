package com.app.model;

import com.google.gson.annotations.SerializedName;

public class SanphamListObject {

	@SerializedName("code")
	public int code;
	
	@SerializedName("message")
	public String message;
	
	@SerializedName("data")
	public SanphamInfoObject data;
}
