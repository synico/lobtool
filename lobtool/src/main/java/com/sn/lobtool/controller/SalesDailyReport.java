package com.sn.lobtool.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sn.lobtool.domain.DailySalesEntry;
import com.sn.lobtool.domain.MonthlySalesEntry;
import com.sn.lobtool.domain.PaymentMethods;
import com.sn.lobtool.domain.TimeChartEntries;
import com.sn.lobtool.service.DailySalesEntryService;
import com.sn.lobtool.service.MonthlySalesEntryService;

@Controller
@RequestMapping("/salesReport")
public class SalesDailyReport {
	
	@Autowired
	private DailySalesEntryService dailySalesEntryService;
	
	@Autowired
	private MonthlySalesEntryService monthlySalesEntryService;
	
	@RequestMapping(path="/daily/{searchEndDate}", method=RequestMethod.GET)
	public String getSalesDailyReport(@PathVariable @DateTimeFormat(pattern="yyyyMMdd") Date searchEndDate, Model model) {
	    Calendar searchEndCalendar = Calendar.getInstance();
	    searchEndCalendar.setTime(searchEndDate);
	    searchEndCalendar.add(Calendar.DAY_OF_MONTH, -7);
	    
	    SimpleDateFormat sdfTo = new SimpleDateFormat("yyyy-MM-dd");
	    String formattedSearchEndDate = sdfTo.format(searchEndDate);
	    
	    String formattedPreviousWeekDate = sdfTo.format(searchEndCalendar.getTime());
	    
	    //retrive daily sales entries
		List<DailySalesEntry> dailySalesEntries = dailySalesEntryService.getDailySalesEntries("", formattedSearchEndDate);
		List<DailySalesEntry> preWeekDailySalesEntries = dailySalesEntryService.getDailySalesEntries("", formattedPreviousWeekDate);
		
		DailySalesEntry todaySalesEntry = null;
		for(DailySalesEntry dailySalesEntry : dailySalesEntries) {
		    if(dailySalesEntry.getBillDate().equals(formattedSearchEndDate)) {
		        todaySalesEntry = dailySalesEntry;
		    }
		}
		
		List<PaymentMethods> paymentMethods = dailySalesEntryService.getPaymentMethods4Chart(formattedSearchEndDate);
		List<TimeChartEntries> salesAmount4TimeChart = dailySalesEntryService.getSalesAmount4TimeChart(formattedSearchEndDate);
		List<TimeChartEntries> custAmount4TimeChart = dailySalesEntryService.getCustAmount4TimeChart(formattedSearchEndDate);
		
		//retrieve monthly sales entries
		List<MonthlySalesEntry> monthlySalesEntries = monthlySalesEntryService.getMonthlySalesEntries("", formattedSearchEndDate);
		String presentMonthId = formattedSearchEndDate.substring(0, 7);
		MonthlySalesEntry presentMonthSE = null;
		MonthlySalesEntry previousMonthSE = null;
		for(MonthlySalesEntry monthlySalesEntry : monthlySalesEntries) {
		    if(monthlySalesEntry.getBillDate().equals(presentMonthId)) {
		        presentMonthSE = monthlySalesEntry;
		    } else {
		        previousMonthSE = monthlySalesEntry;
		    }
		}
		
		model.addAttribute("todaySE", todaySalesEntry);
		model.addAttribute("presentMonthSE", presentMonthSE);
		model.addAttribute("previousMonthSE", previousMonthSE);
		model.addAttribute("dailySalesEntries", dailySalesEntries);
		model.addAttribute("preWeekDailySalesEntries", preWeekDailySalesEntries);
		model.addAttribute("paymentMethods", paymentMethods);
		model.addAttribute("salesAmount4TimeChart", salesAmount4TimeChart);
		model.addAttribute("custAmount4TimeChart", custAmount4TimeChart);
		
		return "dailySalesReport";
	}
}
