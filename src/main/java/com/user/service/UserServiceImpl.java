package com.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.user.bean.UserDTO;
import com.user.bean.UserPaging;
import com.user.dao.UserDAO;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private UserPaging userPaging;
	@Override
	public String getExistId(String id) {
		UserDTO userDTO = userDAO.getExistId(id);
		if(userDTO==null) {
			return "noneExist";
		}
		else {
			return "exist";
		}
	}
	@Override
	public void write(UserDTO userDTO) {
		userDAO.write(userDTO);		
	}
	@Override
	public Map<String,Object> list(String pg) {
		// 1페이지당 5개씩
		int startNum = (Integer.parseInt(pg)-1)*5;
		int endNum = 5;  // 시작 위치(mySQL은 0부터 시작)
		
		Map<String,Integer>map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		List<UserDTO>list = userDAO.getUserList(map);
		
		// 페이징 처리
		int totalA = userDAO.getTotalUserCount(); // 총 페이지 수
		userPaging.setCurrentPage(Integer.parseInt(pg));
		userPaging.setPageSize(5);
		userPaging.setPageBlock(3);
		userPaging.setTotalA(totalA);
		userPaging.makePagingHTML();
		
		Map<String,Object>map2 = new HashMap<>();
		map2.put("list", list);
		map2.put("userPaging", userPaging);
		
		return map2;
	}
	@Override
	public void update(UserDTO userDTO) {
		userDAO.update(userDTO);		
	}
	@Override
	public UserDTO getExistPwd(String id) {
		return userDAO.getExistPwd(id);
	}
	@Override
	public void delete(String id) {
		userDAO.delete(id);		
	}
}

/*
pg=1					startNum	endNum
0	사과					0			4
1	딸기											 
2	바나나
3	옥수수
4	수박 

5	사과					5			9
6	딸기											 
7	바나나
8	옥수수
9	수박 
 

 
 
*/
