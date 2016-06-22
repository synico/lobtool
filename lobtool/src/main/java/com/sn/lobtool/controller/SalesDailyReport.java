package com.sn.lobtool.controller;

import java.text.SimpleDateFormat;
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
	    SimpleDateFormat sdfTo = new SimpleDateFormat("yyyy-MM-dd");
	    String formattedSearchEndDate = sdfTo.format(searchEndDate);
		List<DailySalesEntry> dailySalesEntries = dailySalesEntryService.getDailySalesEntries("", formattedSearchEndDate);
		List<MonthlySalesEntry> monthlySalesEntries = monthlySalesEntryService.getMonthlySalesEntries("", formattedSearchEndDate);
		
		model.addAttribute("dailySalesEntries", dailySalesEntries);
		return "dailySalesReport";
	}
}
