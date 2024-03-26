package com.sad.web.utils;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class DateUtil {

    public static LocalDateTime getCurrentTime(){
        return LocalDateTime.now();
    }

    public static void main(String[] args) {
        getCurrentTime();
    }

}