package com.finale.bookit.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finale.bookit.admin.model.dao.AdminDao;
import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;
import com.finale.bookit.inquire.model.dao.InquireDao;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public int insertAdminReply(AdminInquire adminInquire) {
		return adminDao.insertAdminReply(adminInquire);
	}

	@Override
	public List<Chart> selectChart() {
		return adminDao.selectChart();
	}

}
