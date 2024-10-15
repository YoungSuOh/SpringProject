package com.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.user.bean.UserUploadDTO;
import com.user.service.ObjectStorageService;
import com.user.service.UserService;
import com.user.service.UserUploadService;

@Controller
@RequestMapping(value = "user")
public class UserUploadController {
	@Autowired
	private UserUploadService userUploadService;

	// ncp연결
	@Autowired
	private ObjectStorageService objectStorageService;
	private String bucketName = "my-bucket1";

	// ncp연결
	@RequestMapping(value = "uploadForm")
	public String uploadForm() {
		return "/upload/uploadForm";
	}
	/*
	 * @RequestMapping(value="upload", method=RequestMethod.POST)
	 * 
	 * @ResponseBody public String upload(@ModelAttribute UserUploadDTO
	 * userUploadDTO, @RequestParam MultipartFile img, HttpSession session) { // 실제
	 * 폴더 String filePath =
	 * session.getServletContext().getRealPath("WEB-INF/storage");
	 * System.out.println(filePath); // C:\SpringStudy\Spring
	 * framework\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\
	 * wtpwebapps\SpringProject\WEB-INF\storage
	 * 
	 * String imageOriginalFileName = img.getOriginalFilename();
	 * 
	 * File file = new File(filePath, imageOriginalFileName); try {
	 * img.transferTo(file); }catch(IllegalStateException e) { e.printStackTrace();
	 * }catch(IOException e) { e.printStackTrace(); } String result = "<span>"
	 * +"<img src='/spring/storage/" +
	 * imageOriginalFileName+"' width='300' height='300'>"+ "</span>";
	 * System.out.println(userUploadDTO);
	 * userUploadDTO.setImageOriginalFileName(imageOriginalFileName);
	 * 
	 * // DB
	 * 
	 * 
	 * return result; }
	 */

	// 2개 이상 업로드
	/*
	 * @RequestMapping(value = "upload", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public String upload(@ModelAttribute UserUploadDTO
	 * userUploadDTO,
	 * 
	 * @RequestParam MultipartFile[] img img가 배열로 들어온다. W , HttpSession session) {
	 * // 실제 폴더 String filePath =
	 * session.getServletContext().getRealPath("WEB-INF/storage");
	 * System.out.println(filePath); // C:\SpringStudy\Spring //
	 * framework\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\
	 * wtpwebapps\SpringProject\WEB-INF\storage
	 * 
	 * String imageOriginalFileName; File file; String result;
	 * 
	 * // ---------- img 1 imageOriginalFileName = img[0].getOriginalFilename();
	 * file = new File(filePath, imageOriginalFileName);
	 * 
	 * try { img[0].transferTo(file); } catch (IllegalStateException e) {
	 * e.printStackTrace(); } catch (IOException e) { e.printStackTrace(); } result
	 * = "<span>" + "<img src='/spring/storage/" + imageOriginalFileName +
	 * "' width='300' height='300'>" + "</span>";
	 * 
	 * // ---------- img 2 imageOriginalFileName = img[1].getOriginalFilename();
	 * file = new File(filePath, imageOriginalFileName);
	 * 
	 * try { img[1].transferTo(file); } catch (IllegalStateException e) {
	 * e.printStackTrace(); } catch (IOException e) { e.printStackTrace(); } result
	 * += "<span>" + "<img src='/spring/storage/" + imageOriginalFileName +
	 * "' width='300' height='300'>" + "</span>";
	 * 
	 * /* System.out.println(userUploadDTO);
	 * userUploadDTO.setImageOriginalFileName(imageOriginalFileName);
	 */

	// DB

	/*
	 * return result; }
	 */

	@RequestMapping(value = "upload", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String upload(@ModelAttribute UserUploadDTO userUploadDTO, @RequestParam("img[]") List<MultipartFile> list,
			HttpSession session) {
		// 실제 폴더
		String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		System.out.println("실제폴더 : " + filePath); // C:\SpringStudy\Spring
		// framework\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\SpringProject\WEB-INF\storage
		String imageFileName;
		String imageOriginalFileName;
		File file;
		String result = "";
		// 파일들을 모아서 DB로 보내기

		List<UserUploadDTO> imgUploadList = new ArrayList<>();
		for (MultipartFile img : list) {
			// ncp objectStorage에 올리기
			// imageFileName = UUID.randomUUID().toString(); 주석 검

			// 네이버 클라우드 Object Storage
			imageFileName = objectStorageService.uploadFile(bucketName, "storage/", img);

			imageOriginalFileName = img.getOriginalFilename();
			System.out.println("imageOriginalFileName: " + imageOriginalFileName);
			file = new File(filePath, imageOriginalFileName);
			try {
				img.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			result += "<span>" + "<img src='/spring/storage/" + imageOriginalFileName + "' width='300' height='300'>"
					+ "</span>";
			UserUploadDTO dto = new UserUploadDTO();
			dto.setImageName(userUploadDTO.getImageName());
			dto.setImageContent(userUploadDTO.getImageContent());
			dto.setImageFileName(imageFileName);
			dto.setImageOriginalFileName(imageOriginalFileName);

			imgUploadList.add(dto);
		}
		for (UserUploadDTO userUploadDTO2 : imgUploadList) {
			System.out.println(userUploadDTO2.getImageFileName());
		}
		// DB
		userUploadService.upload(imgUploadList);

		return result;
	}

	@RequestMapping(value = "uploadAjaxForm")
	public String uploadAjaxForm() {
		return "/upload/uploadAjaxForm";
	}

	@RequestMapping(value = "uploadList")
	public ModelAndView uploadList() {
		List<UserUploadDTO> list = userUploadService.uploadList();

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("/upload/uploadList");

		return mav;
	}

	@RequestMapping(value = "uploadView")
	public String uploadView(@RequestParam String seq, Model model) {
		UserUploadDTO userUploadDTO = userUploadService.getUploadDTO(seq);
		model.addAttribute("userUploadDTO", userUploadDTO);
		return "/upload/uploadView";
	}

	@RequestMapping(value = "uploadUpdateForm")
	public String uploadUpdateForm(@RequestParam String seq, Model model) {
		UserUploadDTO userUploadDTO = userUploadService.getUploadDTO(seq);
		model.addAttribute("userUploadDTO", userUploadDTO);
		return "/upload/uploadUpdateForm";
	}

	@RequestMapping(value = "uploadUpdate", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String uploadUpdate(@ModelAttribute UserUploadDTO userUploadDTO, @RequestParam("img") MultipartFile img) {
		userUploadService.uploadUpdate(userUploadDTO, img);
		return "이미지 수정 완료";
	}

	@RequestMapping(value = "deleteSelected")
	@ResponseBody
	public String deleteSelected(@RequestParam("seqs") String seqs) {
		List<String> seqList = Arrays.asList(seqs.split(","));
		userUploadService.deleteSelected(seqList);
		return "이미지 삭제 완료";
	}
}
