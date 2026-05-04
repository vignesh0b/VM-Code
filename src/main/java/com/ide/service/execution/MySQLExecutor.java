package com.ide.service.execution;

import javax.websocket.Session;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySQLExecutor implements CodeExecutor {

    private static final String URL = "jdbc:mysql://localhost:3306/vmsqlcode";
    private static final String USER = "root";
    private static final String PASSWORD = "Bounty69$";

    @Override
    public void execute(String code, Session session) {
        StringBuilder output = new StringBuilder();

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            List<String> queries = splitQueries(code);

            for (String query : queries) {
                try {
                    output.append(executeQuery(stmt, query));
                } catch (Exception ex) {
                    output.append(formatError(ex));
                }
            }

        } catch (Exception e) {
            output.append("Connection Error: ").append(e.getMessage()).append("\n");
        }

        sendResponse(session, output.toString());
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private List<String> splitQueries(String code) {
        List<String> queries = new ArrayList<>();
        String[] parts = code.split(";\\s*");

        for (String q : parts) {
            String trimmed = q.trim();
            if (!trimmed.isEmpty()) {
                queries.add(trimmed);
            }
        }
        return queries;
    }

    private String executeQuery(Statement stmt, String query) throws SQLException {
        StringBuilder output = new StringBuilder();

        boolean hasResult = stmt.execute(query);

        if (hasResult) {
            ResultSet rs = stmt.getResultSet();
            output.append(formatResultSet(rs));
        }

        return output.toString();
    }

    private String formatResultSet(ResultSet rs) throws SQLException {
        StringBuilder output = new StringBuilder();

        ResultSetMetaData meta = rs.getMetaData();
        int cols = meta.getColumnCount();

        List<String> headers = getHeaders(meta, cols);
        List<List<String>> rows = getRows(rs, cols);
        int[] colWidths = calculateColumnWidths(headers, rows, cols);

        String separator = buildSeparator(colWidths);

        output.append(separator);
        output.append(formatHeader(headers, colWidths));
        output.append(separator);
        output.append(formatRows(rows, colWidths));

        if (!rows.isEmpty()) {
            output.append(separator);
        }

        output.append("\n");
        return output.toString();
    }

    private List<String> getHeaders(ResultSetMetaData meta, int cols) throws SQLException {
        List<String> headers = new ArrayList<>();
        for (int i = 1; i <= cols; i++) {
            headers.add(meta.getColumnLabel(i));
        }
        return headers;
    }

    private List<List<String>> getRows(ResultSet rs, int cols) throws SQLException {
        List<List<String>> rows = new ArrayList<>();

        while (rs.next()) {
            List<String> row = new ArrayList<>();
            for (int i = 1; i <= cols; i++) {
                String val = rs.getString(i);
                row.add(val == null ? "NULL" : val);
            }
            rows.add(row);
        }
        return rows;
    }

    private int[] calculateColumnWidths(List<String> headers, List<List<String>> rows, int cols) {
        int[] widths = new int[cols];

        for (int i = 0; i < cols; i++) {
            widths[i] = headers.get(i).length();
            for (List<String> row : rows) {
                widths[i] = Math.max(widths[i], row.get(i).length());
            }
        }
        return widths;
    }


    private String buildSeparator(int[] widths) {
        StringBuilder separator = new StringBuilder("+");

        for (int w : widths) {
            for (int i = 0; i < w + 2; i++) separator.append("-");
            separator.append("+");
        }

        separator.append("\n");
        return separator.toString();
    }

    private String formatHeader(List<String> headers, int[] widths) {
        StringBuilder row = new StringBuilder("|");

        for (int i = 0; i < headers.size(); i++) {
            row.append(String.format(" %-" + widths[i] + "s |", headers.get(i)));
        }

        return row.append("\n").toString();
    }

    private String formatRows(List<List<String>> rows, int[] widths) {
        StringBuilder output = new StringBuilder();

        for (List<String> row : rows) {
            output.append("|");
            for (int i = 0; i < widths.length; i++) {
                output.append(String.format(" %-" + widths[i] + "s |", row.get(i)));
            }
            output.append("\n");
        }

        return output.toString();
    }

    private String formatError(Exception ex) {
        return "ERROR: " + ex.getMessage() + "\n\n";
    }

    private void sendResponse(Session session, String message) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}