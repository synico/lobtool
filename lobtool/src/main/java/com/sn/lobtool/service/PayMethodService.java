package com.sn.lobtool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sn.lobtool.domain.PayMethod;
import com.sn.lobtool.mapper.PayMethodMapper;

@Service
public class PayMethodService {
	
	@Autowired
	private PayMethodMapper payMethodMapper;
	
	public List<PayMethod> getAllPayMethod() {
		return payMethodMapper.getAllPayMethod();
	}
	

}
