package com.app.model;

import com.google.gson.annotations.SerializedName;

public class GenreObject {

	@SerializedName("Id")
	public String Id;
	@SerializedName("Name")
	public String Name;
	@SerializedName("Description")
	public String Description;

	public GenreObject(String id, String name, String des) {
		Id = id;
		Name = name;
		Description = des;
	}

}
