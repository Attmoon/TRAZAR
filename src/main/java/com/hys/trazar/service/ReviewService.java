package com.hys.trazar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hys.trazar.domain.ReviewDto;
import com.hys.trazar.mapper.ReviewMapper;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewMapper mapper;

	public boolean insertReview(ReviewDto dto) {
		
		// 댓글 등록
		int cnt = mapper.insertReview(dto);
		
		return cnt == 1; 
	}

	public List<ReviewDto> listReview() {
		
		return mapper.selectReview();
		
	}

	public boolean updateReview(ReviewDto dto) {

		int cnt = mapper.updateReview(dto);
		
		return cnt == 1;
	}

	public boolean removeReview(ReviewDto dto) {
		
		int cnt = mapper.removeReview(dto);
		
		return cnt == 1;
	}

}
