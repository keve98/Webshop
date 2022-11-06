package com.example.WebShopServer.Repositories;


import com.example.WebShopServer.Models.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Long> {

    @Query(value = "select u from User u order by u.Id")
    List<User> findAll();

    @Query(value = "select m from User m where m.username like :#{#txt}")
    User findByName(@Param("txt") String txt);

    @Query(value = "select m from User m where m.Id = :userid")
    User findUserById(@Param("userid") Long id);

    @Transactional
    @Modifying
    @Query(value = "update User m set m.IsEnabled = 1 where m.VerificationCode like :#{#code}")
    void verify(@Param("code") String code);

    @Query(value = "select m from User m where m.VerificationCode like :#{#code}")
    User findByCode(@Param("code") String code);

}
