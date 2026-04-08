package com.ide.service.execution;
import javax.websocket.Session;
public interface CodeExecutor {
    void execute(String code, Session session) throws Exception;
}