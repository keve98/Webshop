package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.User;
import com.example.WebShopServer.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository r){ userRepository = r;}

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }


}
