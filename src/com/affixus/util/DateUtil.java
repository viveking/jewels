package com.affixus.util;

import java.util.Calendar;
import java.util.Date;

public class DateUtil {

	public static Date getAdvanceDateFromToday(int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, day);
		return calendar.getTime();

	}
}
