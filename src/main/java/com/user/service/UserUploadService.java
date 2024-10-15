package com.user.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.user.bean.UserUploadDTO;

public interface UserUploadService {

	public void upload(List<UserUploadDTO> imgUploadList);

	public List<UserUploadDTO> uploadList();

	public UserUploadDTO getUploadDTO(String seq);

	public void uploadUpdate(UserUploadDTO userUploadDTO, MultipartFile img);

	public void deleteSelected(List<String> seqList);

}
