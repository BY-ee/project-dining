package com.project.config;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.domain.Member;
import com.project.dto.CustomUserDetails;

@ControllerAdvice
public class GlobalModelAttributeAdvice {
    @ModelAttribute("sessionMember")
    public Member addSessionMember(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() 
                && authentication.getPrincipal() instanceof CustomUserDetails userDetails) {
            return userDetails.getMember();
        }
        
        Member anonymousMember = new Member();
        anonymousMember.setMemberId("anonymousUser");
        anonymousMember.setRole("ROLE_ANONYMOUS");
        return anonymousMember;
    }
}
