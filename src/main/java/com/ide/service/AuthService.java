package com.ide.service;

import com.ide.model.User;
import com.ide.repository.UserRepository;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserRepository repo;

    public String register(String email, String username, String password) {
        if (repo.findByUsername(username) != null || repo.findByEmail(email)!=null) {
            return "Username or email already exists";
        }

        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());

        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(hashed);

        repo.save(user);
        return "Registered successfully";
    }

    public User login(@NotNull String inputId, String password) {
        User user;

        if(inputId.contains("@")){
            user = repo.findByEmail(inputId);
        }
        else{
            user = repo.findByUsername(inputId);
        }


        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }

        return null;
    }
}
