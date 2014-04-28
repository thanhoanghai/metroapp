package com.app.utils;

import com.loopj.android.http.RequestParams;

public class URLProvider {

	public static String PROVIDER_SERVER = "http://metro.qptek.com/api/v1/";

	public static String getListProduct(int page, int per_page, String branch,String customer) {
		String client = PROVIDER_SERVER + "products?";
		if (client != null) {
			try {
				client += "page=" + page;
				client += "&per_page=" + per_page;
				client += "&branch=" + branch;
				client += "&customer=" + customer;
				return client;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static String getBranchMetro() {
		String client = PROVIDER_SERVER + "branches";
		if (client != null) {
			try {
				return client;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static String getNganhMetro() {
		String client = PROVIDER_SERVER + "customers";
		if (client != null) {
			try {
				return client;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static String getLinkSignIn() {
		String client = PROVIDER_SERVER + "auth/sign_in";
		if (client != null) {
			try {
				return client;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static RequestParams getParamsSignIn(String maBranch) {
		RequestParams params = new RequestParams();
		params.put("customer_name", maBranch);
		return params;
	}

}
