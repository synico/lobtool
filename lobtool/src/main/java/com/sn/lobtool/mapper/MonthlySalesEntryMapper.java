package com.sn.lobtool.mapper;

import java.util.List;

import com.sn.lobtool.domain.MonthlySalesEntry;

public interface MonthlySalesEntryMapper {
    
    List<MonthlySalesEntry> getMonthlySalesEntries(String searchStartDate, String searchEndDate);

}
