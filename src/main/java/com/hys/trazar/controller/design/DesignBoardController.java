package com.hys.trazar.controller.design;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.jsoup.nodes.*;
import org.jsoup.select.Elements;
import org.jsoup.*;
import org.jsoup.Connection.Method;

import com.hys.trazar.domain.DesignBoardDto;
import com.hys.trazar.domain.ReviewDto;
import com.hys.trazar.mapper.DesignBoardMapper;
import com.hys.trazar.service.DesignBoardService;
import com.hys.trazar.service.ReviewService;

import static org.imgscalr.Scalr.OP_ANTIALIAS;
import static org.imgscalr.Scalr.OP_BRIGHTER;
import static org.imgscalr.Scalr.pad;
import static org.imgscalr.Scalr.resize;
import static org.imgscalr.Scalr.*;


@Controller
@RequestMapping("designBoard")
public class DesignBoardController {
	
	private static final String FILE2 = "file";
	private static final Logger LOGGER = LoggerFactory.getLogger(DesignBoardController.class);
	private static final String UPLOADIMG = "/static/uploadimg/";
	private static final String STATIC_IMAGES_THUMBNAILS = "/static/images/thumbnails/";
	 
	@Autowired
	 ServletContext servletContext;
	
	@Autowired
	private DesignBoardService service;
	
	@Autowired
	private ReviewService reviewService;
	
	
	@RequestMapping("list")
	public void list(Model model) {
		List<DesignBoardDto> list = service.listDesignBoard();
		
		model.addAttribute("designBoardList", list);
	}

	@GetMapping("insert")
	public void insert() {
		
	}
	
	
	@PostMapping("insert")
	public String insert(DesignBoardDto designBoard,
				Principal principal,	
				RedirectAttributes rttr) {
		
		designBoard.setMemberId(principal.getName());
		
		boolean success = service.insertDesignBoard(designBoard);
		
		if (success) {
			rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 글이 등록되지 않았습니다.");
		}
		
		return "redirect:/designBoard/list";
	}
	
	@GetMapping("get")
	public void get(int id, Model model) {
		DesignBoardDto dto = service.getDesignBoardById(id);
		
		// designBoard 내에서 review 목록을 보기 위해 추가
		List<ReviewDto> reviewList = reviewService.getReviewByDesignBoardId(id);
		
		model.addAttribute("designBoard", dto);
	}
	
	@PostMapping("modify")
	public String modify(DesignBoardDto dto, Principal principal, RedirectAttributes rttr) {
		
		DesignBoardDto oldBoard = service.getDesignBoardById(dto.getId());
		
		if(oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.updateDesignBoard(dto);
			
			if(success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다");
			}			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다");
		}
		
		rttr.addAttribute("id", dto.getId());
		rttr.addAttribute("memberId", principal.getName());
		
		return "redirect:/designBoard/get";
	}
	
	
	@PostMapping("remove")
	public String remove(DesignBoardDto dto, Principal principal, RedirectAttributes rttr) {
		// 게시물 정보 얻고
		DesignBoardDto oldBoard = service.getDesignBoardById(dto.getId());
		
		if(oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.deleteDesignBoard(dto.getId());
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
				
			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다");
			rttr.addAttribute("id", dto.getId());
			return "redirect:/designBoard/get";
		}
		
		return "redirect:/designBoard/list";
	}
	
	
	// 썸머노트 에디터에서 받는 이미지 업로드 처리
	@RequestMapping(value = "/imageupload", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String imageUpload(MultipartHttpServletRequest request) throws IOException {
		
		// 01. 리퀘스트에서 멀티파트파일을 받아서
		MultiValueMap<String, MultipartFile> multiFileMap = request.getMultiFileMap();
		List<MultipartFile> list = multiFileMap.get(FILE2);
		MultipartFile multipartFile = list.get(0);
		LOGGER.debug(multipartFile.getOriginalFilename());
	

		// 02. 파일을 전송하고
		String webappRoot = servletContext.getRealPath("/"); 
		String filename = UPLOADIMG + multipartFile.getOriginalFilename();
		File file = new File(webappRoot + filename);
		multipartFile.transferTo(file);

		// 03. 마지막에 최종 주소를 반환한다.
		// requet.getServername 을 하니, ajax에서 보내는 값이 리퀘스트 정보에 안떠서 InetAddress로 받는다 
		String localIP = InetAddress.getLocalHost().getHostAddress();
		// http://를 붙여줘야 에디터 창에서 불러올 수가 있다. 
		return "http://" + localIP + ":" + request.getServerPort() + filename;
		
	}
	
	// 썸네일 컨트롤러
	@RequestMapping(method = RequestMethod.POST)
	public String save(DesignBoardDto designBoard) throws IOException
	{
		/* 02. 글에서 추출해서 <img> 태그가 걸려있으면 썸네일 만들기 */
		String source = designBoard.getBody();
		Document doc = Jsoup.parse(source);
		Elements elements = doc.select("img");
		String url = checkElements(elements);
		String localIP = InetAddress.getLocalHost().getHostAddress();
		if (url != null) {
			if (url.startsWith("http://"+localIP)) {
				LOGGER.debug("썸네일 생성 작업 처리 시작.. ");
				String webAppRoot = servletContext.getRealPath("/");
				url = url.substring(url.lastIndexOf("/") + 1);
				String ext = url.substring(url.lastIndexOf(".") + 1);
			
				File file = new File(webAppRoot + UPLOADIMG + url);
				BufferedImage img = ImageIO.read(file);
				BufferedImage thumbnail = createThumbnail(img);

				File thumbnailoutput = new File(webAppRoot + STATIC_IMAGES_THUMBNAILS + url);
				ImageIO.write(thumbnail, ext, thumbnailoutput);
			}
			designBoard.setImgthumbnail(url);
		}
		LOGGER.debug("designBoard : {}", designBoard);
		DesignBoardMapper.save(designBoard);
		return "redirect:/designBoard/list";
	}
	
	public String checkElements(Elements elements)
	{
		if (elements.size() > 0) {
			Elements elem = elements.get(0).getElementsByAttribute("src");
			String url = elem.toString();
			int pos = url.indexOf("src=\"") + 5;
			url = url.substring(pos, url.indexOf("\"", pos));
			LOGGER.debug("img url :{}",url);
			// System.out.println(url.startsWith("http")+":"+url);
			return url;
		}
		return null;
	}
	
	public static BufferedImage createThumbnail(BufferedImage img)
	{
		// Create quickly, then smooth and brighten it.
		img = resize(img, org.imgscalr.Scalr.Method.SPEED, 150, OP_ANTIALIAS, OP_BRIGHTER);
		// Let's add a little border before we return result.
		return pad(img, 4);
	}

}
