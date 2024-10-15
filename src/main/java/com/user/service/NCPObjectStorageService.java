package com.user.service;

import java.io.InputStream;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import spring.conf.NaverConfiguration;

@Service
public class NCPObjectStorageService implements ObjectStorageService {
	private final AmazonS3 s3;
	private NaverConfiguration naverConfiguration;

	public NCPObjectStorageService(NaverConfiguration naverConfiguration) {
		s3 = AmazonS3ClientBuilder.standard()
				.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(naverConfiguration.getEndPoint(),
						naverConfiguration.getRegionName()))
				.withCredentials(new AWSStaticCredentialsProvider(
						new BasicAWSCredentials(naverConfiguration.getAccessKey(), naverConfiguration.getSecretKey())))
				.build();
	}

	@Override
	public String uploadFile(String bucketName, String ncpDirectoryPath, MultipartFile img) {
		String imageFileName;
		try (InputStream inputStream = img.getInputStream()) {
			imageFileName = UUID.randomUUID().toString();
			ObjectMetadata objectMetadata = new ObjectMetadata();
			// objectMetadata.setContentType("image/jpeg"); 이러면 귀찮음 for 문 써줘야함

			objectMetadata.setContentType(img.getContentType());
			objectMetadata.setContentLength(img.getSize());

			// putObjectRequest 생성해서 bucketName 에 directoryPath + fileName 이름으로 파일 불러들임
			PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, ncpDirectoryPath + imageFileName,
					inputStream, objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead);
			// Acl : 리소스에 대한 접근 권한
			// 모든 사용자가 객체를 읽을 수 있지만, 수정과 삭제는 불가능

			s3.putObject(putObjectRequest);
			return imageFileName;

		} catch (Exception e) {
			throw new RuntimeException("파일 업로드 에러");
		}
	}

	@Override
	public void deleteFile(String bucketName, String ncpFilePath, String imageFileName) {
		try {
			s3.deleteObject(bucketName, ncpFilePath + imageFileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
