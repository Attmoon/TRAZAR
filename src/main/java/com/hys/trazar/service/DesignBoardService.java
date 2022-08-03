package com.hys.trazar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hys.trazar.domain.DesignBoardDto;
import com.hys.trazar.domain.LikeDto;
import com.hys.trazar.mapper.DesignBoardMapper;
import com.hys.trazar.mapper.LikeMapper;
import com.hys.trazar.mapper.ReviewMapper;

@Service
public class DesignBoardService {

	@Autowired
	private DesignBoardMapper mapper;

	@Autowired
	private LikeMapper likemapper;
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	// get service
	public DesignBoardDto getDesignBoardById(int id) {
		DesignBoardDto designBoard = mapper.selectDesignBoardById(id);
		return designBoard;
	}

	
	// insert service
	@Transactional
	public boolean insertDesignBoard(DesignBoardDto designBoard) {
		// 게시물 등록
		int cnt = mapper.insertDesignBoard(designBoard);

		//addFiles(designBoard.getId(), files);

		return cnt == 1;
	}
	
		
	// list service	
	public List<DesignBoardDto> listDesignBoard() {
		return mapper.selectDesignBoardAll();
	}
	
	//search service
	public List<DesignBoardDto> searchListDesignBoard(String type, String keyword) {
		return mapper.selectDesignBoardAll(type, "%" + keyword + "%");
	}
	
	// modify service
	public boolean updateDesignBoard(DesignBoardDto dto) {
		int cnt = mapper.updateDesignBoard(dto);
		return cnt == 1;
	}

	// remove service
	@Transactional
	public boolean deleteDesignBoard(int id) {
		likemapper.deleteLikeByDesignBoardId(id);
		reviewMapper. deleteByDesignBoardId(id);
		return mapper.deleteDesignBoard(id) == 1;
	}
	
	// clicked service
	public boolean increamentClicked(DesignBoardDto dto) {
		int cnt = mapper.increamentClicked(dto);
		return cnt == 1;
	}
	
	// category service
	public List<DesignBoardDto> listDesignBoard(String categoryName) {
		return mapper.selectDesignBoardCategory(categoryName);
	}

	// hotlist service
	public List<DesignBoardDto> hotList() {
		return mapper.hotList();
		
	}

	/*	// 게시물에 대한 좋아요 사용자 리스트
		public List<LikeDto> getLikersList(int designBoardId, String memberId) {
			return likemapper.getLikersPicked(designBoardId);
		}
		
		// like service
		// 리뷰 좋아요 수 설정 및 얻기
		public int likeCount(@RequestParam("designBoardId")int designBoardId, @RequestParam("memberId")int memberId) {
			// 좋아요 누른 사용자 리스트 조회
			List<LikeDto> likers = likemapper.getLikersPicked(designBoardId);
			
			for(LikeDto userLikers : likers) {
				if(userLikers.getMemberId().equals(memberId)) {
					throw new RuntimeException("이미 좋아요를 눌러줬어요 !");
				}
			}
			likemapper.setLikeCount(designBoardId);
			likemapper.insertLikers(designBoardId, memberId);
				
			return likemapper.getLikeCount(designBoardId);
		}*/


	public int likeSelectById(LikeDto likeDto) {
		return mapper.likeSelectById(likeDto);
	}
	

	public void likeInsert(LikeDto likeDto) {
		mapper.likeInsert(likeDto);		
	}


	public int likeGetInfo(LikeDto likeDto) {
		return mapper.likeGetInfo(likeDto);
	}


	public int likeUpdate(LikeDto likeDto) {
		mapper.likeUpdate(likeDto);
		return mapper.selectDesignBoardById(likeDto.getDesignBoardId()).getLikeCount();
	}


//	public int updateLikeCount(LikeDto likeDto) {
//		mapper.updateLikeCount(likeDto);
//		return likeDto.getLikeCount();
//	}
	
		

}
