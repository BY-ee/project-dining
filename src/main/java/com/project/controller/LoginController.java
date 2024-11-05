package com.project.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.domain.LoginDomain;
import com.project.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginController {

	private final LoginService loginService;
 
	@RequestMapping("loginForm.do")
	public String loginForm() {
		return "login/loginForm";
	}
	
	@RequestMapping("signUp.do")
	public String signUp() {
		return "login/signup";
	}
	
	@RequestMapping("memberForm.do")
	public String signForm() {
		return "login/memberForm";
	}
	
	@RequestMapping("ownerForm.do")
	public String onwerForm() {
		return "login/ownerForm";
	}
	
//	@RequestMapping("home.do")
//	public String home() {
//		return "loginSignUp/home";
//	}
	
	@RequestMapping("findPwd.do")
	public String findPwd() {
		return "login/findPwd";
	}
	
	@RequestMapping("naverCallback.do")
	public String naverCallback(@RequestParam("code") String code,
								@RequestParam("state") String state,
								@ModelAttribute LoginDomain login,
								HttpSession session,
								Model model) throws UnsupportedEncodingException {
		
		
        String clientId = "pyNA4GhE0bkNcyJChkCA";
        String clientSecret = "DisiKqnB7E";
        
        String naverRedirectURI = URLEncoder.encode("http://www.localhost/naverCallback.do", "UTF-8");
        
        String naverApiUrl;
        
        naverApiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
        naverApiUrl += "client_id=" + clientId;
        naverApiUrl += "&client_secret=" + clientSecret;
        naverApiUrl += "&redirect_uri=" + naverRedirectURI;
        naverApiUrl += "&code=" + code;
        naverApiUrl += "&state=" + state;
        
		try {
			  URL url = new URL(naverApiUrl);
			  // con 객체가 서버로부터의 응답을 저장
			  HttpURLConnection con = (HttpURLConnection)url.openConnection();
		      con.setRequestMethod("GET");
		      int responseCode = con.getResponseCode();
		      BufferedReader br;
		      
		      if(responseCode==200) { // 정상 호출
		          br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		        } else {  // 에러 발생
		          br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		        }
		      String inputLine;
		      StringBuffer naverInfo = new StringBuffer();
		      while ((inputLine = br.readLine()) != null) {
		    	  naverInfo.append(inputLine);
		      }
		      
		      br.close();

		      // naverInfo : access Token 정보를 가짐

		     
		      ObjectMapper omNaverInfo = new ObjectMapper();
		      JsonNode jnNaverInfo = omNaverInfo.readTree(naverInfo.toString());
		      
		      String accessToken = jnNaverInfo.get("access_token").asText();
		      
		      //DTO에 accessToken저장
		      login.setAccessToken(accessToken);
		      
		      String header = "Bearer " + accessToken;
		      
		      String naverInfoApiUrl = "https://openapi.naver.com/v1/nid/me";
		      

		      Map<String, String> naverHeader = new HashMap<>();
		      naverHeader.put("Authorization", header);
		      String naverRB = loginService.get(naverInfoApiUrl,naverHeader);
		        
		      System.out.println(naverRB);
		      
		}catch(Exception e){
				e.printStackTrace();
		}
 
		

		return "naverCallback";  
	

	}
	



	
	
	
	
	
	
	// 로그인
	@RequestMapping("login_ok.do")
	public String login_ok(@ModelAttribute LoginDomain login,
						   HttpSession session,
						   Model model) {
		
		//입력한 아이디의 특정 유저 정보를 조회해서 db 객체에 저장
		LoginDomain db = loginService.getUser(login.getUserid());
		
		int result = 0;

		
		 // 아이디 존재 여부 확인 (null error 방지)
		if (db == null) {
	        // 아이디가 존재하지 않는 경우
	        result = -1;
	    } else {
	        // 아이디가 존재하면 비밀번호 비교
	        if (db.getUserpwd().equals(login.getUserpwd())) {
	            result = 1;  // 로그인 성공
	            session.setAttribute("loginUser", db);
	        } else {
	            result = -1;  // 비밀번호 불일치
	        }
	    }
	
		model.addAttribute("result", result);
		model.addAttribute("login", login);
		
		return "login/loginResult";
	}
	
	
}
