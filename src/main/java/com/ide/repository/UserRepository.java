package com.ide.repository;

import com.ide.model.User;

import javax.persistence.*;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

@Repository
public class UserRepository {

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(User user) {
        em.persist(user);
    }

    public User findByUsername(String username) {
        try {
            return em.createQuery("FROM User WHERE username=:u", User.class)
                    .setParameter("u", username)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    public User findByEmail(String email) {
        try {
            return em.createQuery("FROM User WHERE email=:u", User.class)
                    .setParameter("u", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
