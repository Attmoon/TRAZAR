package com.hys.trazar.controller.design;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hys.trazar.domain.DesignBoardDto;
import com.hys.trazar.domain.LikeDto;
import com.hys.trazar.domain.ReviewDto;
import com.hys.trazar.domain.login.SignupDto;
import com.hys.trazar.service.DesignBoardService;
import com.hys.trazar.service.ReviewService;

@Controller
@RequestMapping("designBoard")
public class DesignBoardController {

	private static final String FILE2 = "file";
	private static final Logger LOGGER = LoggerFactory.getLogger(DesignBoardController.class);
	private static final String UPLOADIMG = "/static/uploadimg/";

	@Autowired
	ServletContext servletContext;

	@Autowired
	private DesignBoardService service;

	@Autowired
	private ReviewService reviewService;

	@RequestMapping("list")
	public void list( Model model, String categoryName) {
		
		List<DesignBoardDto> hotList = service.hotList();
		
		List<DesignBoardDto> list = null;
		if(categoryName == null) {
			list = service.listDesignBoard();
		} else {
			
			list = service.listDesignBoard(categoryName);
		}
		
		processThumbNailImage(list);
		processThumbNailImageHotList(hotList);
		model.addAttribute("hotList", hotList);
		model.addAttribute("designBoardList", list);
	}
	
	/* hot list thumbnail */
	private void processThumbNailImageHotList(List<DesignBoardDto> hotList) {
		for (DesignBoardDto dto : hotList) {
			String thumbNail = "";
			
			String source = dto.getBody();
			Document doc = Jsoup.parse(source);
			Elements elements = doc.select("img");
			
			if (elements.size() > 0) {
				thumbNail = elements.get(0).attr("src").toString();
			}
			
			dto.setImgthumbnail(thumbNail);
		}
		
	}

	// ???????????? ????????? ??????
	private void processThumbNailImage(List<DesignBoardDto> list) {
		
		for (DesignBoardDto dto : list) {
			String thumbNail = "";
			
			String source = dto.getBody();
			Document doc = Jsoup.parse(source);
			Elements elements = doc.select("img");
			
			if (elements.size() > 0) {
				thumbNail = elements.get(0).attr("src").toString();
			}
			
			dto.setImgthumbnail(thumbNail);
		}
	}
	
	//?????? ?????? ????????? ?????????,??????.java, ?????? ???????????????
	@RequestMapping("search")
	public void searchList(@RequestParam(name = "keyword", defaultValue = "") String keyword,
			 @RequestParam(name = "type", defaultValue = "") String type,
			 Model model) {
		List<DesignBoardDto> list = service.searchListDesignBoard(type, keyword);

		processThumbNailImage(list);
		model.addAttribute("designBoardList", list);
	}
	

	@GetMapping("insert")
	public void insert() {

	}

	@PostMapping("insert")
	public String insert(DesignBoardDto designBoard,
			Principal principal,
			RedirectAttributes rttr) {

		if(designBoard.getPrice() == "") {
			designBoard.setPrice("???????????????");
		}
		
		designBoard.setMemberId(principal.getName());

		boolean success = service.insertDesignBoard(designBoard);
		if (success ) {
			
			rttr.addFlashAttribute("message", "??? ?????? ?????????????????????.");
		} else {
			rttr.addFlashAttribute("message", "??? ?????? ???????????? ???????????????.");
		}

		return "redirect:/designBoard/list";
	}

	@GetMapping("get")
	public void get(@RequestParam(name = "id") int id, Model model, DesignBoardDto dto2, Principal principal, SignupDto sDto) {
			
		DesignBoardDto dto = service.getDesignBoardById(id);
		
		/*????????? ?????? ??????*/
		LikeDto likeDto = new LikeDto();
		likeDto.setDesignBoardId(dto.getId());
	
		int likeCheck = 0;
		if (principal != null) {
			sDto.setName(principal.getName());
			likeDto.setMemberId(sDto.getName());
			int Check = service.likeSelectById(likeDto);
			if(Check == 0) {
				service.likeInsert(likeDto);
			} else if (Check == 1) {
				likeCheck = service.likeGetInfo(likeDto);
			}
		} else {
			likeDto.setMemberId(sDto.getName());
		}
		
		model.addAttribute("likeCheck", likeCheck);
		
		service.increamentClicked(dto2);

		// designBoard ????????? review ????????? ?????? ?????? ??????
		List<ReviewDto> reviewList = reviewService.getReviewByDesignBoardId(id);
		
		
		model.addAttribute("designBoard", dto);
		model.addAttribute("likeDto", likeDto);
	}
	
	@ResponseBody
	@PostMapping("/likeUpdate")
	public Map<String, Object> likeUpdate(@RequestBody LikeDto likeDto, DesignBoardDto dto) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			map.put("result", "success");
			
			int cnt = service.likeUpdate(likeDto);
			map.put("count", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}

	
	@GetMapping("modify") 
	public void getmodify(int id, Model model) {
		DesignBoardDto dto = service.getDesignBoardById(id);
		model.addAttribute("designBoard", dto);
	}
	
	@PostMapping("modify")
	public String modify(DesignBoardDto dto, Principal principal, RedirectAttributes rttr) {

		boolean success = service.updateDesignBoard(dto);
		
		if (success ) {	
			rttr.addFlashAttribute("message", "???????????? ?????????????????????.");
		} else {
			rttr.addFlashAttribute("message", "???????????? ???????????? ???????????????.");
		}

		rttr.addAttribute("id", dto.getId());
		rttr.addAttribute("memberId", principal.getName());

		return "redirect:/designBoard/get";
	}

	@PostMapping("remove")
	public String remove(DesignBoardDto dto, Principal principal, RedirectAttributes rttr) {
				
		// ????????? ?????? ??????
		DesignBoardDto oldBoard = service.getDesignBoardById(dto.getId());
				
		boolean success = service.deleteDesignBoard(dto.getId());
		
		if (success) {
			rttr.addFlashAttribute("message", "?????? ?????? ???????????????.");
			
		} else {
			rttr.addFlashAttribute("message", "?????? ?????? ?????????????????????.");
		}

		return "redirect:/designBoard/list";
	}

	// ???????????? ??????????????? ?????? ????????? ????????? ??????
	@RequestMapping(value = "/imageupload", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String imageUpload(MultipartHttpServletRequest request) throws IOException {
	
		// 01. ?????????????????? ????????????????????? ?????????
		MultiValueMap<String, MultipartFile> multiFileMap = request.getMultiFileMap();
		List<MultipartFile> list = multiFileMap.get(FILE2);
		MultipartFile multipartFile = list.get(0);
		LOGGER.debug(multipartFile.getOriginalFilename());
	
		// 02. ????????? ????????????
		String webappRoot = servletContext.getRealPath("/");
		String filename = UPLOADIMG + multipartFile.getOriginalFilename();
		File file = new File(webappRoot + filename);
		multipartFile.transferTo(file);
	
		// 03. ???????????? ?????? ????????? ????????????.
		// requet.getServername ??? ??????, ajax?????? ????????? ?????? ???????????? ????????? ????????? InetAddress??? ????????? 
		String localIP = InetAddress.getLocalHost().getHostAddress();
		// http://??? ???????????? ????????? ????????? ????????? ?????? ??????. 
		return "http://" + localIP + ":" + request.getServerPort() + filename;
	
	}
	
	
	
	
}