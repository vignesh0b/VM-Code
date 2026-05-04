package com.ide.repository;

import com.ide.model.CodeHistory;
import com.ide.model.User;

import javax.persistence.*;
import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class CodeHistoryRepository {

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(CodeHistory history) {
        em.persist(history);
    }

    @Transactional(readOnly = true)
    public List<CodeHistory> findByUser(User user) {
        return em.createQuery(
                        "SELECT c FROM CodeHistory c WHERE c.user = :u ORDER BY c.createdAt DESC",
                        CodeHistory.class)
                .setParameter("u", user)
                .getResultList();
    }
}