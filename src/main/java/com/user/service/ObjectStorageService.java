package com.user.service;

import org.springframework.web.multipart.MultipartFile;

public interface ObjectStorageService {

	public String uploadFile(String bucketName, String string, MultipartFile img);

	public void deleteFile(String bucketName, String ncpFilePath, String imageFileName);

}
