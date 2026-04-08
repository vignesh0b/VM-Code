package com.ide.service.execution;

import javax.websocket.Session;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySQLExecutor implements CodeExecutor {

    private static final String URL = "jdbc:mysql://localhost:3306/vmsqlcode";
    private static final String USER = "root";
    private static final String PASSWORD = "Mathan@2005";

    @Override
    public void execute(String code, Session session) {

        StringBuilder output = new StringBuilder();

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement()) {

            String[] queries = code.split(";\\s*");
            for (String q : queries) {

                String query = q.trim();
                if (query.isEmpty()) continue;

                try {
                    boolean hasResult = stmt.execute(query);

                    if (hasResult) {
                        ResultSet rs = stmt.getResultSet();
                        ResultSetMetaData meta = rs.getMetaData();
                        int cols = meta.getColumnCount();
                        
                        List<String> headers = new ArrayList<>();
                        for (int i = 1; i <= cols; i++) {
                            headers.add(meta.getColumnLabel(i));
                        }
                        
                        List<List<String>> rows = new ArrayList<>();
                        while (rs.next()) {
                            List<String> row = new ArrayList<>();
                            for (int i = 1; i <= cols; i++) {
                                String val = rs.getString(i);
                                row.add(val == null ? "NULL" : val);
                            }
                            rows.add(row);
                        }
                        
                        int[] colWidths = new int[cols];
                        for (int i = 0; i < cols; i++) {
                            colWidths[i] = headers.get(i).length();
                            for (List<String> row : rows) {
                                if (row.get(i).length() > colWidths[i]) {
                                    colWidths[i] = row.get(i).length();
                                }
                            }
                        }
                        
                        StringBuilder separator = new StringBuilder("+");
                        for (int w : colWidths) {
                            for (int j = 0; j < w + 2; j++) separator.append("-");
                            separator.append("+");
                        }
                        separator.append("\n");
                        
                        output.append(separator);
                        output.append("|");
                        for (int i = 0; i < cols; i++) {
                            output.append(String.format(" %-" + colWidths[i] + "s |", headers.get(i)));
                        }
                        output.append("\n");
                        output.append(separator);
                        
                        for (List<String> row : rows) {
                            output.append("|");
                            for (int i = 0; i < cols; i++) {
                                output.append(String.format(" %-" + colWidths[i] + "s |", row.get(i)));
                            }
                            output.append("\n");
                        }
                        
                        if (!rows.isEmpty()) {
                            output.append(separator);
                        }
                        output.append("\n");
                    }
                } catch (Exception ex) {
                    output.append("ERROR: ").append(ex.getMessage()).append("\n\n");
                }
            }
        } catch (Exception e) {
            output.append("Connection Error: ").append(e.getMessage()).append("\n");
        }
        try {
            session.getBasicRemote().sendText(output.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}