package com.app.constantmetro;

public class GlobalSingleton {
	private static GlobalSingleton mInstance;
	
	public String token="";

	public static GlobalSingleton getSingleton() {

		if (mInstance == null) {
			mInstance = new GlobalSingleton();
		}
		return mInstance;
	}

}
