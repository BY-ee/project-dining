package com.project.controller;

import java.sql.Timestamp;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.project.domain.Point;
import com.project.dto.Login;
import com.project.mapper.PointMapper;
import com.project.service.LoginService;
import com.project.service.PointService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginController {

	private final LoginService loginService;
	private final OAuth2AuthorizedClientService authorizedClientService;
	private final PointService pointService;
	
	// 로그인 페이지
	@GetMapping("/login")
	public String loginForm() {
		return "login/loginForm";
	}

	// 회원가입 페이지
	@GetMapping("/signup")
	public String signup() {
		return "login/signup";
	}

	// 일반 회원가입
	@GetMapping("/memberForm")
	public String signForm() {
		return "login/memberForm";
	}

	// 사업자 회원가입
	@GetMapping("/ownerForm")
	public String onwerForm() {
		return "login/ownerForm";
	}

	// 아이디 찾기
	@GetMapping("/findId")
	public String findId() {
		return "login/findId";
	}

	// 비밀번호 찾기
	@GetMapping("/findPwd")
	public String findPwd() {
		return "login/findPwd";
	}

	// 아이디 중복검사
	@PostMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<Integer> idCheck(@RequestParam("memberId") String memberId) {
		int result = loginService.isUserIdCheck(memberId);
		return ResponseEntity.ok(result);
	}

	// 닉네임 중복검사
	@PostMapping("/nicknameCheck")
	@ResponseBody
	public ResponseEntity<Integer> nicknaCheck(@RequestParam("nickname") String nickname) {
		int result = loginService.isUserNicknameCheck(nickname);
		return ResponseEntity.ok(result);
	}

	// 회원가입
	@PostMapping("/joinMember")
	public String joinMember(@ModelAttribute("Login") Login login, Model model) {
		int result = 0;
		result = loginService.joinMember(login);
		
		Login db = loginService.getUser(login.getMemberId());
		
		Point newPoint = Point.insertPoint(db.getId(), "회원가입", 500L, "지급", "active");
		pointService.insertPoint(newPoint);
        
		model.addAttribute("result", result);

		return "login/joinResult";
	}
	
	@GetMapping("/logincheck.do")
	public String loginCheck(Authentication authentication, HttpSession session) {
	    if (!(authentication instanceof OAuth2AuthenticationToken)) {
	        return "redirect:/login_ok.do";
	    }

	    OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
	    String registrationId = oauthToken.getAuthorizedClientRegistrationId();

	    // accessToken 가져오기
	    OAuth2AuthorizedClient authorizedClient = authorizedClientService
	            .loadAuthorizedClient(registrationId, oauthToken.getName());
	    String accessToken = authorizedClient.getAccessToken().getTokenValue();

	    // accessToken을 사용해 사용자 정보 가져오기
	    Map<String, Object> userInfo = fetchUserInfo(registrationId, accessToken);

	    Login db = null;
	    Point newPoint = new Point();
	    switch (registrationId) {
	        case "naver":
	            Map<String, Object> naverResponse = (Map<String, Object>) userInfo.get("response");
	            if (naverResponse != null) {
	                String tempId = (String) naverResponse.get("id");
	                db = loginService.getNaverUser(tempId);
	            }
	            break;

	        case "kakao":
	            String tempId = String.valueOf(userInfo.get("id"));
	            db = loginService.getKakaoUser(tempId);
	            break;

	        case "google":
	            tempId = (String) userInfo.get("sub");
	            db = loginService.getGoogleUser(tempId); 
	            break;

	        default:
	            return "redirect:/login";
	    }
	    
	    if (db != null) {
	        // 세션에 사용자 정보 저장
	        session.setAttribute("loginUser", db);
	        session.setAttribute("user_ID", db.getId());
	        session.setAttribute("user_nickname", db.getNickname());
	    }

	    return "redirect:/";
	}

	private Map<String, Object> fetchUserInfo(String registrationId, String accessToken) {
	    String userInfoEndpoint;
	    switch (registrationId) {
	        case "naver":
	            userInfoEndpoint = "https://openapi.naver.com/v1/nid/me";
	            break;
	        case "kakao":
	            userInfoEndpoint = "https://kapi.kakao.com/v2/user/me";
	            break;
	        case "google":
	            userInfoEndpoint = "https://www.googleapis.com/oauth2/v3/userinfo";
	            break;
	        default:
	            return null;
	    }

	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Authorization", "Bearer " + accessToken);
	    HttpEntity<String> entity = new HttpEntity<>("", headers);

	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<Map> response = restTemplate.exchange(userInfoEndpoint, HttpMethod.GET, entity, Map.class);
	    return response.getBody();
	}

	// 비밀번호 재설정 링크
	@GetMapping("/reset-password")
	public String resetPassword(@RequestParam("token") String token, @RequestParam("memberId") String memberId,
			HttpSession session) {
		String sessionToken = (String) session.getAttribute("passwordResetToken");
		String sessionMemberId = (String) session.getAttribute("memberId");

		if (sessionToken != null && sessionToken.equals(token) && sessionMemberId.equals(memberId)) {
			// 토큰과 아이디가 일치하는 경우 비밀번호 재설정 페이지로 이동
			return "login/pwdReset"; // 비밀번호 재설정 페이지로 이동
		} else {
			// 유효하지 않은 토큰
			return "login/pwdResetFail";
		}
	}

	// 비밀번호 재설정
	@PostMapping("/updatePassword")
	@ResponseBody // AJAX 요청에 응답을 문자열로 반환
	public String updatePassword(@ModelAttribute("Login") Login login,  HttpSession session) {
		
		String sessionToken = (String) session.getAttribute("passwordResetToken");
		String sessionMemberId = (String) session.getAttribute("memberId");
		  
		loginService.updatePassword(login);
		
		session.removeAttribute("passwordResetToken"); // 세션에서 토큰 삭제
	    session.removeAttribute("memberId"); // 세션에서 memberId 삭제
		return "비밀번호 재설정이 완료되었습니다.";
	}

	// 아이디 찾기
	@PostMapping("/showId")
	@ResponseBody // AJAX 요청에 응답을 문자열로 반환
	public String showId(@ModelAttribute("Login") Login login) {

		if (login.getEmail() == "@") {
			return "이메일을 입력해주세요.";
		}

		// 해당 이메일로 찾은 회원의 모든 정보 조회
		Login db = loginService.getFindId(login.getEmail());

		if (db == null) {
			return "해당 이메일 정보를 가진 회원이 존재하지 않습니다";
		}

		String memberId = db.getMemberId();
		if (memberId.contains("@")) {
		    return "간편 로그인 회원입니다.";
		}
		return "당신의 아이디는 < " + db.getMemberId() + " >입니다.";
	}

	


}