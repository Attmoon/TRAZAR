package com.hys.trazar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hys.trazar.domain.DesignBoardDto;
import com.hys.trazar.domain.RequestDto;

public interface RequestMapper {
	
	DesignBoardDto getDesignBoardId();
	
	int addRequest(RequestDto dto);

	List<RequestDto> listRequest(@Param("type") String type, @Param("keyword") String keyword);
	
	RequestDto getRequestById(int id);

	int updateRequest(RequestDto dto);

	int removeRequestById(int id);
	
	void deleteByMemberId(String memberId);

	List<RequestDto> listRequestByCategory(String categoryName);

	List<RequestDto> myListRequest(@Param("memberId") String memberId, @Param("from") int from, @Param("row") int row);

	int countMyList(String memberId);

}
