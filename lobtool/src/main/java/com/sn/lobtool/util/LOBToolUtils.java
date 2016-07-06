package com.sn.lobtool.util;

import java.util.List;

import com.sn.lobtool.domain.PaymentMethods;
import com.sn.lobtool.domain.TimeChartEntries;

public class LOBToolUtils {
    
    public static List<PaymentMethods> calcProportion4Payment(List<PaymentMethods> pms) {
        Double amount = 0.0;
        for(PaymentMethods entry : pms) {
            amount = amount + entry.getNumOfTrans();
        }
        for(PaymentMethods entry : pms) {
            entry.setProportion(entry.getNumOfTrans()*100/amount);
        }
        return pms;
    }
    
    public static List<TimeChartEntries> calcProportion4TimeChart(List<TimeChartEntries> tes) {
        Double amount = 0.0;
        for(TimeChartEntries entry : tes) {
            amount = amount + entry.getAmount();
        }
        for(TimeChartEntries entry : tes) {
            entry.setProportion(entry.getAmount()*100/amount);
        }
        return tes;
    }
    
}
