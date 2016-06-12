package com.sn.lobtool.mapper;

import java.util.List;

import com.sn.lobtool.domain.DailySalesEntry;

public interface DailySalesEntryMapper {
	
	List<DailySalesEntry> getDailySalesEntries(String searchStartDate, String searchEndDate);

}
