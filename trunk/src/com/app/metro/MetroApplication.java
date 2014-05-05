package com.app.metro;

import android.app.Application;

import com.nostra13.universalimageloader.cache.disc.naming.Md5FileNameGenerator;
import com.nostra13.universalimageloader.cache.memory.impl.WeakMemoryCache;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.QueueProcessingType;

public final class MetroApplication extends Application {

	private static MetroApplication sInstance;
	private ImageLoader imageLoader;

	public MetroApplication() {
		sInstance = this;
	}

	@Override
	public void onCreate() {
		super.onCreate();

		// This configuration tuning is custom. You can tune every option, you
		// may tune some of them, or you can create default configuration by
		// ImageLoaderConfiguration.createDefault(this); method
		ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(
				this).threadPriority(Thread.NORM_PRIORITY - 2)
				.denyCacheImageMultipleSizesInMemory()
				.memoryCache(new WeakMemoryCache())
				.discCacheFileNameGenerator(new Md5FileNameGenerator())
				.tasksProcessingOrder(QueueProcessingType.LIFO).build();

		// Initialize ImageLoader with configuration.
		imageLoader = ImageLoader.getInstance();
		imageLoader.init(config);

	}

	@Override
	public void onLowMemory() {
		super.onLowMemory();
		if (imageLoader != null) {
			imageLoader.clearMemoryCache();
		}
	}

	/**
	 * get the singleton application instance
	 */
	public static MetroApplication getInstance() {
		return sInstance;
	}

	public ImageLoader getImageLoader() {
		return imageLoader;
	}
}