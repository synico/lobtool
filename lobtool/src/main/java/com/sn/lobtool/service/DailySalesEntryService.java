package com.sn.lobtool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sn.lobtool.domain.DailySalesEntry;
import com.sn.lobtool.domain.PaymentMethods;
import com.sn.lobtool.domain.TimeChartEntries;
import com.sn.lobtool.mapper.DailySalesEntryMapper;
import com.sn.lobtool.util.LOBToolUtils;

@Service
public class DailySalesEntryService {
	
	@Autowired
	private DailySalesEntryMapper dailySalesEntryMapper;
	
	public List<DailySalesEntry> getDailySalesEntries(String searchStartDate, String searchEndDate) {
		return dailySalesEntryMapper.getDailySalesEntries(searchStartDate, searchEndDate);
	}
	
	public List<PaymentMethods> getPaymentMethods4Chart(String searchDate) {
	    return LOBToolUtils.calcProportion4Payment(dailySalesEntryMapper.getPaymentMethods4Chart(searchDate));
	}
    
    public List<TimeChartEntries> getSalesAmount4TimeChart(String searchDate) {
        return LOBToolUtils.calcProportion4TimeChart(dailySalesEntryMapper.getSalesAmount4TimeChart(searchDate));
    }
    
    public List<TimeChartEntries> getCustAmount4TimeChart(String searchDate) {
        return LOBToolUtils.calcProportion4TimeChart(dailySalesEntryMapper.getCustAmount4TimeChart(searchDate));
    }
    
    public List<TimeChartEntries> getBillPerCust4TimeChart(String searchDate) {
        return LOBToolUtils.calcProportion4TimeChart(dailySalesEntryMapper.getBillPerCust4TimeChart(searchDate));
    }

}
