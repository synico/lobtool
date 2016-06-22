package com.sn.lobtool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sn.lobtool.domain.MonthlySalesEntry;
import com.sn.lobtool.mapper.MonthlySalesEntryMapper;

@Service
public class MonthlySalesEntryService {
    
    @Autowired
    private MonthlySalesEntryMapper monthlySalesEntryMapper;
    
    public List<MonthlySalesEntry> getMonthlySalesEntries(String searchStartDate, String searchEndDate) {
        return monthlySalesEntryMapper.getMonthlySalesEntries(searchStartDate, searchEndDate);
    }

}
