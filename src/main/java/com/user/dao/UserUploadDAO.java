package com.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.user.bean.UserUploadDTO;

@Mapper  // DAO는 구현 객체를 만들지 않는다.
public interface UserUploadDAO {
	void upload(List<UserUploadDTO> imgUploadList);
	List<UserUploadDTO> uploadList();
	UserUploadDTO getUploadDTO(String seq);
	public void uploadUpdate(UserUploadDTO userUploadDTO);
	String getImageFileName(int seq);
	void deleteSelected(List<String> seqList);
}
