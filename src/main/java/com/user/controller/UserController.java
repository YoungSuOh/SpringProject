package com.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.user.bean.UserDTO;
import com.user.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/writeForm", method = RequestMethod.GET)
	public String writeForm() {
		return "/user/writeForm";
	}

	@RequestMapping(value = "/getExistId", method = RequestMethod.POST)
	@ResponseBody // 다시 dispatcher를 통해 나가기 방지
	public String getExistId(String id) {
		return userService.getExistId(id); // 단순 문자열이 아니라 jsp파일명으로 인식
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	@ResponseBody
	public void write(@ModelAttribute UserDTO userDTO) {
		userService.write(userDTO);
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(@RequestParam(required = false, defaultValue = "1") String pg, Model model) {
		Map<String, Object> list = userService.list(pg);

		list.put("pg", pg);
		model.addAttribute("list", list);
		return "/user/list";
	}

	@RequestMapping(value = "/updateForm", method = RequestMethod.GET)
	public String updateForm(@RequestParam String pg, @RequestParam String id, Model model) {
		model.addAttribute("pg", pg);
		model.addAttribute("id", id);
		return "/user/updateForm";
	}

	@RequestMapping(value="/update", method=RequestMethod.POST, produces="application/json")
	@ResponseBody
	public void update(@ModelAttribute UserDTO userDTO) {
	    userService.update(userDTO);   
	    
	}
	@RequestMapping(value = "/deleteForm", method = RequestMethod.GET)
	public ModelAndView deleteForm(@RequestParam String id) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("id",id);
		mav.setViewName("/user/deleteForm");
		
		return mav;
	}
	@RequestMapping(value = "/getExistPwd", method = RequestMethod.POST)
	@ResponseBody
	public UserDTO getExistPwd(@RequestParam String id) {
		//  스프링은 객체를 자동으로 JSON으로 변경해준다.
		return userService.getExistPwd(id);
	}
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(@RequestParam String id) {
		//  스프링은 객체를 자동으로 JSON으로 변경해준다.
		userService.delete(id);
	}

}
/*
 * DispatchServlet은 handlerMethod()를 호출하여 응답으로 String, ModelAndView, Object 중
 * 하나를 반환한다. String이 반환되면 뷰 이름을 찾아서 JSP를 렌더링 하고, 뷰가 없으면 404를 반환한다 그런데 메서드
 * 위에 @ResponseBody 어노테이션이 있다면 뷰를 찾지 않고, String을 그대로 반환한다. DispatcherServlet이
 * ModelAndView를 반환하면 ViewResolver가 실행된다. 그런데 @ResponseBody가 있으면 Object는
 * MessageConverter가 실행되어 반환된다.
 */