package com.project.controller;

//import com.project.mapper.UserMapper;
//import com.project.model.User;
//import com.project.service.UserService;

//import jakarta.servlet.http.HttpSession;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*; // 수정: RequestParam, GetMapping, PostMapping 등을 위해 추가

@Controller
public class HomeController {

//    @Autowired
//    private UserService userService;
//    
//    @Autowired
//    private UserMapper userMapper;


    @GetMapping("/")
    public String home() {
        return "home/home-category";
    }

//    @GetMapping("/signup")
//    public String signupPage() {
//        return "signup";
//    }
    

//    @PostMapping("/signup")
//    public String signup(User user) {
//        userService.registerUser(user);
//        return "redirect:/login";
//    }

//    @GetMapping("/login")
//    public String loginPage() {
//        return "login";
//    }

    @GetMapping("/csr")
    public String csr() {
    	return "home/csr";
    }
    
//    @GetMapping("/mypage")
//    public String mypage() {
//    	return "mypage";
//    }
    
    @GetMapping("/terms")
    public String terms() {
    	return "home/terms";
    }
    
    @GetMapping("/emailInquery")
    public String emailInquery() {
    	return "home/emailInquery";
    }
    
    @GetMapping("/storeRegistration")
    public String storeRegistration() {
    	return "home/storeRegistration";
    }
    
    @GetMapping("/myPage")
    public String myPage() {
    	return "user/myPage";
    }


//    @PostMapping("/login")
//    public String login(
//            @RequestParam("email") String email,
//            @RequestParam("password") String password,
//            Model model,
//            HttpSession session) {
//
//        String loginStatus = userService.loginUser(email, password);
//
//        if ("success".equals(loginStatus)) {
//            User user = userMapper.findUserByEmail(email);
//            session.setAttribute("username", user.getUsername());
//            System.out.println("[INFO] 로그인 성공: " + email);
//            return "home";
//        } else {
//            System.out.println("[ERROR] 로그인 실패 - " + (loginStatus.equals("emailNotFound") ? "이메일 없음" : "비밀번호 불일치"));
//            model.addAttribute("loginStatus", loginStatus);
//            return "login";
//        }
//    }
}