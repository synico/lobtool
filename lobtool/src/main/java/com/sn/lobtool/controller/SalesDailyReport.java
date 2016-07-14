package com.sn.lobtool.controller;

import java.util.Date;
import java.util.List;

import org.joda.time.DateTime;
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
    
    @RequestMapping(path="/daily/{searchDate}", method=RequestMethod.GET)
    public String getSalesDailyReport(@PathVariable @DateTimeFormat(pattern="yyyyMMdd") Date searchDate, Model model) {
        DateTime dt = new DateTime(searchDate);
        int dayOfWeek = dt.getDayOfWeek();
        String formattedSearchDate = dt.toString("yyyy-MM-dd");
        String searchEndDate = dt.plusDays(7-dayOfWeek).toString("yyyy-MM-dd");
        String previousSearchEndDate = dt.minusDays(dayOfWeek).toString("yyyy-MM-dd");
        
        //retrive daily sales entries
        List<DailySalesEntry> dailySalesEntries = dailySalesEntryService.getDailySalesEntries("", searchEndDate);
        List<DailySalesEntry> preWeekDailySalesEntries = dailySalesEntryService.getDailySalesEntries("", previousSearchEndDate);
        
        DailySalesEntry todaySalesEntry = null;
        for(DailySalesEntry dailySalesEntry : dailySalesEntries) {
            if(dailySalesEntry.getBillDate().equals(formattedSearchDate)) {
                todaySalesEntry = dailySalesEntry;
            }
        }
        
        List<PaymentMethods> paymentMethods = dailySalesEntryService.getPaymentMethods4Chart(formattedSearchDate);
        List<TimeChartEntries> salesAmount4TimeChart = dailySalesEntryService.getSalesAmount4TimeChart(formattedSearchDate);
        List<TimeChartEntries> custAmount4TimeChart = dailySalesEntryService.getCustAmount4TimeChart(formattedSearchDate);
        List<TimeChartEntries> billPerCust4TimeChart = dailySalesEntryService.getBillPerCust4TimeChart(formattedSearchDate);
        
        //retrieve monthly sales entries
        List<MonthlySalesEntry> monthlySalesEntries = monthlySalesEntryService.getMonthlySalesEntries("", formattedSearchDate);
        String presentMonthId = dt.toString("yyyy-MM");
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
        model.addAttribute("billPerCust4TimeChart", billPerCust4TimeChart);
        
        return "dailySalesReport";
    }
}
