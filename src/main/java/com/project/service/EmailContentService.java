package com.project.service;

public interface EmailContentService {
    String generateVerificationCode();
    String generateEmailConfirmContent(String verificationCode);
    String generatePasswordResetContent(String resetLink);
}
