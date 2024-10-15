package com.user.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.user.bean.UserUploadDTO;
import com.user.dao.UserDAO;
import com.user.dao.UserUploadDAO;

@Service
public class UserUploadServiceImpl implements UserUploadService{
	@Autowired
	private UserUploadDAO userUploadDAO;
	@Autowired
	private HttpSession session;
	@Autowired
	private ObjectStorageService objectStorageService;
	private String bucketName = "my-bucket1";
	@Override
	public void upload(List<UserUploadDTO> imgUploadList) {
		userUploadDAO.upload(imgUploadList);
		
	}
	@Override
	public List<UserUploadDTO> uploadList() {
		// TODO Auto-generated method stub
		return userUploadDAO.uploadList();
	}
	@Override
	public UserUploadDTO getUploadDTO(String seq) {
		
		return userUploadDAO.getUploadDTO(seq);
	}
	@Override
	public void uploadUpdate(UserUploadDTO userUploadDTO, MultipartFile img) {
		//실제폴더
		String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		System.out.println("실제 폴더 = " + filePath);
		
		//Object Storate(NCP)는 이미지를 덮어쓰기 않는다.
		//DB에서 seq에 해당하는 imageFileName을 꺼내와서 Object Storate(NCP)의 이미지를 삭제하고,
		//새로운 이미지를 올린다.
		String imageFileName = userUploadDAO.getImageFileName(userUploadDTO.getSeq());
		//Object Storate(NCP)는 이미지 삭제
		objectStorageService.deleteFile(bucketName, "storage/", imageFileName);
		
		//Object Storate(NCP)는 새로운 이미지 올리기
		imageFileName = objectStorageService.uploadFile(bucketName, "storage/", img);
		
		
		String imageOriginalFileName = img.getOriginalFilename();
		File file = new File(filePath, imageOriginalFileName);
		
		try {
			img.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		userUploadDTO.setImageFileName(imageFileName);
		userUploadDTO.setImageOriginalFileName(imageOriginalFileName);
		
		//DB
		userUploadDAO.uploadUpdate(userUploadDTO);
	}
	@Override
	public void deleteSelected(List<String> seqList) {
		for(String seq: seqList) {
			String imageFileName = userUploadDAO.getImageFileName(Integer.parseInt(seq));
			//Object Storate(NCP)는 이미지 삭제
			objectStorageService.deleteFile(bucketName, "storage/", imageFileName);
		}
		userUploadDAO.deleteSelected(seqList);
		
	}

}
