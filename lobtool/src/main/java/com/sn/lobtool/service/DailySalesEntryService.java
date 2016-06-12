package com.sn.lobtool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sn.lobtool.domain.DailySalesEntry;
import com.sn.lobtool.mapper.DailySalesEntryMapper;

@Service
public class DailySalesEntryService {
	
	@Autowired
	private DailySalesEntryMapper dailySalesEntryMapper;
	
	public List<DailySalesEntry> getDailySalesEntries(String searchStartDate, String searchEndDate) {
		return dailySalesEntryMapper.getDailySalesEntries(searchStartDate, searchEndDate);
	}

}
