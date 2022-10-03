package com.example.WebShopServer.Controllers;


import com.example.WebShopServer.Models.User;
import com.example.WebShopServer.Services.UserService;
import net.bytebuddy.utility.RandomString;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {

    UserService userService;

    public UserController(UserService u){ userService = u;}

    @GetMapping("/users")
    public ResponseEntity<List<User>> getUsers(){
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @PostMapping(value = "/save")
    public ResponseEntity<User> saveUser(@RequestBody User newData) throws Exception{
        System.out.println(newData.toString());

        String username = newData.getUsername();
        String password = newData.getPassword();

        User userObj = null;

        if(username != null && password != null){
            userObj = userService.getEntity(username);
        }

        if(userObj != null){
            throw new Exception("User with name '" + username +"' already exists!");
        }

        User newUserEntity = new User(newData.getName(), newData.getUsername(), newData.getAddress(), newData.getEmail(),
                newData.getPassword());

        System.out.println(newUserEntity.toString());

        String randomCode = RandomString.make(64);
        newUserEntity.setVerificatonCode(randomCode);
        newUserEntity.setEnabled(false);

        userService.saveUser(newUserEntity);


        userService.sendVerificationEmail(newUserEntity);

        return new ResponseEntity<>(newUserEntity, HttpStatus.OK);

    }

    @GetMapping("/verify/{code}")
    public ResponseEntity<User> verify(@PathVariable String code) throws Exception {
        userService.verify(code);
        User temp = userService.findByCode(code);
        if(temp == null){
            throw new Exception("Invalid verification code");
        }
        if(!temp.isEnabled()){
            throw new Exception("Verification is failed, try an other one.");
        }
        return new ResponseEntity<>(temp, HttpStatus.OK);
    }

    @PostMapping(value = "/login")
    public ResponseEntity<User> login(@RequestBody User user) throws Exception{
        if(!userService.login(user.getUsername(), user.getPassword())){
            throw new Exception("Bad credentials");
        }

        User loggedInUser = userService.getEntity(user.getUsername());

        if(!loggedInUser.isEnabled()){
            throw new Exception("Your account is not verified yet. Please check your emails.");
        }

        System.out.println("Login success");

        return new ResponseEntity<>(loggedInUser, HttpStatus.OK);


    }
}
