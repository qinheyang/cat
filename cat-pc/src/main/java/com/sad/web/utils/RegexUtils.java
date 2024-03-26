package com.sad.web.utils;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexUtils {
    public static boolean phone(String content) {
        String pattern = "^[1][3-9]\\d{9}$";
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(content);
        return m.matches();

    }

    public static boolean email(String content) {
        String pattern = "[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}";

        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(content);
        return m.matches();

    }


    public static void main(String[] args) {
        System.out.println(email("test@example.com"));

    }


}
