package org.gdf;

import org.gdf.util.PasswordUtil;

public class PasswordUtilTest {
	
	public static void main(String... strings) {
		String password=PasswordUtil.generateSecurePassword("IL@ve2nu69", "satinder_2000@outlook.com");
		System.out.println("password: "+password);
	}

}
