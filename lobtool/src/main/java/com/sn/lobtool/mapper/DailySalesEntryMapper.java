package com.sn.lobtool.mapper;

import java.util.List;

import com.sn.lobtool.domain.DailySalesEntry;
import com.sn.lobtool.domain.PaymentMethods;
import com.sn.lobtool.domain.TimeChartEntries;

public interface DailySalesEntryMapper {
	
	List<DailySalesEntry> getDailySalesEntries(String searchStartDate, String searchEndDate);
	
	List<PaymentMethods> getPaymentMethods4Chart(String searchDate);
	
	List<TimeChartEntries> getSalesAmount4TimeChart(String searchDate);
	
	List<TimeChartEntries> getCustAmount4TimeChart(String searchDate);
	
	List<TimeChartEntries> getBillPerCust4TimeChart(String searchDate);

}
