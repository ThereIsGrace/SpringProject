package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.mapper.MemberMapper;
import org.zerock.mapper.Product_ReviewMapper;
import org.zerock.mapper.QnAMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private Product_ReviewMapper reviewMapper;
	
	@Autowired
	private QnAMapper qnaMapper;
}