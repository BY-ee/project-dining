package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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
    
    @Autowired
    private PasswordEncoder passwordEncoder;

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
    public String register(@ModelAttribute LoginDomain user, Model model, HttpSession session) {
        Boolean isVerified = (Boolean) session.getAttribute("isVerified");

        if (isVerified == null || !isVerified) {
            model.addAttribute("error", "회원가입을 위해 이메일 인증이 필요합니다.");
            return "login/signup";  // 이메일 인증 필요 메시지와 함께 회원가입 페이지로 리다이렉트
        }

        try {
            loginService.insertUser(user);  // 회원 정보를 DB에 저장
            model.addAttribute("message", "회원가입이 성공적으로 완료되었습니다.");
            session.removeAttribute("isVerified"); // 회원가입 후 인증 상태 제거
            return "login/loginForm";  // 회원가입 성공 페이지로 이동
        } catch (Exception e) {
            e.printStackTrace();  // 예외 메시지 출력
            model.addAttribute("error", "회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.");
            return "login/signup";  // 회원가입 실패 시 다시 회원가입 페이지로 이동
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
            return "인증 코드가 만료되었거나 존재하지 않습니다.";
        }

        if (savedEmail.equals(email) && savedCode.equals(code)) {
            session.setAttribute("isVerified", true);  // 인증 성공 상태 저장
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
        
        // 디버깅용 로그 출력
        System.out.println("입력한 아이디: " + login.getMember_id());
        System.out.println("입력한 비밀번호: " + login.getPasswd());

        // 입력한 아이디의 특정 유저 정보를 조회해서 db 객체에 저장
        LoginDomain db = loginService.getUser(login.getMember_id());

        if (db != null) {
            System.out.println("DB에서 조회한 암호화된 비밀번호: " + db.getPasswd());
        }

        int result = 0;

        // 아이디 존재 여부 확인 (null error 방지)
        if (db == null) {
            // 아이디가 존재하지 않는 경우
            result = -1;
        } else {
            // 아이디가 존재하면 비밀번호 비교
            if (passwordEncoder.matches(login.getPasswd(), db.getPasswd())) {
                result = 1;  // 로그인 성공
                session.setAttribute("loginUser", db);
                session.setAttribute("user_ID", db.getId());  // user_ID 세션에 저장    
                session.setAttribute("user_nickname", db.getNickname());  // user_nickname 세션에 저장    

            } else {
                result = -1;  // 비밀번호 불일치
            }
        }

        System.out.println("로그인 결과: " + result);

        model.addAttribute("result", result);
        model.addAttribute("login", login);
        
        return "login/loginResult";
    }
}