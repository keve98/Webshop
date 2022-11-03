package com.example.WebShopServer.Services;

import com.example.WebShopServer.Models.User;
import com.example.WebShopServer.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository r,
                       BCryptPasswordEncoder bCryptPasswordEncoder){
        userRepository = r;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Autowired
    private JavaMailSender mailSender;

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public Optional<User> getUserById(Long id){
        return userRepository.findById(id);
    }
    public void saveUser(User user){
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
    }

    public boolean login(String username, String password){
        User user = userRepository.findByName(username);
        if(bCryptPasswordEncoder.matches(password, user.getPassword())) {
            return true;
        }else{
            return false;
        }
    }

    public User getEntity(String name){
        return userRepository.findByName(name);
    }

    public void sendVerificationEmail(User user) throws MessagingException, UnsupportedEncodingException {
        String toAddress = user.getEmail();
        String fromAddress = "webshopapp07@gmail.com";
        String senderName = "Webshop";
        String subject = "Verification code";


        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(fromAddress, senderName);
        helper.setTo(toAddress);
        helper.setSubject(subject);


        String verifyURL = "http://localhost:8080/" + "verify/" + user.getVerificatonCode();

        String content = "Dear "+user.getName()+",<br><br>"
                + "Please click the link below to verify your registration:<br>"
                +"<a href=\""+verifyURL+"\">Verify now</a>"
                + "<br><br>Thank you,<br>"
                + "Webshop Team";


        helper.setText(content, true);

        mailSender.send(message);
    }

    public void verify(String code){
        userRepository.verify(code);
    }

    public User findByCode(String code){
        return userRepository.findByCode(code);
    }

}
