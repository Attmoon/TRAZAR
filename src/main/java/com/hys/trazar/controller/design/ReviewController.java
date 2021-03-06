package com.hys.trazar.controller.design;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hys.trazar.domain.ReviewDto;
import com.hys.trazar.service.ReviewService;

@Controller
@RequestMapping("review")
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	// ajax 처리를 위해 ResponseEntity 사용 (success, error)
	@PostMapping(path = "insert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(ReviewDto dto, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			String memberId = principal.getName();
			dto.setMemberId(memberId);
			
			boolean success = service.insertReview(dto);
	
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}

	}
	
	// ajax 처리를 위해 ResponseEntity 사용 (success, error)
	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> modify(@RequestBody ReviewDto dto, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {

			boolean success = service.updateReview(dto, principal);
	
			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
		}
	}
	
	// ajax 처리를 위해 ResponseEntity 사용 (success, error)
	@DeleteMapping(path = "delete/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("id") int id, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
		
			boolean success = service.deleteReview(id, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글을 삭제 하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
		}
	}
	
	// ReviewDto를 List로 받기 위해서는 @ResponseBody 필요
	@GetMapping("list")
	@ResponseBody
	public List<ReviewDto> list(int designBoardId, Principal principal) {
		if (principal == null) {
			return service.getReviewByDesignBoardId(designBoardId);
		} else {
			return service.getReviewWithOwnByDesignBoardId(designBoardId, principal.getName());
		}
	}
	
}

























