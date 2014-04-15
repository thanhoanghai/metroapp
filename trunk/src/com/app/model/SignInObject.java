package com.app.model;

import com.google.gson.annotations.SerializedName;

public class SignInObject {

	@SerializedName("code")
	public int code;
	
	@SerializedName("message")
	public String message;
	
	@SerializedName("data")
	public TokenObject data;
}
