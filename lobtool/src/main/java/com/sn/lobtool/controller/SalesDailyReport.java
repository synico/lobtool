package com.sn.lobtool.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sn.lobtool.domain.DailySalesEntry;
import com.sn.lobtool.service.DailySalesEntryService;

@Controller
@RequestMapping("/salesReport")
public class SalesDailyReport {
	
	@Autowired
	private DailySalesEntryService dailySalesEntryService;
	
	@RequestMapping(path="/daily/{searchEndDate}", method=RequestMethod.GET)
	public String getSalesDailyReport(@PathVariable("searchEndDate") String searchEndDate, Model model) {
		SimpleDateFormat sdfTo = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfFrom = new SimpleDateFormat("yyyyMMdd");
		String formattedSearchEndDate = null;
		try {
			Date theDate = sdfFrom.parse(searchEndDate);
			formattedSearchEndDate = sdfTo.format(theDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		List<DailySalesEntry> dailySalesEntries = dailySalesEntryService.getDailySalesEntries("", formattedSearchEndDate);
//		request.setAttribute("dailySalesEntries", dailySalesEntries);
		model.addAttribute("dailySalesEntries", dailySalesEntries);
		
		return "dailySalesReport";
	}
}
