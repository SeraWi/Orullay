package com.bitcamp.orl.crew.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.crew.domain.CrewInsertRequest;
import com.bitcamp.orl.crew.mapper.CrewMapper;
import com.bitcamp.orl.s3.util.S3Util;
import com.bitcamp.orl.s3.util.UploadFileUtils;

@Service
public class CrewManageService {

	CrewMapper dao;

	@Autowired
	SqlSessionTemplate template;

	// 해당 페이지에 접근할 권한이 있는지(크루장인지) 확인하기
	public boolean isHaveAuth(int crewIdx, int memberIdx) {
		boolean chk = false;

		int crewAuthIdx = selectCrew(crewIdx).getMemberIdx();
		if (memberIdx == crewAuthIdx) {
			chk = true;
		}
		return chk;
	}

	// 한 크루 선택
	public Crew selectCrew(int crewIdx) {
		dao = template.getMapper(CrewMapper.class);
		Crew crew = dao.selectCrew(crewIdx);
		return crew;
	}

	// 크루 수정
	public int updateCrew(CrewInsertRequest crewRequest, int crewIdx) {
		
		S3Util s3 = new S3Util();
		int resultCnt = 0;
		dao = template.getMapper(CrewMapper.class);

		try {
			// 크루 수정 시 파일을 넣었을 때
			if (crewRequest.getCrewPhoto() != null && !crewRequest.getCrewPhoto().isEmpty()) {
				
				//// 기존 파일을 선택해서 삭제
				Crew crew = dao.selectCrew(crewIdx);
				s3.fileDelete(crew.getCrewPhoto());
				
				//// 새로운 파일 저장
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
				
				// DB에 업데이트
				resultCnt = dao.updateCrew(crewRequest.getCrewName(), photoFileName,
						crewRequest.getCrewDiscription(), crewRequest.getCrewTag(), crewIdx);
			} else {
				// 크루 수정 시 파일을 넣지 않았을 때
				resultCnt = dao.updateCrewWithoutPhoto(crewRequest.getCrewName(), crewRequest.getCrewDiscription(),
						crewRequest.getCrewTag(), crewIdx);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultCnt;
	}

	// 크루 삭제
	public int deleteCrew(int crewIdx, String crewName) {
		S3Util s3 = new S3Util();
		int resultCnt = 0;
		dao = template.getMapper(CrewMapper.class);
		Crew crew = selectCrew(crewIdx);

		// 크루이름이 일치할 때 삭제
		if (crew.getCrewName().equals(crewName)) {
			s3.fileDelete(crew.getCrewPhoto());
			resultCnt = dao.deleteCrew(crewIdx);
		}
		return resultCnt;
	}
}
