package com.project.disable;

@Deprecated
public class UserDomain {
    private String username;
    private String email;
    private String password;

    // 기본 생성자
    public UserDomain() {}

    // Getter와 Setter
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}