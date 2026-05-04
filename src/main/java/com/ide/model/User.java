package com.ide.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Getter @Setter
    @Column(unique = true, nullable = false)
    private String email;

    @Getter @Setter
    @Column(unique = true, nullable = false)
    private String username;

    @Getter @Setter
    private String password;

}
