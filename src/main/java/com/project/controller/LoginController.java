package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.LoginDomain;
import com.project.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final LoginService loginService;

    @RequestMapping("/loginForm.do")
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
    
    @RequestMapping("home.do")
    public String home() {
        return "home/home-category";
    }
    
    @RequestMapping("findPwd.do")
    public String findPwd() {
        return "login/findPwd";
    }
    
    // 회원가입 - 일반 사용자 및 사업자 등록 사용자
    @PostMapping("/register")
    public String register(@ModelAttribute LoginDomain user, Model model) {
        try {
            if (loginService.isMemberIdExists(user.getMember_id())) {
                model.addAttribute("error", "이미 존재하는 아이디입니다.");
                return "login/signUp.do";  // 회원가입 페이지로 다시 리턴
            }
            loginService.insertUser(user);  // 회원 정보를 DB에 저장
            model.addAttribute("message", "회원가입이 성공적으로 완료되었습니다.");
            return "login/loginForm";  // 회원가입 성공 페이지로 리다이렉트
        } catch (Exception e) {
            model.addAttribute("error", "회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.");
            return "login/signUp.do";  // 회원가입 페이지로 다시 리턴
        }
    }
    

    // 회원가입 - 이메일 인증
    @PostMapping("sendVerificationEmail.do")
    @ResponseBody
    public String sendVerificationEmail(@RequestParam("email") String email, HttpSession session) {
        // 인증 코드 생성
        String verificationCode = loginService.generateVerificationCode();

        // 세션에 인증 코드 저장
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("email", email);

        // 이메일 전송
        loginService.sendVerificationEmail(email, verificationCode);

        return "인증 코드가 이메일로 전송되었습니다.";
    }
    
    @PostMapping("/verifyCode.do")
    @ResponseBody
    public String verifyCode(@RequestParam("email") String email, @RequestParam("code") String code, HttpSession session) {
        String savedCode = (String) session.getAttribute("verificationCode");
        String savedEmail = (String) session.getAttribute("email");

        if (savedCode == null || savedEmail == null) {
            System.out.println(savedCode);
            System.out.println(savedEmail);
            return "인증 코드가 만료되었거나 존재하지 않습니다.";
        }

        if (savedEmail.equals(email) && savedCode.equals(code)) {
            session.removeAttribute("verificationCode"); // 인증 후 세션에서 코드 제거
            session.removeAttribute("email");
            return "인증에 성공했습니다.";
        } else {
            return "인증 코드가 올바르지 않습니다.";
        }
    }
    
    // 로그인
    @RequestMapping("login_ok.do")
    public String login_ok(@ModelAttribute LoginDomain login,
                           HttpSession session,
                           Model model) {
        
        // 입력한 아이디의 특정 유저 정보를 조회해서 db 객체에 저장
        LoginDomain db = loginService.getUser(login.getMember_id());
        
        int result = 0;

        // 아이디 존재 여부 확인 (null error 방지)
        if (db == null) {
            // 아이디가 존재하지 않는 경우
            result = -1;
        } else {
            // 아이디가 존재하면 비밀번호 비교
            if (db.getPasswd().equals(login.getPasswd())) {
                result = 1;  // 로그인 성공
                session.setAttribute("loginUser", db);
                session.setAttribute("user_ID", db.getId());  // user_ID 세션에 저장    
                session.setAttribute("user_nickname", db.getNickname());  // user_nickname 세션에 저장    

            } else {
                result = -1;  // 비밀번호 불일치
            }
        }
    
        model.addAttribute("result", result);
        model.addAttribute("login", login);
        
        return "login/loginResult";
    }
}