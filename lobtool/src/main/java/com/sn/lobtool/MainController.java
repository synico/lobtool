package com.sn.lobtool;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sn.lobtool.domain.PayMethod;
import com.sn.lobtool.service.PayMethodService;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private PayMethodService payMethodService;
	
	@RequestMapping("/get/{date}")
	public String performExecute(HttpServletRequest request, HttpServletResponse response) {
		List<PayMethod> payMethods = payMethodService.getAllPayMethod();
		request.setAttribute("payMethods", payMethods);
		return "paymethod";
	}

}
