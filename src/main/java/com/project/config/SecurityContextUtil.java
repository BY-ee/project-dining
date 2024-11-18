package com.project.config;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.project.service.CustomUserDetailsService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class SecurityContextUtil {

    private final CustomUserDetailsService customUserDetailsService;

    public void reloadUserDetails(String username) {
        UserDetails updatedUserDetails = customUserDetailsService.loadUserByUsername(username);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
            updatedUserDetails,
            authentication.getCredentials(),
            updatedUserDetails.getAuthorities()
        );

        SecurityContextHolder.getContext().setAuthentication(newAuthentication);
    }
}
