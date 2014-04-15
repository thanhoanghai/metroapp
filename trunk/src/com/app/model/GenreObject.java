package com.app.model;

import com.google.gson.annotations.SerializedName;

public class GenreObject {

	@SerializedName("id")
	public String id;
	@SerializedName("name")
	public String name;
	@SerializedName("address")
	public String address;

	public GenreObject(String ID, String Name, String des) {
		id = ID;
		name = Name;
		address = des;
	}

}
