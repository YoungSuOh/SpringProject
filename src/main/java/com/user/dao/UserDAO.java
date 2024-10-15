package com.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.user.bean.UserDTO;


@Mapper
public interface UserDAO {
	public UserDTO getExistId(String id);
	public void write(UserDTO userDTO);
	public List<UserDTO> getUserList(Map<String,Integer>map);
	public void delete(String id);
	public int getTotalUserCount();
	public void update(UserDTO userDTO);
	public UserDTO getExistPwd(String id);
}
