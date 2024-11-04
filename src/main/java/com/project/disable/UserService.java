package com.project.disable;

import com.project.disable.UserMapper;
import com.project.disable.UserDomain;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
@Deprecated
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void registerUser(UserDomain user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        logger.info("회원가입 성공: {}", user.getEmail()); // 회원가입 성공 시 로그
        userMapper.insertUser(user);
    }

    public String loginUser(String email, String rawPassword) {
    	UserDomain user = userMapper.findUserByEmail(email);

        if (user == null) {
            logger.error("이메일로 사용자를 찾을 수 없음: {}", email);
            return "emailNotFound";
        }

        boolean isMatch = passwordEncoder.matches(rawPassword, user.getPassword());
        logger.debug("비밀번호 매칭 결과: {}", isMatch);

        if (!isMatch) {
            logger.error("비밀번호가 일치하지 않음: {}", rawPassword);
            return "passwordIncorrect";
        }

        logger.info("로그인 성공: {}", email);
        return "success";
    }
}