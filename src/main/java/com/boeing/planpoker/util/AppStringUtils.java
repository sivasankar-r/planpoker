package com.boeing.planpoker.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;

public class AppStringUtils {
	public static List<String> parseLineDelimitedString(String input) {
		List<String> output = null;
		if(input != null && !input.isEmpty()){
			String[] split = input.split("\\r?\\n");
			output = removeEmptyElements(split);
		}
		return output;
	}
	
	public static List<String> removeEmptyElements(String[] input) {
		List<String> output = null;
		if(input!=null && input.length > 0) {
			output = new ArrayList<>();
			for(String str : input){
				if(StringUtils.isNotEmpty(str)){
					output.add(str);	
				}
			}
		}
		return output;
	}
	
	public static String generateRandomString(){
		return RandomStringUtils.randomAlphanumeric(40);
	}

	public static void main(String[] args) {
		System.out.println(generateRandomString());
	}
}
