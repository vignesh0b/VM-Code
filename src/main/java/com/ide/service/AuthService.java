package com.ide.service;

import com.ide.model.User;
import com.ide.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserRepository repo;

    public String register(String username, String password) {
        if (repo.findByUsername(username) != null) {
            return "User already exists";
        }

        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());

        User user = new User();
        user.setUsername(username);
        user.setPassword(hashed);
        repo.save(user);
        return "Registered successfully";
    }
    public User login(String username, String password) {
        User user = repo.findByUsername(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }
}