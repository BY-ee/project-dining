package com.project.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.domain.LoginDomain;
import com.project.security.Api;
import com.project.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginController {

	private final LoginService loginService;
    
	private final Api api;
	
	@RequestMapping("loginForm.do")
	public String loginForm() {
		return "login/loginForm";
	}
	
	@RequestMapping("signUp.do")
	public String signUp() {
		return "login/signup";
	}
	
    @PostMapping("/register")
    public ModelAndView registerUser(@RequestParam("userid") String userid,  
                                     @RequestParam("nickname") String nickname,
                                     @RequestParam("userpwd") String password,
                                     @RequestParam("email") String email,
                                     @RequestParam("emailDomain") String emailDomain) {
        String fullEmail = email + "@" + emailDomain;

        LoginDomain user = new LoginDomain();
        user.setUserid(userid); // userid 설정
        user.setNickname(nickname);
        user.setUserpwd(password);
        user.setEmail(fullEmail);

        loginService.registerUser(user); // 인스턴스를 통해 호출

        return new ModelAndView("redirect:/loginForm.do");
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
	public String naverCallback(@RequestParam String code,
								@RequestParam String state,
							 
								HttpSession session) throws UnsupportedEncodingException {
		
		
        String clientId = api.getNaverLoginClientKey();
        String clientSecret = api.getNaverLoginSecret();
        
        String naverRedirectURI = URLEncoder.encode("http://www.localhost/naverCallback.do", "UTF-8");
        
        String naverApiUrl;
        
        naverApiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
        naverApiUrl += "client_id=" + clientId;
        naverApiUrl += "&client_secret=" + clientSecret;
        naverApiUrl += "&redirect_uri=" + naverRedirectURI;
        naverApiUrl += "&code=" + code;
        naverApiUrl += "&state=" + state;

        String naverAccessToken = "";
        String naverRefreshToken = "";
        
		try {
			  URL url = new URL(naverApiUrl);
			  // con 객체가 서버로부터의 응답을 저장
			  HttpURLConnection con = (HttpURLConnection)url.openConnection();
		      con.setRequestMethod("GET");
		      int responseCode = con.getResponseCode();
		      System.out.print("responseCode="+responseCode);	
			
		      BufferedReader br;
		      
		      if(responseCode == 200 ) {
		    	  br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		      }else {  // 에러 발생
		          br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		      }
		      String inputLine;
		      StringBuffer res = new StringBuffer();
		      while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		      }
		      br.close();
		      
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
	            session.setAttribute("user_ID", db.getId());  // user_ID 세션에 저장	
	            session.setAttribute("nickname", db.getNickname());  // user_ID 세션에 저장	

	        } else {
	            result = -1;  // 비밀번호 불일치
	        }
	    }
	
		model.addAttribute("result", result);
		model.addAttribute("login", login);
		
		return "login/loginResult";
	}
	
	
}
