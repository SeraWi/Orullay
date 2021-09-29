package com.bitcamp.orl.crew.service;

import java.io.IOException;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.crew.domain.CrewInsertRequest;
import com.bitcamp.orl.crew.mapper.CrewMapper;
import com.bitcamp.orl.s3.util.UploadFileUtils;

@Service
public class CrewInsertService {

	private static final Logger logger = LoggerFactory.getLogger(CrewInsertService.class);
	String bucketName = "minju-aws-bucket";

	private CrewMapper dao;

	@Autowired
	private SqlSessionTemplate template;

	// 크루 생성
	@Transactional
	public Crew insert(CrewInsertRequest crewRequest) throws IOException, Exception {

		Crew crew = crewRequest.toCrew();
		dao = template.getMapper(CrewMapper.class);

		// 크루 이름이 3글자 이상이 안되면 null 리턴
		if (crewRequest.getCrewName().trim().length() < 3) {
			return null;
		}
		if (crewRequest.getCrewPhoto() != null && !crewRequest.getCrewPhoto().isEmpty()) {
			
			//content type
			String contentType = crewRequest.getCrewPhoto().getContentType();
			
			// 웹 경로
			String uploadPath = "/fileupload/crew";

			// 파일저장
			String photoFileName = UploadFileUtils.uploadFile(
					uploadPath,
					crewRequest.getCrewPhoto().getOriginalFilename(),
					contentType,
					crewRequest.getCrewPhoto().getBytes());

			ResponseEntity<String> img_path = new ResponseEntity<>(photoFileName, HttpStatus.CREATED);

			String user_imgPath = (String) img_path.getBody();
			logger.info(user_imgPath);

			crew.setCrewPhoto(photoFileName);
		}
		// db처리
		dao.insertCrew(crew);
		dao.insertCrewReg(crew.getMemberIdx(), crew.getCrewIdx());
		return crew;
	}

	public Crew selectCrew(int crewIdx) {
		dao = template.getMapper(CrewMapper.class);
		return dao.selectCrew(crewIdx);
	}
}